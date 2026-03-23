import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/tts_service.dart';

class VoiceConsentState {
  final bool isConsentGiven;
  final bool isSpeaking;

  const VoiceConsentState({
    this.isConsentGiven = false,
    this.isSpeaking = false,
  });

  VoiceConsentState copyWith({
    bool? isConsentGiven,
    bool? isSpeaking,
  }) =>
      VoiceConsentState(
        isConsentGiven: isConsentGiven ?? this.isConsentGiven,
        isSpeaking: isSpeaking ?? this.isSpeaking,
      );
}

class VoiceConsentViewModel extends AutoDisposeNotifier<VoiceConsentState> {
  late final TtsService _tts;
  StreamSubscription<TtsState>? _ttsSub;

  @override
  VoiceConsentState build() {
    _tts = ref.read(ttsServiceProvider);

    _ttsSub = _tts.stateStream.listen((ttsState) {
      final speaking = ttsState == TtsState.speaking;
      if (state.isSpeaking != speaking) {
        state = state.copyWith(isSpeaking: speaking);
      }
    });

    ref.onDispose(() {
      _ttsSub?.cancel();
      _tts.stop();
    });

    return const VoiceConsentState();
  }

  void toggleConsent() {
    state = state.copyWith(isConsentGiven: !state.isConsentGiven);
  }

  Future<void> toggleSpeak({
    required String enableVoiceBanking,
    required String secureAccountWithVoice,
    required String enhancedSecurity,
    required String enhancedSecurityDesc,
    required String quickCommands,
    required String quickCommandsDesc,
    required String threeSimpleSteps,
    required String threeSimpleStepsDesc,
  }) async {
    if (state.isSpeaking) {
      await _tts.stop();
      return;
    }

    final text = '$enableVoiceBanking. '
        '$secureAccountWithVoice. '
        '$enhancedSecurity. $enhancedSecurityDesc. '
        '$quickCommands. $quickCommandsDesc. '
        '$threeSimpleSteps. $threeSimpleStepsDesc.';

    await _tts.speak(text);
  }
}

final voiceConsentViewModelProvider = NotifierProvider.autoDispose<
    VoiceConsentViewModel,
    VoiceConsentState>(VoiceConsentViewModel.new);
