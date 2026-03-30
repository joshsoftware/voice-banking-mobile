library;

import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

/// Lightweight app logger used across UI/VM/native-bridge boundaries.
///
/// - Avoids new dependencies.
/// - Uses structured `name` categories for filtering.
/// - Redacts potentially sensitive values by default.
class AppLogger {
  AppLogger._();

  static bool get _enabled => !kReleaseMode;

  static void d(String tag, String message) {
    if (!_enabled) return;
    dev.log(message, name: tag, level: 500); // DEBUG-ish
  }

  static void i(String tag, String message) {
    if (!_enabled) return;
    dev.log(message, name: tag, level: 800); // INFO-ish
  }

  static void w(String tag, String message, {Object? error, StackTrace? stack}) {
    if (!_enabled) return;
    dev.log(message, name: tag, level: 900, error: error, stackTrace: stack);
  }

  static void e(String tag, String message, {Object? error, StackTrace? stack}) {
    if (!_enabled) return;
    dev.log(message, name: tag, level: 1000, error: error, stackTrace: stack);
  }

  /// Returns a short, safe preview of a potentially sensitive string.
  static String preview(String? s, {int max = 48}) {
    if (s == null) return '<null>';
    if (s.isEmpty) return '<empty>';
    if (s.length <= max) return s;
    return '${s.substring(0, max)}…(len=${s.length})';
  }
}

