import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record/record.dart';

import '../../core/constants/app_assets.dart';
import '../../core/services/tts_service.dart';
import '../../core/services/voice_registration_repository.dart';
import 'voice_registration_state.dart';

const int kMaxRecordingSeconds = 15;
const int kMinRecordingSeconds = 5;

/// dBFS threshold for speech detection.
const double _speechThreshold = -20;

/// Consecutive amplitude samples above threshold to confirm speech.
const int _minConsecutiveForSpeech = 2;

final voiceRegistrationRepositoryProvider =
    Provider<VoiceRegistrationRepository>((ref) => VoiceRegistrationRepository());

final voiceRegistrationViewModelProvider = NotifierProvider.autoDispose<
    VoiceRegistrationViewModel, AsyncValue<VoiceRegistrationState>>(
    VoiceRegistrationViewModel.new);

class VoiceRegistrationViewModel
    extends AutoDisposeNotifier<AsyncValue<VoiceRegistrationState>> {
  final AudioRecorder _recorder = AudioRecorder();
  Timer? _recordingLimitTimer;
  StreamSubscription<Amplitude>? _amplitudeSubscription;
  bool _hasSpoken = false;
  int _consecutiveAboveThreshold = 0;

  @override
  AsyncValue<VoiceRegistrationState> build() {
    ref.onDispose(_dispose);
    return const AsyncValue.loading();
  }

  Future<void> _dispose() async {
    _recordingLimitTimer?.cancel();
    await _amplitudeSubscription?.cancel();
    try {
      if (await _recorder.isRecording()) await _recorder.stop();
    } catch (_) {}
    try {
      ref.read(ttsServiceProvider).stop();
    } catch (_) {}
  }

  /// Initialize with localized descriptions. Call after build.
  Future<void> initialize(List<String> localizedDescriptions) async {
    state = const AsyncValue.loading();
    final selected = _getRandomImagesAndDescriptions(localizedDescriptions);
    state = AsyncValue.data(VoiceRegistrationState(
      currentImageIndex: 0,
      isRecording: false,
      isTTSPlaying: false,
      isUploading: false,
      recordedFilePaths: ['', '', ''],
      selectedImagePaths: selected.map((e) => e['path']!).toList(),
      selectedImageDescriptions: selected.map((e) => e['desc']!).toList(),
    ));
  }

  List<Map<String, String>> _getRandomImagesAndDescriptions(
      List<String> localizedDescriptions) {
    final random = Random();
    final indices =
        List<int>.generate(AppAssets.voiceRegistrationImages.length, (i) => i)
          ..shuffle(random);
    return indices
        .take(3)
        .map((i) => {
              'path': AppAssets.voiceRegistrationImages[i],
              'desc': localizedDescriptions[i],
            })
        .toList();
  }

  void _emit(VoiceRegistrationState newState) {
    state = AsyncValue.data(newState);
  }

  VoiceRegistrationState? get _current {
    return state.valueOrNull;
  }

  Future<void> startRecording() async {
    final s = _current;
    if (s == null || s.isRecording || s.isTTSPlaying) return;

    if (s.isTTSPlaying) {
      _emit(s.copyWith(errorMessage: 'Please wait for the description to finish playing.'));
      return;
    }

    try {
      final hasPermission = await _recorder.hasPermission();
      if (!hasPermission) {
        _emit(s.copyWith(
            errorMessage: 'Microphone permission is required. Please enable it in Settings.'));
        return;
      }

      await ref.read(ttsServiceProvider).stop();

      final path = await getVoiceRecordingPath(s.currentImageIndex);
      await _recorder.start(
        const RecordConfig(encoder: AudioEncoder.wav, sampleRate: 16000),
        path: path,
      );

      _hasSpoken = false;
      _consecutiveAboveThreshold = 0;
      _amplitudeSubscription?.cancel();
      _amplitudeSubscription = _recorder
          .onAmplitudeChanged(const Duration(milliseconds: 500))
          .listen((amp) {
        final isSilent = amp.current <= _speechThreshold;
        if (!isSilent) {
          _consecutiveAboveThreshold++;
          if (_consecutiveAboveThreshold >= _minConsecutiveForSpeech) {
            _hasSpoken = true;
          }
        } else {
          _consecutiveAboveThreshold = 0;
        }
      });

      _emit(s.copyWith(
        isRecording: true,
        errorMessage: null,
        recordingStartedAt: DateTime.now(),
      ));

      _recordingLimitTimer?.cancel();
      _recordingLimitTimer =
          Timer(const Duration(seconds: kMaxRecordingSeconds), stopRecording);
    } catch (e) {
      _emit(s.copyWith(
        isRecording: false,
        errorMessage: 'Failed to start recording: ${e.toString()}',
      ));
    }
  }

  Future<void> stopRecording() async {
    final s = _current;
    if (s == null || !s.isRecording) return;

    _recordingLimitTimer?.cancel();
    _recordingLimitTimer = null;
    await _amplitudeSubscription?.cancel();
    _amplitudeSubscription = null;

    try {
      final path = await _recorder.stop();

      if (path == null || path.isEmpty) {
        _emit(s.copyWith(
          isRecording: false,
          errorMessage: 'Recording failed. Please try again.',
          recordingStartedAt: null,
        ));
        return;
      }

      final file = File(path);
      if (!await file.exists()) {
        _emit(s.copyWith(
          isRecording: false,
          errorMessage: 'Recording file not found. Please try again.',
          recordingStartedAt: null,
        ));
        return;
      }

      if (await file.length() == 0) {
        _emit(s.copyWith(
          isRecording: false,
          errorMessage: 'Recording is empty. Please try again.',
          recordingStartedAt: null,
        ));
        return;
      }

      final startedAt = s.recordingStartedAt;
      if (startedAt != null) {
        final durationSec = DateTime.now().difference(startedAt).inSeconds;
        if (durationSec < kMinRecordingSeconds) {
          _emit(s.copyWith(
            isRecording: false,
            errorMessage: 'Please speak for at least $kMinRecordingSeconds seconds.',
            recordingStartedAt: null,
          ));
          return;
        }
      }

      if (!_hasSpoken) {
        _emit(s.copyWith(
          isRecording: false,
          errorMessage: 'Please speak something.',
          recordingStartedAt: null,
        ));
        return;
      }

      final paths = List<String>.from(s.recordedFilePaths);
      paths[s.currentImageIndex] = path;

      _emit(s.copyWith(
        isRecording: false,
        recordedFilePaths: paths,
        errorMessage: null,
        recordingStartedAt: null,
      ));
    } catch (e) {
      _emit(s.copyWith(
        isRecording: false,
        errorMessage: 'Failed to stop recording: ${e.toString()}',
        recordingStartedAt: null,
      ));
    }
  }

  Future<void> reRecord() async {
    final s = _current;
    if (s == null) return;

    if (s.isRecording) {
      try {
        await _amplitudeSubscription?.cancel();
        _amplitudeSubscription = null;
        await _recorder.stop();
      } catch (_) {}
    }

    if (s.isTTSPlaying) {
      await ref.read(ttsServiceProvider).stop();
    }

    final paths = List<String>.from(s.recordedFilePaths);
    paths[s.currentImageIndex] = '';

    try {
      final hasPermission = await _recorder.hasPermission();
      if (!hasPermission) {
        _emit(s.copyWith(
          isRecording: false,
          isTTSPlaying: false,
          recordedFilePaths: paths,
          errorMessage: 'Microphone permission is required. Please enable it in Settings.',
        ));
        return;
      }

      final path = await getVoiceRecordingPath(s.currentImageIndex);
      await _recorder.start(
        const RecordConfig(encoder: AudioEncoder.wav, sampleRate: 16000),
        path: path,
      );

      _hasSpoken = false;
      _consecutiveAboveThreshold = 0;
      _amplitudeSubscription?.cancel();
      _amplitudeSubscription = _recorder
          .onAmplitudeChanged(const Duration(milliseconds: 500))
          .listen((amp) {
        if (amp.current > _speechThreshold) {
          _consecutiveAboveThreshold++;
          if (_consecutiveAboveThreshold >= _minConsecutiveForSpeech) {
            _hasSpoken = true;
          }
        } else {
          _consecutiveAboveThreshold = 0;
        }
      });

      _emit(s.copyWith(
        isRecording: true,
        isTTSPlaying: false,
        recordedFilePaths: paths,
        errorMessage: null,
        recordingStartedAt: DateTime.now(),
      ));

      _recordingLimitTimer?.cancel();
      _recordingLimitTimer =
          Timer(const Duration(seconds: kMaxRecordingSeconds), stopRecording);
    } catch (e) {
      _emit(s.copyWith(
        isRecording: false,
        isTTSPlaying: false,
        recordedFilePaths: paths,
        errorMessage: 'Failed to start recording: ${e.toString()}',
      ));
    }
  }

  Future<void> playTTS(String localeCode) async {
    final s = _current;
    if (s == null || s.isRecording || s.isTTSPlaying) return;

    if (s.isRecording) {
      _emit(s.copyWith(
          errorMessage: 'Please stop recording before playing the description.'));
      return;
    }

    try {
      _emit(s.copyWith(isTTSPlaying: true, errorMessage: null));

      final desc = s.currentImageIndex < s.selectedImageDescriptions.length
          ? s.selectedImageDescriptions[s.currentImageIndex]
          : '';
      if (desc.isEmpty) {
        _emit(s.copyWith(isTTSPlaying: false));
        return;
      }

      await ref.read(ttsServiceProvider).speak(desc, langCode: localeCode);
      _emit(s.copyWith(isTTSPlaying: false));
    } catch (e) {
      _emit(s.copyWith(
        isTTSPlaying: false,
        errorMessage: 'Failed to play description: ${e.toString()}',
      ));
    }
  }

  Future<void> stopTTS() async {
    final s = _current;
    if (s == null || !s.isTTSPlaying) return;

    try {
      await ref.read(ttsServiceProvider).stop();
      _emit(s.copyWith(isTTSPlaying: false, errorMessage: null));
    } catch (e) {
      _emit(s.copyWith(
        isTTSPlaying: false,
        errorMessage: 'Failed to stop description: ${e.toString()}',
      ));
    }
  }

  void nextImage() {
    final s = _current;
    if (s == null || s.currentImageIndex >= 2) return;
    if (!s.hasCurrentRecording) {
      _emit(s.copyWith(
          errorMessage: 'Please record your voice before proceeding.'));
      return;
    }
    if (s.isRecording || s.isTTSPlaying) {
      _emit(s.copyWith(
          errorMessage:
              'Please wait for recording or description to complete.'));
      return;
    }
    _emit(s.copyWith(
      currentImageIndex: s.currentImageIndex + 1,
      errorMessage: null,
    ));
  }

  Future<void> submitVoiceRegistration() async {
    final s = _current;
    if (s == null || !s.allRecordingsComplete) {
      _emit(s!.copyWith(
          errorMessage: 'Please complete all 3 recordings before submitting.'));
      return;
    }

    if (s.isRecording) {
      try {
        await _recorder.stop();
      } catch (_) {}
    }
    if (s.isTTSPlaying) {
      await ref.read(ttsServiceProvider).stop();
    }

    _emit(s.copyWith(
      isUploading: true,
      isRecording: false,
      isTTSPlaying: false,
      errorMessage: null,
    ));

    try {
      final repo = ref.read(voiceRegistrationRepositoryProvider);
      final a1 = File(s.recordedFilePaths[0]);
      final a2 = File(s.recordedFilePaths[1]);
      final a3 = File(s.recordedFilePaths[2]);

      if (!await a1.exists() || !await a2.exists() || !await a3.exists()) {
        _emit(s.copyWith(
          isUploading: false,
          errorMessage: 'One or more recording files are missing.',
        ));
        return;
      }

      await repo.registerVoice(audio1: a1, audio2: a2, audio3: a3);

      _emit(s.copyWith(
        isUploading: false,
        uploadSuccess: true,
        errorMessage: null,
      ));
    } catch (e) {
      _emit(s.copyWith(
        isUploading: false,
        uploadSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void clearErrorMessage() {
    final s = _current;
    if (s != null && s.errorMessage != null) {
      _emit(s.copyWith(errorMessage: null));
    }
  }
}
