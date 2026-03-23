import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/providers/providers.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(
    const ProviderScope(
      child: VoiceBankingApp(),
    ),
  );
}

class VoiceBankingApp extends ConsumerWidget {
  const VoiceBankingApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeAsync = ref.watch(localeNotifierProvider);

    return MaterialApp.router(
      title: 'Voice Banking',
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
      locale: localeAsync.valueOrNull,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
