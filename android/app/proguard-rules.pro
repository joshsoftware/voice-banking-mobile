-dontwarn org.slf4j.impl.StaticLoggerBinder

# WebRTC Java API is accessed via JNI; do not shrink/obfuscate it.
-keep class org.webrtc.** { *; }
-dontwarn org.webrtc.**

# Pipecat / SmallWebRTC transport (keep public API and any classes loaded reflectively).
-keep class ai.pipecat.** { *; }
-dontwarn ai.pipecat.**

# Kotlin metadata / reflection safety (common in SDKs).
-keep class kotlin.Metadata { *; }
