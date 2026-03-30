package com.example.voice_banking_mobile

import ai.pipecat.client.PipecatClient
import ai.pipecat.client.PipecatClientOptions
import ai.pipecat.client.PipecatEventCallbacks
import ai.pipecat.client.small_webrtc_transport.PipecatClientSmallWebRTC
import ai.pipecat.client.small_webrtc_transport.SmallWebRTCTransport
import ai.pipecat.client.transport.MsgServerToClient
import ai.pipecat.client.types.APIRequest
import ai.pipecat.client.types.BotReadyData
import ai.pipecat.client.types.Participant
import ai.pipecat.client.types.Transcript
import ai.pipecat.client.types.TransportState
import ai.pipecat.client.types.Value
import ai.pipecat.client.result.Result as PipecatResult
import ai.pipecat.client.result.RTVIError
import android.content.Context
import android.media.AudioAttributes
import android.media.AudioDeviceInfo
import android.media.AudioFocusRequest
import android.media.AudioManager
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.Log
import org.json.JSONArray
import org.json.JSONObject

private const val TAG = "PipecatBridge"

/**
 * Android-side implementation of the Pigeon-generated [PipecatHostApi] and
 * [StreamEventsStreamHandler].
 *
 * Uses **SmallWebRTC** transport — `POST {baseUrl}/start`, then SDP at
 * `{baseUrl}/sessions/{sessionId}/api/offer` (handled inside [SmallWebRTCTransport]).
 *
 * Threading contract:
 * - All event sink pushes are dispatched on the main looper.
 * - SDK uses [PipecatClient] futures on the client thread; callbacks forward results to Flutter.
 */
