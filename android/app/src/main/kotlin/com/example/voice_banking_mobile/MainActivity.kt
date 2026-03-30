package com.example.voice_banking_mobile

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import android.util.Log

class MainActivity : FlutterActivity() {

    private lateinit var pipecatBridge: PipecatBridge
    private val tag = "Pipecat/MainActivity"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val messenger = flutterEngine.dartExecutor.binaryMessenger
        pipecatBridge = PipecatBridge(this)

        Log.i(tag, "configureFlutterEngine(): registering Pigeon host + event stream")
        PipecatHostApi.setUp(messenger, pipecatBridge)
        StreamEventsStreamHandler.register(messenger, pipecatBridge)
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        val messenger = flutterEngine.dartExecutor.binaryMessenger
        Log.i(tag, "cleanUpFlutterEngine(): unregistering Pigeon host")
        PipecatHostApi.setUp(messenger, null)
        super.cleanUpFlutterEngine(flutterEngine)
    }
}
