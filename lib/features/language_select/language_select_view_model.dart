import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Resolves the initial language from saved locale. Used by screen to sync once.
AppLanguage languageFromLocale(List<AppLanguage> languages, Locale? locale) {
  if (locale == null) return languages.first;
  return languages.firstWhere(
    (l) => l.localeCode == locale.languageCode,
    orElse: () => languages.first,
  );
}

/// Supported language for voice banking.
class AppLanguage {
  final String nativeName;
  final String englishName;
  final String localeCode;

  const AppLanguage({
    required this.nativeName,
    required this.englishName,
    required this.localeCode,
  });
}

/// State for the language selection screen.
class LanguageSelectState {
  final AppLanguage? selectedLanguage;
  final bool isMuted;
  final bool hasUserSelected;

  const LanguageSelectState({
    this.selectedLanguage,
    this.isMuted = false,
    this.hasUserSelected = false,
  });

  LanguageSelectState copyWith({
    AppLanguage? selectedLanguage,
    bool? isMuted,
    bool? hasUserSelected,
  }) =>
      LanguageSelectState(
        selectedLanguage: selectedLanguage ?? this.selectedLanguage,
        isMuted: isMuted ?? this.isMuted,
        hasUserSelected: hasUserSelected ?? this.hasUserSelected,
      );
}

/// Notifier for language selection screen logic.
class LanguageSelectViewModel extends AutoDisposeNotifier<LanguageSelectState> {
  static const List<AppLanguage> languages = [
    AppLanguage(nativeName: 'English', englishName: 'English', localeCode: 'en'),
    AppLanguage(nativeName: 'हिंदी', englishName: 'Hindi', localeCode: 'hi'),
    AppLanguage(nativeName: 'தமிழ்', englishName: 'Tamil', localeCode: 'ta'),
    AppLanguage(nativeName: 'తెలుగు', englishName: 'Telugu', localeCode: 'te'),
    AppLanguage(nativeName: 'বাংলা', englishName: 'Bengali', localeCode: 'bn'),
    AppLanguage(nativeName: 'ગુજરાતી', englishName: 'Gujarati', localeCode: 'gu'),
    AppLanguage(nativeName: 'മലയാളം', englishName: 'Malayalam', localeCode: 'ml'),
    AppLanguage(nativeName: 'मराठी', englishName: 'Marathi', localeCode: 'mr'),
    AppLanguage(nativeName: 'ಕನ್ನಡ', englishName: 'Kannada', localeCode: 'kn'),
    AppLanguage(nativeName: 'ਪੰਜਾਬੀ', englishName: 'Punjabi', localeCode: 'pa'),
  ];

  @override
  LanguageSelectState build() {
    return LanguageSelectState(selectedLanguage: languages.first);
  }

  void initFromSavedLocale(Locale? locale) {
    if (state.hasUserSelected) return;
    final target = languageFromLocale(languages, locale);
    if (state.selectedLanguage?.localeCode == target.localeCode) return;
    state = state.copyWith(selectedLanguage: target);
  }

  void selectLanguage(AppLanguage language) {
    state = state.copyWith(
      selectedLanguage: language,
      hasUserSelected: true,
    );
  }

  void toggleMute() {
    state = state.copyWith(isMuted: !state.isMuted);
  }
}

final languageSelectViewModelProvider =
    NotifierProvider.autoDispose<LanguageSelectViewModel, LanguageSelectState>(
        LanguageSelectViewModel.new);