class PipecatBridge(private val context: Context) :
    StreamEventsStreamHandler(),
    PipecatHostApi {

    private val mainHandler = Handler(Looper.getMainLooper())
    private var client: PipecatClientSmallWebRTC? = null
    private var eventSink: PigeonEventSink<PipecatEventData>? = null
    private var sessionConfig: SessionConfig? = null
    private var audioManager: AudioManager? = null
    private var audioFocusRequest: AudioFocusRequest? = null

    // -----------------------------------------------------------------------
    // StreamEventsStreamHandler (EventChannel)
    // -----------------------------------------------------------------------

    override fun onListen(p0: Any?, sink: PigeonEventSink<PipecatEventData>) {
        Log.i(TAG, "EventChannel onListen()")
        eventSink = sink
    }

    override fun onCancel(p0: Any?) {
        Log.i(TAG, "EventChannel onCancel()")
        eventSink = null
    }

    // -----------------------------------------------------------------------
    // PipecatHostApi
    // -----------------------------------------------------------------------

    override fun initialize(config: SessionConfig, callback: (Result<Unit>) -> Unit) {
        Log.i(
            TAG,
            "initialize(baseUrl=${config.baseUrl}, enableMic=${config.enableMic}, enableCam=${config.enableCam}, headersJson=${if (config.requestHeadersJson.isNullOrBlank()) "<null/empty>" else "<redacted>"}, customBodyJson=${if (config.customBodyJson.isNullOrBlank()) "<null/empty>" else "<redacted>"})",
        )
        sessionConfig = config

        try {
            requestAudioFocus()

            val callbacks = createEventCallbacks()
            val options = PipecatClientOptions(
                callbacks = callbacks,
                enableMic = config.enableMic,
                enableCam = config.enableCam,
            )

            val transport = SmallWebRTCTransport(context)
            client = PipecatClient(transport, options)

            callback(Result.success(Unit))
        } catch (e: Exception) {
            Log.e(TAG, "initialize failed", e)
            callback(Result.failure(e))
        }
    }

    override fun start(callback: (Result<Unit>) -> Unit) {
        Log.i(TAG, "start()")
        val currentClient = client
        val config = sessionConfig

        if (currentClient == null || config == null) {
            callback(Result.failure(IllegalStateException("Call initialize() first")))
            return
        }

        val serverUrl = config.baseUrl.trimEnd('/')
        val startEndpoint = "$serverUrl/start"
        val requestData = parseRequestData(config.customBodyJson)
        Log.i(TAG, "start(): startEndpoint=$startEndpoint, requestHeadersJson=${if (config.requestHeadersJson.isNullOrBlank()) "<null/empty>" else "<redacted>"}")

        val apiRequest = APIRequest(
            endpoint = startEndpoint,
            requestData = requestData,
            headers = parseRequestHeaders(config.requestHeadersJson),
            timeoutMs = 30_000L,
        )

        currentClient.startBotAndConnect(apiRequest).withCallback { result ->
            when (result) {
                is PipecatResult.Ok -> {
                    Log.i(TAG, "start(): success")
                    callback(Result.success(Unit))
                }
                is PipecatResult.Err -> {
                    val err = result.error
                    Log.e(TAG, "start failed: $err")
                    pushEvent(
                        PipecatEventData(
                            type = PipecatEventType.BACKEND_ERROR,
                            errorMessage = err.toString(),
                        ),
                    )
                    callback(Result.failure(rtviErrorToThrowable(err)))
                }
            }
        }
    }

    override fun stop(callback: (Result<Unit>) -> Unit) {
        Log.i(TAG, "stop()")
        try {
            val current = client
            if (current == null) {
                releaseClient()
                callback(Result.success(Unit))
                return
            }

            current.disconnect().withCallback { result ->
                when (result) {
                    is PipecatResult.Ok -> {
                        Log.i(TAG, "stop(): success")
                        releaseClient()
                        callback(Result.success(Unit))
                    }
                    is PipecatResult.Err -> {
                        Log.e(TAG, "stop(): failure ${result.error}")
                        releaseClient()
                        callback(Result.failure(rtviErrorToThrowable(result.error)))
                    }
                }
            }
        } catch (e: Exception) {
            Log.e(TAG, "stop(): exception", e)
            releaseClient()
            callback(Result.failure(e))
        }
    }

    override fun sendAction(
        actionType: String,
        dataJson: String,
        callback: (Result<Unit>) -> Unit,
    ) {
        Log.d(TAG, "sendAction(type=$actionType, dataJson=<redacted len=${dataJson.length}>)")
        val currentClient = client
        if (currentClient == null) {
            callback(Result.failure(IllegalStateException("Client not initialized")))
            return
        }

        try {
            val value: Value = if (dataJson.isBlank()) {
                Value.Null
            } else {
                val jsonObj = JSONObject(dataJson)
                jsonObjectToValue(jsonObj)
            }

            currentClient.sendClientMessage(actionType, value).withCallback { result ->
                when (result) {
                    is PipecatResult.Ok -> {
                        Log.d(TAG, "sendAction(): success")
                        callback(Result.success(Unit))
                    }
                    is PipecatResult.Err -> {
                        Log.e(TAG, "sendAction(): failure ${result.error}")
                        callback(Result.failure(rtviErrorToThrowable(result.error)))
                    }
                }
            }
        } catch (e: Exception) {
            Log.e(TAG, "sendAction(): exception", e)
            callback(Result.failure(e))
        }
    }

    override fun enableMic(enable: Boolean) {
        Log.i(TAG, "enableMic(enable=$enable)")
        client?.enableMic(enable)
    }

    override fun enableCam(enable: Boolean) {
        Log.i(TAG, "enableCam(enable=$enable)")
        client?.enableCam(enable)
    }

    // -----------------------------------------------------------------------
    // PipecatEventCallbacks → EventSink bridge
    // -----------------------------------------------------------------------

    private fun createEventCallbacks(): PipecatEventCallbacks =
        object : PipecatEventCallbacks() {

            override fun onBackendError(message: String) {
                Log.e(TAG, "onBackendError(message=${message.take(120)})")
                pushEvent(
                    PipecatEventData(
                        type = PipecatEventType.BACKEND_ERROR,
                        errorMessage = message,
                    ),
                )
            }

            override fun onBotReady(data: BotReadyData) {
                Log.i(TAG, "onBotReady()")
                pushEvent(PipecatEventData(type = PipecatEventType.BOT_READY))
            }

            override fun onBotConnected(participant: Participant) {
                Log.i(TAG, "onBotConnected(id=${participant.id ?: "?"})")
                pushEvent(PipecatEventData(type = PipecatEventType.BOT_CONNECTED))
            }

            override fun onBotDisconnected(participant: Participant) {
                Log.i(TAG, "onBotDisconnected(id=${participant.id ?: "?"})")
                pushEvent(PipecatEventData(type = PipecatEventType.BOT_DISCONNECTED))
            }

            override fun onConnected() {
                Log.i(TAG, "onConnected()")
                pushEvent(PipecatEventData(type = PipecatEventType.TRANSPORT_CONNECTED))
            }

            override fun onDisconnected() {
                Log.i(TAG, "onDisconnected()")
                pushEvent(PipecatEventData(type = PipecatEventType.TRANSPORT_DISCONNECTED))
            }

            override fun onTransportStateChanged(state: TransportState) {
                Log.d(TAG, "onTransportStateChanged(state=$state)")
                pushEvent(
                    PipecatEventData(
                        type = PipecatEventType.TRANSPORT_STATE_CHANGED,
                        transportState = state.toPigeon(),
                    ),
                )
            }

            override fun onUserTranscript(data: Transcript) {
                Log.d(
                    TAG,
                    "onUserTranscript(final=${data.`final`}, userId=${data.userId ?: "?"}, text=<redacted len=${data.text?.length ?: 0}>)",
                )
                pushEvent(
                    PipecatEventData(
                        type = PipecatEventType.USER_TRANSCRIPT,
                        text = data.text,
                        isFinal = data.`final`,
                        userId = data.userId,
                    ),
                )
            }

            @Deprecated("SDK callback deprecated; still bridged for Pigeon events")
            override fun onBotTranscript(text: String) {
                Log.d(TAG, "onBotTranscript(text=<redacted len=${text.length}>)")
                pushEvent(
                    PipecatEventData(
                        type = PipecatEventType.BOT_TRANSCRIPT,
                        text = text,
                        isFinal = true,
                    ),
                )
            }

            override fun onBotLLMText(data: MsgServerToClient.Data.BotLLMTextData) {
                Log.d(TAG, "onBotLLMText(text=<redacted len=${data.text.length}>)")
                pushEvent(
                    PipecatEventData(
                        type = PipecatEventType.BOT_LLM_TEXT,
                        text = data.text,
                    ),
                )
            }

            override fun onBotLLMStarted() {
                Log.i(TAG, "onBotLLMStarted()")
                pushEvent(PipecatEventData(type = PipecatEventType.BOT_LLM_STARTED))
            }

            override fun onBotLLMStopped() {
                Log.i(TAG, "onBotLLMStopped()")
                pushEvent(PipecatEventData(type = PipecatEventType.BOT_LLM_STOPPED))
            }

            override fun onBotTTSStarted() {
                Log.i(TAG, "onBotTTSStarted()")
                pushEvent(PipecatEventData(type = PipecatEventType.BOT_TTS_STARTED))
            }

            override fun onBotTTSStopped() {
                Log.i(TAG, "onBotTTSStopped()")
                pushEvent(PipecatEventData(type = PipecatEventType.BOT_TTS_STOPPED))
            }

            override fun onBotStartedSpeaking() {
                Log.i(TAG, "onBotStartedSpeaking()")
                pushEvent(PipecatEventData(type = PipecatEventType.BOT_STARTED_SPEAKING))
            }

            override fun onBotStoppedSpeaking() {
                Log.i(TAG, "onBotStoppedSpeaking()")
                pushEvent(PipecatEventData(type = PipecatEventType.BOT_STOPPED_SPEAKING))
            }

            override fun onUserStartedSpeaking() {
                Log.i(TAG, "onUserStartedSpeaking()")
                pushEvent(PipecatEventData(type = PipecatEventType.USER_STARTED_SPEAKING))
            }

            override fun onUserStoppedSpeaking() {
                Log.i(TAG, "onUserStoppedSpeaking()")
                pushEvent(PipecatEventData(type = PipecatEventType.USER_STOPPED_SPEAKING))
            }
        }

    // -----------------------------------------------------------------------
    // Audio focus (handles interruptions like incoming phone calls)
    // -----------------------------------------------------------------------

    private fun requestAudioFocus() {
        audioManager = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val attrs = AudioAttributes.Builder()
                .setUsage(AudioAttributes.USAGE_VOICE_COMMUNICATION)
                .setContentType(AudioAttributes.CONTENT_TYPE_SPEECH)
                .build()

            audioFocusRequest = AudioFocusRequest.Builder(AudioManager.AUDIOFOCUS_GAIN)
                .setAudioAttributes(attrs)
                .setOnAudioFocusChangeListener(audioFocusListener)
                .build()

            audioManager?.requestAudioFocus(audioFocusRequest!!)
        }

        // WebRTC + VOICE_COMMUNICATION often routes playback to the earpiece (quiet).
        // Use the main loudspeaker so bot TTS is audible; volume is then "in-call" stream.
        audioManager?.mode = AudioManager.MODE_IN_COMMUNICATION
        routeVoicePlaybackToSpeaker()
    }

    /**
     * Sends WebRTC voice playback to the device loudspeaker instead of the earpiece.
     */
    private fun routeVoicePlaybackToSpeaker() {
        val am = audioManager ?: return
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            val speaker = am.availableCommunicationDevices.firstOrNull { device ->
                device.type == AudioDeviceInfo.TYPE_BUILTIN_SPEAKER
            }
            if (speaker != null && am.setCommunicationDevice(speaker)) {
                Log.i(TAG, "routeVoicePlaybackToSpeaker: setCommunicationDevice(BUILTIN_SPEAKER)")
            } else {
                @Suppress("DEPRECATION")
                am.setSpeakerphoneOn(true)
                Log.w(TAG, "routeVoicePlaybackToSpeaker: setSpeakerphoneOn(true) fallback")
            }
        } else {
            @Suppress("DEPRECATION")
            am.setSpeakerphoneOn(true)
            Log.i(TAG, "routeVoicePlaybackToSpeaker: setSpeakerphoneOn(true)")
        }
    }

    private fun resetVoiceAudioRouting() {
        val am = audioManager ?: return
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            am.clearCommunicationDevice()
        } else {
            @Suppress("DEPRECATION")
            am.setSpeakerphoneOn(false)
        }
        am.mode = AudioManager.MODE_NORMAL
        Log.i(TAG, "resetVoiceAudioRouting()")
    }

    private val audioFocusListener = AudioManager.OnAudioFocusChangeListener { focusChange ->
        when (focusChange) {
            AudioManager.AUDIOFOCUS_LOSS,
            AudioManager.AUDIOFOCUS_LOSS_TRANSIENT -> {
                Log.i(TAG, "Audio focus lost — muting mic")
                client?.enableMic(false)
            }
            AudioManager.AUDIOFOCUS_GAIN -> {
                Log.i(TAG, "Audio focus regained — unmuting mic")
                client?.enableMic(true)
            }
        }
    }

    private fun abandonAudioFocus() {
        resetVoiceAudioRouting()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            audioFocusRequest?.let { audioManager?.abandonAudioFocusRequest(it) }
        }
        audioFocusRequest = null
        audioManager = null
    }

    // -----------------------------------------------------------------------
    // Helpers
    // -----------------------------------------------------------------------

    private fun pushEvent(event: PipecatEventData) {
        Log.v(TAG, "pushEvent(type=${event.type})")
        mainHandler.post { eventSink?.success(event) }
    }

    private fun releaseClient() {
        Log.i(TAG, "releaseClient()")
        client?.release()
        client = null
        abandonAudioFocus()
    }
}

