import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_config.dart';
import '../network/dio_client.dart';

/// Dio client provider. Override for testing.
final dioProvider = Provider<Dio>((ref) => DioClient.create());

/// SharedPreferences provider. Async init on first use.
final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) => SharedPreferences.getInstance());

/// Persisted app locale. When null, falls back to device locale.
/// Use [localeNotifierProvider] to read/update.
final localeNotifierProvider =
    AsyncNotifierProvider<LocaleNotifier, Locale?>(LocaleNotifier.new);

class LocaleNotifier extends AsyncNotifier<Locale?> {
  @override
  Future<Locale?> build() async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    final code = prefs.getString(AppConfig.localeStorageKey);
    return code != null ? Locale(code) : null;
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setString(AppConfig.localeStorageKey, locale.languageCode);
    state = AsyncValue.data(locale);
  }
}
