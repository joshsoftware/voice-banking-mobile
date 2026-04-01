/// High-level Flutter controller that wraps the Pigeon-generated
/// [PipecatHostApi] and the top-level [streamEvents] EventChannel function.
///
/// Exposes a typed `Stream<PipecatEvent>` and command methods.
/// All state is managed via Riverpod; UI widgets consume providers.
library;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voice_banking_mobile/core/logging/app_logger.dart';
import 'package:voice_banking_mobile/core/pipecat/generated/pipecat_api.g.dart';
import 'package:voice_banking_mobile/core/pipecat/pipecat_events.dart';

// ---------------------------------------------------------------------------
// Session chat (committed turns during a voice session)
// ---------------------------------------------------------------------------

/// One line in the in-session voice transcript (user STT or assistant reply).
final class VoiceChatMessage {
  const VoiceChatMessage({required this.isUser, required this.text});

  final bool isUser;
  final String text;
}

// ---------------------------------------------------------------------------
// Controller
// ---------------------------------------------------------------------------

class PipecatController {
  PipecatController({PipecatHostApi? hostApi})
      : _host = hostApi ?? PipecatHostApi();

  static const _tag = 'Pipecat/Controller';

  final PipecatHostApi _host;

  /// True when the next user final should append a new bubble (vs coalescing
  /// into the last user bubble). Set from [VadEvent] boundaries; see
  /// SmallWebRTC prebuilt UI transcript behavior (one line per utterance).
  bool _nextUserFinalStartsNewBubble = false;

  /// True after [VadEvent] `userStoppedSpeaking` until a new utterance opens.
  bool _userClosedUtterance = false;

  StreamSubscription<PipecatEventData>? _subscription;
  final StreamController<PipecatEvent> _controller =
      StreamController<PipecatEvent>.broadcast();

  /// Typed event stream for UI consumption.
  Stream<PipecatEvent> get events => _controller.stream;

  // -- Convenience ValueNotifiers for common UI bindings -------------------

  /// Latest user transcript (updated on every interim + final result).
  final ValueNotifier<String> userTranscript = ValueNotifier<String>('');

  /// Latest complete bot reply.
  final ValueNotifier<String> botTranscript = ValueNotifier<String>('');

  /// Current bot processing phase.
  final ValueNotifier<BotProcessingState> botState =
      ValueNotifier<BotProcessingState>(BotProcessingState.silent);

  /// Whether the user is currently speaking (VAD).
  final ValueNotifier<bool> userSpeaking = ValueNotifier<bool>(false);

  /// Accumulator for streaming LLM tokens.
  final ValueNotifier<String> llmBuffer = ValueNotifier<String>('');

  /// Committed user / assistant messages for the current session (scrollable chat).
  final ValueNotifier<List<VoiceChatMessage>> sessionChatMessages =
      ValueNotifier<List<VoiceChatMessage>>(<VoiceChatMessage>[]);

  /// Clears [sessionChatMessages] and user-turn coalescing state (e.g. new mic session).
  void clearSessionChat() {
    sessionChatMessages.value = <VoiceChatMessage>[];
    _nextUserFinalStartsNewBubble = false;
    _userClosedUtterance = false;
  }

  // -- Commands ------------------------------------------------------------

  Future<void> initialize(SessionConfig config) async {
    AppLogger.i(
      _tag,
      'initialize(baseUrl=${config.baseUrl}, enableMic=${config.enableMic}, enableCam=${config.enableCam}, headersJson=${config.requestHeadersJson == null ? '<null>' : '<redacted>'}, customBodyJson=${config.customBodyJson == null ? '<null>' : '<redacted>'})',
    );
    await _host.initialize(config);
    _listenToEvents();
  }

  Future<void> start() {
    AppLogger.i(_tag, 'start()');
    return _host.start();
  }

  Future<void> stop() async {
    AppLogger.i(_tag, 'stop()');
    await _subscription?.cancel();
    _subscription = null;
    await _host.stop();
  }

  Future<void> sendAction(String type, String dataJson) {
    AppLogger.d(_tag, 'sendAction(type=$type, dataJson=<redacted len=${dataJson.length}>)');
    return _host.sendAction(type, dataJson);
  }