private fun rtviErrorToThrowable(err: RTVIError): Throwable =
    err.exception ?: RuntimeException(err.description)

/**
 * JSON object `{"Header-Name":"value"}` → map for [APIRequest.headers].
 */
private fun parseRequestHeaders(json: String?): Map<String, String> {
    if (json.isNullOrBlank()) return emptyMap()
    return try {
        val obj = JSONObject(json)
        buildMap {
            val keys = obj.keys()
            while (keys.hasNext()) {
                val key = keys.next()
                put(key, obj.optString(key))
            }
        }
    } catch (e: Exception) {
        Log.w(TAG, "parseRequestHeaders failed", e)
        emptyMap()
    }
}

/**
 * POST body for `/start`: empty JSON object, or [SessionConfig.customBodyJson] parsed to [Value].
 */
private fun parseRequestData(customJson: String?): Value {
    if (customJson.isNullOrBlank()) {
        return Value.Object()
    }
    return try {
        jsonObjectToValue(JSONObject(customJson))
    } catch (e: Exception) {
        Value.Object()
    }
}

private fun jsonObjectToValue(json: JSONObject): Value {
    val map = mutableMapOf<String, Value>()
    val keys = json.keys()
    while (keys.hasNext()) {
        val key = keys.next()
        map[key] = jsonValueToValue(json.get(key))
    }
    return Value.Object(map)
}

