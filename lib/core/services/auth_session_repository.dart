import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_config.dart';

/// Persists mock login session (mobile + OTP) in local storage.
class AuthSessionRepository {
  AuthSessionRepository(this._prefs);

  final SharedPreferences _prefs;

  bool get isLoggedIn => _prefs.getBool(AppConfig.authSessionLoggedInKey) ?? false;

  String? get mobileNumber => _prefs.getString(AppConfig.authSessionMobileKey);

  String? get savedOtp => _prefs.getString(AppConfig.authSessionOtpKey);

  Future<void> saveSession({
    required String mobileNumber,
    required String otp,
  }) async {
    await _prefs.setBool(AppConfig.authSessionLoggedInKey, true);
    await _prefs.setString(AppConfig.authSessionMobileKey, mobileNumber);
    await _prefs.setString(AppConfig.authSessionOtpKey, otp);
  }

  Future<void> clearSession() async {
    await _prefs.remove(AppConfig.authSessionLoggedInKey);
    await _prefs.remove(AppConfig.authSessionMobileKey);
    await _prefs.remove(AppConfig.authSessionOtpKey);
  }
}