  void enableMic(bool enable) {
    AppLogger.i(_tag, 'enableMic(enable=$enable)');
    _host.enableMic(enable);
  }

  void enableCam(bool enable) {
    AppLogger.i(_tag, 'enableCam(enable=$enable)');
    _host.enableCam(enable);
  }

  // -- Event stream --------------------------------------------------------

  void _listenToEvents() {
    AppLogger.i(_tag, '_listenToEvents() subscribe');
    _subscription?.cancel();
    // streamEvents() is a Pigeon-generated top-level function that returns
    // Stream<PipecatEventData> backed by a native EventChannel.
    _subscription = streamEvents().listen(
      (PipecatEventData data) {
        final event = data.toEvent();
        AppLogger.d(_tag, 'event: $event');
        _controller.add(event);
        _dispatchToNotifiers(event);
      },
      onError: (Object error, StackTrace stack) {
        AppLogger.e(_tag, 'event stream error', error: error, stack: stack);
        _controller.addError(error);
      },
      onDone: () {
        AppLogger.i(_tag, 'event stream done');
      },
    );
  }

  void _dispatchToNotifiers(PipecatEvent event) {
    switch (event) {
      case TranscriptEvent(:final text, :final isBot, :final isFinal):
        if (isBot) {
          final trimmed = text.trim();
          if (trimmed.isNotEmpty) {
            sessionChatMessages.value = [
              ...sessionChatMessages.value,
              VoiceChatMessage(isUser: false, text: trimmed),
            ];
          }
          botTranscript.value = '';
          llmBuffer.value = '';
        } else {
          userTranscript.value = text;
          if (isFinal) {
            llmBuffer.value = '';
            final trimmed = text.trim();
            if (trimmed.isNotEmpty) {
              final prev = sessionChatMessages.value;
              final list = List<VoiceChatMessage>.from(prev);
              final last = list.isEmpty ? null : list.last;
              final startNew = _nextUserFinalStartsNewBubble ||
                  last == null ||
                  !last.isUser;
              if (startNew) {
                list.add(VoiceChatMessage(isUser: true, text: trimmed));
              } else {
                list[list.length - 1] =
                    VoiceChatMessage(isUser: true, text: trimmed);
              }
              _nextUserFinalStartsNewBubble = false;
              sessionChatMessages.value = list;
            }
            userTranscript.value = '';
          }
        }

      case BotLlmTextEvent(:final text):
        llmBuffer.value += text;

      case BotStateEvent(:final state):
        botState.value = state;

      case VadEvent(:final isSpeaking):
        userSpeaking.value = isSpeaking;
        if (!isSpeaking) {
          _userClosedUtterance = true;
        } else {
          final list = sessionChatMessages.value;
          final last = list.isEmpty ? null : list.last;
          if (last == null || !last.isUser || _userClosedUtterance) {
            _nextUserFinalStartsNewBubble = true;
            _userClosedUtterance = false;
          }
        }

      case TransportStateEvent():
        break;

      case ErrorEvent():
        break;
    }
  }

  // -- Lifecycle -----------------------------------------------------------

  /// Must be called when the owning widget/provider is disposed.
  void dispose() {
    AppLogger.i(_tag, 'dispose()');
    _subscription?.cancel();
    _subscription = null;
    _controller.close();
    userTranscript.dispose();
    botTranscript.dispose();
    botState.dispose();
    userSpeaking.dispose();
    llmBuffer.dispose();
    sessionChatMessages.dispose();
  }
}

// ---------------------------------------------------------------------------
// Riverpod providers
// ---------------------------------------------------------------------------

/// Single [PipecatController] for the app so sessions are not torn down when
/// UI providers rebuild. Disposed when the root [ProviderScope] is disposed.
final pipecatControllerProvider = Provider<PipecatController>((ref) {
  final controller = PipecatController();
  ref.onDispose(controller.dispose);
  return controller;
});

/// Stream of all Pipecat events for widgets that prefer reactive listening.
final pipecatEventStreamProvider =
    StreamProvider.autoDispose<PipecatEvent>((ref) {
  final controller = ref.watch(pipecatControllerProvider);
  return controller.events;
});
