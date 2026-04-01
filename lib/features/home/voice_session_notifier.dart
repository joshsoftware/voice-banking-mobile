import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_config.dart';
import '../../core/logging/app_logger.dart';
import '../../core/pipecat/generated/pipecat_api.g.dart';
import '../../core/pipecat/pipecat_controller.dart';
import '../../core/pipecat/pipecat_events.dart';

/// UI state for the home voice assistant (mic session with Pipecat backend).
class VoiceSessionState {
  const VoiceSessionState({
    this.isActive = false,
    this.isBusy = false,
    this.lastError,
  });

  final bool isActive;
  final bool isBusy;
  final String? lastError;

  VoiceSessionState copyWith({
    bool? isActive,
    bool? isBusy,
    String? lastError,
    bool clearError = false,
  }) {
    return VoiceSessionState(
      isActive: isActive ?? this.isActive,
      isBusy: isBusy ?? this.isBusy,
      lastError: clearError ? null : (lastError ?? this.lastError),
    );
  }
}

final voiceSessionProvider =
    NotifierProvider.autoDispose<VoiceSessionNotifier, VoiceSessionState>(
  VoiceSessionNotifier.new,
);

/// Mic input muted for the current session (native `enableMic(false)`).
final voiceMicMutedProvider = StateProvider<bool>((ref) => false);

void _resetPipecatLiveVoiceUi(PipecatController c) {
  c.userTranscript.value = '';
  c.botTranscript.value = '';
  c.llmBuffer.value = '';
  c.botState.value = BotProcessingState.silent;
  c.userSpeaking.value = false;
}

void _clearPipecatSessionChat(PipecatController c) {
  c.clearSessionChat();
}

class VoiceSessionNotifier extends AutoDisposeNotifier<VoiceSessionState> {
  static const _tag = 'Pipecat/VoiceSessionVM';

  @override
  VoiceSessionState build() {
    ref.onDispose(() {
      AppLogger.i(_tag, 'dispose() -> controller.stop()');
      unawaited(ref.read(pipecatControllerProvider).stop());
    });
    return const VoiceSessionState();
  }

  /// Starts Pipecat (`/start` + WebRTC) or stops an active session (toggle).
  Future<void> toggleMicSession() async {
    final controller = ref.read(pipecatControllerProvider);

    if (state.isActive) {
      AppLogger.i(_tag, 'toggleMicSession(): stop requested');
      state = state.copyWith(isBusy: true, clearError: true);
      try {
        await controller.stop();
        AppLogger.i(_tag, 'stop(): success');
        ref.read(voiceMicMutedProvider.notifier).state = false;
        _resetPipecatLiveVoiceUi(controller);
        state = state.copyWith(isActive: false, isBusy: false);
      } catch (e, st) {
        AppLogger.e(_tag, 'stop(): failure', error: e, stack: st);
        state = state.copyWith(isBusy: false, lastError: e.toString());
      }
      return;
    }

    AppLogger.i(_tag, 'toggleMicSession(): start requested');
    state = state.copyWith(isBusy: true, clearError: true);
    ref.read(voiceMicMutedProvider.notifier).state = false;
    _resetPipecatLiveVoiceUi(controller);
    _clearPipecatSessionChat(controller);
    try {
      final headersJson = AppConfig.pipecatRequestHeadersJson.trim().isEmpty
          ? null
          : AppConfig.pipecatRequestHeadersJson;
      AppLogger.i(
        _tag,
        'initialize(): baseUrl=${AppConfig.pipecatBaseUrl}, headersJson=${headersJson == null ? '<null>' : '<redacted>'}',
      );
      await controller.initialize(
        SessionConfig(
          baseUrl: AppConfig.pipecatBaseUrl,
          enableMic: true,
          enableCam: false,
          requestHeadersJson: headersJson,
        ),
      );
      AppLogger.i(_tag, 'start()');
      await controller.start();
      AppLogger.i(_tag, 'start(): success');
      ref.read(voiceMicMutedProvider.notifier).state = false;
      controller.enableMic(true);
      state = state.copyWith(isActive: true, isBusy: false);
    } catch (e, st) {
      AppLogger.e(_tag, 'start(): failure', error: e, stack: st);
      state = state.copyWith(isBusy: false, lastError: e.toString());
    }
  }
}
