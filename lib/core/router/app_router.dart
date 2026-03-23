import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/landing/landing_screen.dart';
import '../../features/home/voice_bank_home_screen.dart';
import '../../features/language_select/language_select_screen.dart';
import '../../features/otp/otp_screen.dart';
import '../../features/voice_consent/voice_consent_screen.dart';
import '../../features/voice_registration/voice_registration_screen.dart';

class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const LandingScreen(),
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) {
          final extra = state.extra;
          if (extra is OtpRouteParams) {
            return OtpScreen(params: extra);
          }
          return const SizedBox.shrink();
        },
      ),
      GoRoute(
        path: '/language',
        builder: (context, state) => const LanguageSelectScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const VoiceBankHomeScreen(),
      ),
      GoRoute(
        path: '/voice-consent',
        builder: (context, state) => const VoiceConsentScreen(),
      ),
      GoRoute(
        path: '/voice-registration',
        builder: (context, state) => const VoiceRegistrationScreen(),
      ),
    ],
  );
}

class OtpRouteParams {
  final String mobileNumber;
  final String otp;

  OtpRouteParams({required this.mobileNumber, required this.otp});
}
