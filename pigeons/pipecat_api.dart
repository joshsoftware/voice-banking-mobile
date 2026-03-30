// Pigeon schema for the Pipecat native bridge.
//
// Generate with:
//   dart run pigeon --input pigeons/pipecat_api.dart
//
// Backend reference: voice-banking-backend/pipeline/orchestrator.py
// RTVI frames mapped: TranscriptionFrame, LLMTextFrame,
//   LLMFullResponse{Start,End}Frame, TTS{Started,Stopped}Frame, ErrorFrame

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartPackageName: 'voice_banking_mobile',
  dartOut: 'lib/core/pipecat/generated/pipecat_api.g.dart',
  kotlinOut:
      'android/app/src/main/kotlin/com/example/voice_banking_mobile/PipecatApi.g.kt',
  kotlinOptions: KotlinOptions(package: 'com.example.voice_banking_mobile'),
  swiftOut: 'ios/Runner/PipecatApi.g.swift',
))

// ---------------------------------------------------------------------------
// Enums
// ---------------------------------------------------------------------------

/// Maps to ai.pipecat.client.types.TransportState on Android / iOS.
enum PipecatTransportState {
  idle,
  initializing,
  initialized,
  authenticating,
  connecting,
  connected,
  ready,
  disconnecting,
  disconnected,
  error,
}

/// Discriminator for [PipecatEventData]. Each value corresponds to a
/// PipecatEventCallbacks method on the native SDK.
enum PipecatEventType {
  /// onUserTranscript — Whisper STT via TranscriptionFrame
  userTranscript,

  /// onBotTranscript — final bot reply text
  botTranscript,

  /// onBotLLMText — streaming LLM token chunks (LLMTextFrame)
  botLlmText,

  /// onBotLLMStarted — LLMFullResponseStartFrame
  botLlmStarted,

  /// onBotLLMStopped — LLMFullResponseEndFrame
  botLlmStopped,

  /// onBotTTSStarted — TTSStartedFrame
  botTtsStarted,

  /// onBotTTSStopped — TTSStoppedFrame
  botTtsStopped,

  /// onBotStartedSpeaking — audio playback began
  botStartedSpeaking,

  /// onBotStoppedSpeaking — audio playback ended
  botStoppedSpeaking,

  /// onUserStartedSpeaking — Silero VAD rising edge
  userStartedSpeaking,

  /// onUserStoppedSpeaking — Silero VAD falling edge
  userStoppedSpeaking,

  /// onBotReady — pipeline fully initialized
  botReady,

  /// onBotConnected
  botConnected,

  /// onBotDisconnected
  botDisconnected,

  /// onConnected — transport layer connected
  transportConnected,

  /// onDisconnected — transport layer disconnected
  transportDisconnected,

  /// onTransportStateChanged — generic state transition
  transportStateChanged,

  /// onBackendError — ErrorFrame from pipeline
  backendError,
}

// ---------------------------------------------------------------------------
// Data classes
// ---------------------------------------------------------------------------

/// Parameters required to start a Pipecat session.
///
/// [baseUrl] is the voice server origin (e.g. `https://voicebanking.example.com`).
/// The Pipecat SmallWebRTC transport calls `POST {baseUrl}/start`, then negotiates
/// SDP at `{baseUrl}/sessions/{sessionId}/api/offer` (handled inside the native SDK).
/// [customBodyJson] is a JSON-encoded string for extra parameters (avoids
/// Pigeon limitations with nested Object maps).
class SessionConfig {
  SessionConfig({
    required this.baseUrl,
    this.enableMic = true,
    this.enableCam = false,
    this.customBodyJson,
    this.requestHeadersJson,
  });

  /// Voice / SmallWebRTC server origin (scheme + host, no trailing slash).
  final String baseUrl;

  final bool enableMic;
  final bool enableCam;

  /// JSON-encoded Map<String,dynamic> of extra session parameters.
  /// Passed as `request_data` where supported by the transport.
  final String? customBodyJson;

  /// JSON object of HTTP header names to values, e.g. `{"Authorization":"Bearer …"}`.
  /// Sent on `/start` and offer POSTs when supported by the native transport.
  final String? requestHeadersJson;
}

/// Flat, Pigeon-safe event envelope streamed from native → Flutter.
///
/// The [type] discriminator determines which nullable fields are populated.
/// Flutter-side [PipecatEvent] sealed classes provide a type-safe façade.
class PipecatEventData {
  PipecatEventData({
    required this.type,
    this.text,
    this.isFinal,
    this.userId,
    this.language,
    this.timestamp,
    this.transportState,
    this.errorMessage,
  });

  final PipecatEventType type;

  /// Transcript text (user or bot) / LLM chunk text.
  final String? text;

  /// True when the transcript is finalized (not interim).
  final bool? isFinal;

  /// Participant / user ID for the transcript source.
  final String? userId;

  /// Detected language code (e.g. "en", "hi") from LanguageAnnotator.
  final String? language;

  /// ISO-8601 timestamp of the transcription.
  final String? timestamp;

  /// Populated only for [PipecatEventType.transportStateChanged].
  final PipecatTransportState? transportState;

  /// Populated only for [PipecatEventType.backendError].
  final String? errorMessage;
}

// ---------------------------------------------------------------------------
// Host API — Flutter → Native commands
// ---------------------------------------------------------------------------

/// Commands sent from Flutter to the native Pipecat SDK.
@HostApi()
abstract class PipecatHostApi {
  /// Instantiate the native PipecatClient with the given session config.
  /// Must be called before [start]. Runs SDK init on a background thread.
  @async
  void initialize(SessionConfig config);

  /// Initiate SmallWebRTC SDP handshake; bot spawns on connection.
  @async
  void start();

  /// Disconnect and release the native client resources.
  @async
  void stop();

  /// Send a typed RTVI action to the bot (future extensibility).
  /// [dataJson] is a JSON-encoded payload to avoid Pigeon Object limitations.
  @async
  void sendAction(String actionType, String dataJson);

  /// Toggle microphone on/off without tearing down the session.
  void enableMic(bool enable);

  /// Toggle camera on/off (unused for voice-only, provided for completeness).
  void enableCam(bool enable);
}

// ---------------------------------------------------------------------------
// Event Channel API — Native → Flutter real-time stream
// ---------------------------------------------------------------------------

/// Type-safe EventChannel delivering [PipecatEventData] from native SDK
/// callbacks to Flutter. Pigeon generates `Stream<PipecatEventData>` on
/// the Dart side and a StreamHandler interface on the native side.
@EventChannelApi()
abstract class PipecatEventChannelApi {
  PipecatEventData streamEvents();
}
