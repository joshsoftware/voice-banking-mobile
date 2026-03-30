/// Type-safe sealed-class façade over the Pigeon-generated [PipecatEventData].
///
/// These classes are what the Flutter UI layer should pattern-match against.
/// The raw Pigeon envelope is converted via [PipecatEventMapper.fromData].
library;

import 'package:voice_banking_mobile/core/pipecat/generated/pipecat_api.g.dart';

// ---------------------------------------------------------------------------
// Bot processing state (higher-level than raw transport state)
// ---------------------------------------------------------------------------

/// Represents the current phase of bot processing, derived from multiple
/// RTVI event callbacks. Maps to the backend pipeline stages:
///   Whisper STT → LangGraph LLM → NLLB Translation → MMS-TTS → Audio out
enum BotProcessingState {
  /// Pipeline fully initialized (onBotReady)
  ready,

  /// Bot participant joined the session
  connected,

  /// Bot participant left the session
  disconnected,

  /// LLM inference started (LLMFullResponseStartFrame)
  llmProcessing,

  /// LLM inference completed (LLMFullResponseEndFrame)
  llmDone,

  /// TTS synthesis started (TTSStartedFrame)
  ttsSynthesizing,

  /// TTS synthesis completed (TTSStoppedFrame)
  ttsDone,

  /// Audio is being played back to the user
  speaking,

  /// Audio playback stopped
  silent,
}

// ---------------------------------------------------------------------------
// Sealed event hierarchy
// ---------------------------------------------------------------------------

sealed class PipecatEvent {
  const PipecatEvent();
}

/// User or bot transcript.
///
/// For user transcripts: [text] is Whisper STT output, [isFinal] indicates
/// whether the segment is finalized, [language] comes from the backend
/// LanguageAnnotator (e.g. "en", "hi").
///
/// For bot transcripts: [text] is the complete bot reply, [isFinal] is
/// always true, [isBot] is true.
final class TranscriptEvent extends PipecatEvent {
  const TranscriptEvent({
    required this.text,
    required this.isFinal,
    required this.isBot,
    this.userId,
    this.language,
    this.timestamp,
  });

  final String text;
  final bool isFinal;
  final bool isBot;
  final String? userId;
  final String? language;
  final String? timestamp;

  @override
  String toString() =>
      'TranscriptEvent(isBot=$isBot, isFinal=$isFinal, text="${text.length > 40 ? '${text.substring(0, 40)}…' : text}")';
}

/// Streaming LLM token chunk (partial bot response).
///
/// Corresponds to LLMTextFrame in the backend pipeline.
final class BotLlmTextEvent extends PipecatEvent {
  const BotLlmTextEvent({required this.text});

  final String text;

  @override
  String toString() => 'BotLlmTextEvent(text="${text.length > 40 ? '${text.substring(0, 40)}…' : text}")';
}

/// Bot processing state transition.
final class BotStateEvent extends PipecatEvent {
  const BotStateEvent({required this.state});

  final BotProcessingState state;

  @override
  String toString() => 'BotStateEvent(state=$state)';
}

/// Voice activity detection event from Silero VAD.
final class VadEvent extends PipecatEvent {
  const VadEvent({required this.isSpeaking});

  final bool isSpeaking;

  @override
  String toString() => 'VadEvent(isSpeaking=$isSpeaking)';
}

/// Transport-level state change (lower level than [BotStateEvent]).
final class TransportStateEvent extends PipecatEvent {
  const TransportStateEvent({required this.state});

  final PipecatTransportState state;

  @override
  String toString() => 'TransportStateEvent(state=$state)';
}

/// Error from the backend pipeline (ErrorFrame) or SDK.
final class ErrorEvent extends PipecatEvent {
  const ErrorEvent({required this.message});

  final String message;

  @override
  String toString() => 'ErrorEvent(message=$message)';
}

// ---------------------------------------------------------------------------
// Mapper: Pigeon envelope → sealed class
// ---------------------------------------------------------------------------

extension PipecatEventMapper on PipecatEventData {
  PipecatEvent toEvent() => switch (type) {
        PipecatEventType.userTranscript => TranscriptEvent(
            text: text ?? '',
            isFinal: isFinal ?? true,
            isBot: false,
            userId: userId,
            language: language,
            timestamp: timestamp,
          ),
        PipecatEventType.botTranscript => TranscriptEvent(
            text: text ?? '',
            isFinal: true,
            isBot: true,
            userId: userId,
            language: language,
            timestamp: timestamp,
          ),
        PipecatEventType.botLlmText => BotLlmTextEvent(text: text ?? ''),
        PipecatEventType.botLlmStarted =>
          const BotStateEvent(state: BotProcessingState.llmProcessing),
        PipecatEventType.botLlmStopped =>
          const BotStateEvent(state: BotProcessingState.llmDone),
        PipecatEventType.botTtsStarted =>
          const BotStateEvent(state: BotProcessingState.ttsSynthesizing),
        PipecatEventType.botTtsStopped =>
          const BotStateEvent(state: BotProcessingState.ttsDone),
        PipecatEventType.botStartedSpeaking =>
          const BotStateEvent(state: BotProcessingState.speaking),
        PipecatEventType.botStoppedSpeaking =>
          const BotStateEvent(state: BotProcessingState.silent),
        PipecatEventType.userStartedSpeaking =>
          const VadEvent(isSpeaking: true),
        PipecatEventType.userStoppedSpeaking =>
          const VadEvent(isSpeaking: false),
        PipecatEventType.botReady =>
          const BotStateEvent(state: BotProcessingState.ready),
        PipecatEventType.botConnected =>
          const BotStateEvent(state: BotProcessingState.connected),
        PipecatEventType.botDisconnected =>
          const BotStateEvent(state: BotProcessingState.disconnected),
        PipecatEventType.transportConnected =>
          const TransportStateEvent(state: PipecatTransportState.connected),
        PipecatEventType.transportDisconnected =>
          const TransportStateEvent(state: PipecatTransportState.disconnected),
        PipecatEventType.transportStateChanged => TransportStateEvent(
            state: transportState ?? PipecatTransportState.idle,
          ),
        PipecatEventType.backendError =>
          ErrorEvent(message: errorMessage ?? 'Unknown backend error'),
      };
}
