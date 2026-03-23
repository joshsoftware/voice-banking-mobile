import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers/providers.dart';
import '../../l10n/app_localizations.dart';
import 'language_select_view_model.dart';

/// Design tokens from Figma node 119:1827 (Select language).
class _LanguageSelectColors {
  static const background = Color(0xFFF5F7FA);
  static const surface = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF1A1F36);
  static const textSecondary = Color(0xFF6B7C93);
  static const primaryStart = Color(0xFF2072B2);
  static const primaryEnd = Color(0xFF13324A);
  static const cardBorder = Color(0xFFE1E8ED);
  static const cardSelectedBorder = Color(0xFF2072B2);
}

/// Language selection screen – displayed after OTP verification.
/// Matches Figma design node 119:1827.
class LanguageSelectScreen extends ConsumerWidget {
  const LanguageSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(languageSelectViewModelProvider);
    final vm = ref.read(languageSelectViewModelProvider.notifier);
    final localeAsync = ref.watch(localeNotifierProvider);
    final locale = localeAsync.valueOrNull;
    if (locale != null) vm.initFromSavedLocale(locale);

    final l10n = AppLocalizations.of(context)!;
    final greeting = _greeting(l10n);
    final userName = l10n.userName;

    return Scaffold(
      backgroundColor: _LanguageSelectColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _Header(
              greeting: greeting,
              userName: userName,
              isMuted: state.isMuted,
              onTapMute: vm.toggleMute,
              tapToMuteLabel: l10n.tapToMute,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: _LanguageGrid(
                  languages: LanguageSelectViewModel.languages,
                  selectedLanguage: state.selectedLanguage,
                  onLanguageSelected: vm.selectLanguage,
                ),
              ),
            ),
            _ContinueButton(
              label: l10n.continueButton,
              onPressed: () async {
                final selected = state.selectedLanguage;
                if (selected != null) {
                  await ref
                      .read(localeNotifierProvider.notifier)
                      .setLocale(Locale(selected.localeCode));
                }
                if (context.mounted) {
                  if (Navigator.of(context).canPop()) {
                    context.pop();
                  } else {
                    context.go('/home');
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  static String _greeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.goodMorning;
    if (hour < 17) return l10n.goodAfternoon;
    return l10n.goodEvening;
  }
}

class _Header extends StatelessWidget {
  final String greeting;
  final String userName;
  final bool isMuted;
  final VoidCallback onTapMute;
  final String tapToMuteLabel;

  const _Header({
    required this.greeting,
    required this.userName,
    required this.isMuted,
    required this.onTapMute,
    required this.tapToMuteLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      width: double.infinity,
      color: _LanguageSelectColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      _LanguageSelectColors.primaryStart,
                      _LanguageSelectColors.primaryEnd,
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Text(
                  'I',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greeting,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: _LanguageSelectColors.textSecondary,
                      height: 1.33,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _LanguageSelectColors.textPrimary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: onTapMute,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tapToMuteLabel,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: _LanguageSelectColors.primaryStart.withValues(alpha: 0.5),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _LanguageSelectColors.background,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    isMuted ? Icons.volume_off : Icons.volume_up,
                    size: 20,
                    color: _LanguageSelectColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageGrid extends StatelessWidget {
  final List<AppLanguage> languages;
  final AppLanguage? selectedLanguage;
  final ValueChanged<AppLanguage> onLanguageSelected;

  const _LanguageGrid({
    required this.languages,
    required this.selectedLanguage,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: languages
          .map(
            (lang) => _LanguageCard(
              language: lang,
              isSelected: selectedLanguage == lang,
              onTap: () => onLanguageSelected(lang),
            ),
          )
          .toList(),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  final AppLanguage language;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: (MediaQuery.of(context).size.width - 48 - 12) / 2,
        height: 99,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0x0D2072B2)
                : _LanguageSelectColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? _LanguageSelectColors.cardSelectedBorder
                  : _LanguageSelectColors.cardBorder,
              width: 1.63,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    language.nativeName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: _LanguageSelectColors.textPrimary,
                      height: 1.56,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    language.englishName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: _LanguageSelectColors.textSecondary,
                      height: 1.33,
                    ),
                  ),
                ],
              ),
              if (isSelected)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: _LanguageSelectColors.primaryStart,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _ContinueButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 25, 24, 25),
      decoration: const BoxDecoration(
        color: _LanguageSelectColors.surface,
        border: Border(
          top: BorderSide(
            color: _LanguageSelectColors.cardBorder,
            width: 0.54,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(32),
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  _LanguageSelectColors.primaryStart,
                  _LanguageSelectColors.primaryEnd,
                ],
              ),
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