private fun jsonValueToValue(v: Any?): Value = when (v) {
    null -> Value.Null
    is String -> Value.Str(v)
    is Boolean -> Value.Bool(v)
    is Double -> Value.Number(v)
    is Float -> Value.Number(v.toDouble())
    is Int -> Value.Number(v.toDouble())
    is Long -> Value.Number(v.toDouble())
    is JSONObject -> jsonObjectToValue(v)
    is JSONArray -> {
        val list = buildList {
            for (i in 0 until v.length()) {
                add(jsonValueToValue(v.get(i)))
            }
        }
        Value.Array(list)
    }
    else -> Value.Str(v.toString())
}

// ---------------------------------------------------------------------------
// TransportState → Pigeon enum mapping (Pipecat client 1.1.x)
// ---------------------------------------------------------------------------

private fun TransportState.toPigeon(): PipecatTransportState = when (this) {
    TransportState.Disconnected -> PipecatTransportState.DISCONNECTED
    TransportState.Initializing -> PipecatTransportState.INITIALIZING
    TransportState.Initialized -> PipecatTransportState.INITIALIZED
    TransportState.Authorizing -> PipecatTransportState.AUTHENTICATING
    TransportState.Authorized -> PipecatTransportState.CONNECTING
    TransportState.Connecting -> PipecatTransportState.CONNECTING
    TransportState.Connected -> PipecatTransportState.CONNECTED
    TransportState.Ready -> PipecatTransportState.READY
    TransportState.Error -> PipecatTransportState.ERROR
}
