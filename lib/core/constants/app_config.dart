/// Non-UI configuration constants.
/// API URLs, keys, etc. — do not hardcode in services.
class AppConfig {
  AppConfig._();

  /// Base URL for voiceprint enrollment API.
  static const String voiceprintEnrollBaseUrl =
      'https://zaban.joshsoftware.com/api/v1';

  /// API key for voiceprint endpoints. Set via --dart-define or env in production.
  static const String voiceprintApiKey = '';

  /// SharedPreferences key for stored locale (e.g. 'en', 'hi').
  static const String localeStorageKey = 'app_locale';
}
