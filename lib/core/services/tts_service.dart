import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { idle, speaking }

class TtsService {
  final FlutterTts _tts = FlutterTts();

  TtsState _state = TtsState.idle;
  TtsState get state => _state;

  final _stateController = StreamController<TtsState>.broadcast();
  Stream<TtsState> get stateStream => _stateController.stream;

  static const Map<String, String> _langMap = {
    'en': 'en-IN',
    'hi': 'hi-IN',
    'ta': 'ta-IN',
    'te': 'te-IN',
    'bn': 'bn-IN',
    'gu': 'gu-IN',
    'ml': 'ml-IN',
    'mr': 'mr-IN',
    'kn': 'kn-IN',
    'pa': 'pa-IN',
  };

  TtsService() {
    _init();
  }

  Future<void> _init() async {
    await _tts.awaitSpeakCompletion(true);
    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
    await _tts.setLanguage('en-IN');

    _tts.setCompletionHandler(_onDone);
    _tts.setCancelHandler(_onDone);
    _tts.setErrorHandler((_) => _onDone());
  }

  void _onDone() {
    if (_state != TtsState.idle) {
      _state = TtsState.idle;
      _stateController.add(_state);
    }
  }

  void _onStart() {
    _state = TtsState.speaking;
    _stateController.add(_state);
  }

  bool get isSpeaking => _state == TtsState.speaking;

  Future<void> speak(String text, {String langCode = 'en'}) async {
    await stop();

    final targetLang = _langMap[langCode];
    if (targetLang != null) {
      try {
        await _tts.setLanguage(targetLang);
      } catch (_) {
        await _tts.setLanguage('en-IN');
      }
    }

    _onStart();
    await _tts.speak(text);
    _onDone();
  }

  Future<void> stop() async {
    if (_state == TtsState.speaking) {
      await _tts.stop();
      _onDone();
    }
  }

  Future<void> setLanguage(String langCode) async {
    final mapped = _langMap[langCode] ?? 'en-IN';
    await _tts.setLanguage(mapped);
  }

  Future<void> setSpeechRate(double rate) async {
    await _tts.setSpeechRate(rate);
  }

  Future<void> setPitch(double pitch) async {
    await _tts.setPitch(pitch);
  }

  Future<void> setVolume(double volume) async {
    await _tts.setVolume(volume);
  }

  void dispose() {
    _tts.stop();
    _stateController.close();
  }
}

final ttsServiceProvider = Provider<TtsService>((ref) {
  final service = TtsService();
  ref.onDispose(service.dispose);
  return service;
});
