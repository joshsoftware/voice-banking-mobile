import 'dart:io';
import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../constants/app_config.dart';

import 'package:android_id/android_id.dart';

/// Repository for voice registration (enrollment) API.
/// Uploads 3 audio files to create voiceprint.
class VoiceRegistrationRepository {
  late final Dio _dio;

  VoiceRegistrationRepository() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConfig.voiceprintEnrollBaseUrl,
      connectTimeout: const Duration(seconds: 300),
      receiveTimeout: const Duration(seconds: 300),
      sendTimeout: const Duration(seconds: 300),
      headers: {
        'Content-Type': 'multipart/form-data',
        if (AppConfig.voiceprintApiKey.isNotEmpty)
          'X-API-Key': AppConfig.voiceprintApiKey,
      },
    ));
  }

  /// Registers voice with 3 audio files. Throws on failure.
  Future<void> registerVoice({
    required File audio1,
    required File audio2,
    required File audio3,
  }) async {
    if (!await audio1.exists() ||
        !await audio2.exists() ||
        !await audio3.exists()) {
      throw Exception('One or more audio files are missing');
    }

    final deviceId = await _getDeviceId();

    final form = FormData();
    form.files.addAll([
      MapEntry('files',
          await MultipartFile.fromFile(audio1.path, filename: 'sample1.wav')),
      MapEntry('files',
          await MultipartFile.fromFile(audio2.path, filename: 'sample2.wav')),
      MapEntry('files',
          await MultipartFile.fromFile(audio3.path, filename: 'sample3.wav')),
    ]);
    form.fields.add(MapEntry('device_id', deviceId));
    form.fields.add(MapEntry('customer_id', deviceId));

    log('Voice Enrollment - POST /voiceprint/enroll device_id: $deviceId');

    final res = await _dio.post('/voiceprint/enroll', data: form);

    if (res.statusCode != 200 && res.statusCode != 201) {
      throw Exception('Voice enrollment failed: ${res.statusMessage}');
    }

    log('Voice Enrollment - Success');
  }

  Future<String> _getDeviceId() async {
    try {
      final deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        const androidIdPlugin = AndroidId();
        final String? id = await androidIdPlugin.getId();
        if (id != null && id.isNotEmpty) return id;
        final info = await deviceInfo.androidInfo;
        return '${info.manufacturer}_${info.model}_${info.device}'
            .replaceAll(' ', '_');
      }

      if (Platform.isIOS) {
        final info = await deviceInfo.iosInfo;
        final id = info.identifierForVendor;
        if (id != null && id.isNotEmpty) return id;
      }
    } catch (e) {
      log('Error getting device ID: $e');
    }
    return '';
  }
}

/// Provides temp path for recording current image index.
Future<String> getVoiceRecordingPath(int index) async {
  final dir = await getApplicationDocumentsDirectory();
  return '${dir.path}/voice_registration_$index.wav';
}
