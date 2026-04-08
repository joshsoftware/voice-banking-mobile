import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers/providers.dart';
import '../../core/services/auth_session_repository.dart';
import '../../core/theme/app_colors.dart';

/// Splash screen shown when the app opens. Navigates to home if a session
/// exists in local storage, otherwise to the landing (login) screen.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _navigateAfterDelay());
  }

  Future<void> _navigateAfterDelay() async {
    await Future<void>.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;
    final prefs = await ref.read(sharedPreferencesProvider.future);
    final loggedIn = AuthSessionRepository(prefs).isLoggedIn;
    if (!mounted) return;
    context.go(loggedIn ? '/home' : '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.account_balance_rounded,
              size: 80,
              color: AppColors.surface,
            ),
            const SizedBox(height: 24),
            Text(
              'Voice Banking',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
