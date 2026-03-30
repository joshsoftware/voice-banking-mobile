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

  // -- Pipecat voice session -----------------------------------------------

  /// Voice server origin (same as the web client). Native code calls
  /// `POST {pipecatBaseUrl}/start` then session-scoped `/api/offer`.
  /// Override via `--dart-define=PIPECAT_BASE_URL=...` for staging/local.
  static const String pipecatBaseUrl = String.fromEnvironment(
    'PIPECAT_BASE_URL',
    defaultValue: 'https://voicebanking.joshsoftware.com',
  );

  /// Optional JSON object string for HTTP headers on Pipecat REST calls, e.g.
  /// `{"Authorization":"Bearer …"}`. Empty means no extra headers.
  static const String pipecatRequestHeadersJson = String.fromEnvironment(
    'PIPECAT_REQUEST_HEADERS_JSON',
    defaultValue: '',
  );
}
