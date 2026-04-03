// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kannada (`kn`).
class AppLocalizationsKn extends AppLocalizations {
  AppLocalizationsKn([String locale = 'kn']) : super(locale);

  @override
  String get appTitle => 'ವಾಯ್ಸ್ ಬ್ಯಾಂಕಿಂಗ್';

  @override
  String get voiceBank => 'ವಾಯ್ಸ್ಬ್ಯಾಂಕ್';

  @override
  String get bankWithYourVoice => 'ನಿಮ್ಮ ಧ್ವನಿಯಿಂದ ಬ್ಯಾಂಕ್ ಮಾಡಿ';

  @override
  String get mobileNumber => 'ಮೊಬೈಲ್ ಸಂಖ್ಯೆ';

  @override
  String get sendOtp => 'OTP ಕಳುಹಿಸಿ';

  @override
  String get mobileNumberPlaceholder => '1234567890';

  @override
  String get termsDisclaimer => 'ಮುಂದುವರಿಸುವ ಮೂಲಕ, ನೀವು ನಮ್ಮ ';

  @override
  String get termsAndConditions => 'ನಿಯಮಗಳು ಮತ್ತು ಷರತ್ತುಗಳಿಗೆ ಸಮ್ಮತಿಸುತ್ತೀರಿ';

  @override
  String get back => 'ಹಿಂದೆ';

  @override
  String get verifyOtp => 'OTP ಧೃವೀಕರಿಸಿ';

  @override
  String get enterFourDigitCode =>
      'ನಿಮ್ಮ ಮೊಬೈಲ್‌ಗೆ ಕಳುಹಿಸಿದ 4 ಅಂಕಿಯ ಕೋಡ್ ನಮೂದಿಸಿ';

  @override
  String get otpSentTo => 'ನಾವು 6 ಅಂಕಿಯ ಕೋಡ್ ಕಳುಹಿಸಿದ್ದೇವೆ';

  @override
  String get enterOtp => 'OTP ನಮೂದಿಸಿ';

  @override
  String get verify => 'ಧೃವೀಕರಿಸಿ';

  @override
  String get resendOtp => 'OTP ಮರುಕಳುಹಿಸಿ';

  @override
  String resendIn(Object seconds) {
    return '$seconds ಸೆಕೆಂಡ್‌ಗಳಲ್ಲಿ ಮರುಕಳುಹಿಸಿ';
  }

  @override
  String otpResendIn(Object seconds) {
    return '$seconds ಸೆಕೆಂಡ್‌ಗಳಲ್ಲಿ OTP ಮರುಕಳುಹಿಸಿ';
  }

  @override
  String get otpInvalid => 'ಮಾನ್ಯ 4 ಅಂಕಿಯ ಕೋಡ್ ನಮೂದಿಸಿ';

  @override
  String get userName => 'ಬಳಕೆದಾರ';

  @override
  String get selectLanguage => 'ಭಾಷೆ ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get continueButton => 'ಮುಂದುವರಿಸಿ';

  @override
  String get tapToMute => 'ಮ್ಯೂಟ್ ಮಾಡಲು ಟ್ಯಾಪ್ ಮಾಡಿ';

  @override
  String get goodMorning => 'ಶುಭೋದಯ';

  @override
  String get goodAfternoon => 'ಶುಭ ಮಧ್ಯಾಹ್ನ';

  @override
  String get goodEvening => 'ಶುಭ ಸಂಜೆ';

  @override
  String get availableBalance => 'ಲಭ್ಯವಿರುವ ಬ್ಯಾಲೆನ್ಸ್';

  @override
  String get savingsAccount => 'ಉಳಿತಾಯ ಖಾತೆ';

  @override
  String get viewDetails => 'ವಿವರಗಳನ್ನು ನೋಡಿ';

  @override
  String get recentTransactions => 'ಇತ್ತೀಚಿನ ವಹಿವಾಟುಗಳು';

  @override
  String get viewAll => 'ಎಲ್ಲ ನೋಡಿ';

  @override
  String get sayHeyFin => 'ಹೇಳಿ, \"ಹೇ ಫಿನ್\"';

  @override
  String get enableVoiceBanking => 'ವಾಯ್ಸ್ ಬ್ಯಾಂಕಿಂಗ್ ಸಕ್ರಿಯಗೊಳಿಸಿ';

  @override
  String get secureAccountWithVoice =>
      'ವಾಯ್ಸ್ ಬಯೋಮೆಟ್ರಿಕ್ಸ್‌ನಿಂದ ಖಾತೆಯನ್ನು ಭದ್ರಪಡಿಸಿ';

  @override
  String get enhancedSecurity => 'ವರ್ಧಿತ ಭದ್ರತೆ';

  @override
  String get enhancedSecurityDesc =>
      'ನಿಮ್ಮ ಅನನ್ಯ ಧ್ವನಿ ಮಾದರಿ ಹೆಚ್ಚುವರಿ ರಕ್ಷಣಾ ಪದರವನ್ನು ಒದಗಿಸುತ್ತದೆ';

  @override
  String get quickCommands => 'ತ್ವರಿತ ಆದೇಶಗಳು';

  @override
  String get quickCommandsDesc =>
      'ವಾಯ್ಸ್ ಆದೇಶಗಳೊಂದಿಗೆ ತಕ್ಷಣ ಬ್ಯಾಂಕಿಂಗ್ ಕಾರ್ಯಗಳನ್ನು ಮಾಡಿ';

  @override
  String get threeSimpleSteps => '3 ಸರಳ ಹಂತಗಳು';

  @override
  String get threeSimpleStepsDesc =>
      'ನಿಮ್ಮ ಅನನ್ಯ ಪ್ರೊಫೈಲ್ ರಚಿಸಲು 3 ಬಾರಿ ಧ್ವನಿ ರೆಕಾರ್ಡ್ ಮಾಡಿ';

  @override
  String get voiceConsentText =>
      'ನಾನು ಪ್ರಮಾಣೀಕರಣಕ್ಕಾಗಿ ವಾಯ್ಸ್ ಡೇಟಾ ಸಂಗ್ರಹಕ್ಕೆ ಸಮ್ಮತಿಸುತ್ತೇನೆ. ರೆಕಾರ್ಡಿಂಗ್‌ಗಳು ಪರಿಶೀಲನೆಗಾಗಿ ಮಾತ್ರ ಸುರಕ್ಷಿತವಾಗಿ ಸಂಗ್ರಹಿಸಲಾಗುತ್ತದೆ.';

  @override
  String get voiceDataCollection => 'ವಾಯ್ಸ್ ಡೇಟಾ ಸಂಗ್ರಹ';

  @override
  String get authentication => 'ಪ್ರಮಾಣೀಕರಣ';

  @override
  String get securelyStored => 'ಸುರಕ್ಷಿತವಾಗಿ ಸಂಗ್ರಹಿಸಲಾಗಿದೆ';

  @override
  String get startRegistration => 'ನೋಂದಣಿ ಪ್ರಾರಂಭಿಸಿ';

  @override
  String get skipForNow => 'ಇದೀಗ ಬಿಟ್ಟುಬಿಡಿ';

  @override
  String get tapToUnmute => 'ಅನ್‌ಮ್ಯೂಟ್ ಮಾಡಲು ಟ್ಯಾಪ್ ಮಾಡಿ';

  @override
  String get tapToMute2 => 'ಮ್ಯೂಟ್ ಮಾಡಲು ಟ್ಯಾಪ್ ಮಾಡಿ';

  @override
  String get setupVoiceBanking => 'ವಾಯ್ಸ್ ಬ್ಯಾಂಕಿಂಗ್ ಸೆಟಪ್ ಮಾಡಿ';

  @override
  String get setupVoiceBankingDesc =>
      'ವಾಯ್ಸ್ ಬಯೋಮೆಟ್ರಿಕ್ಸ್‌ನಿಂದ ಖಾತೆಯನ್ನು ಭದ್ರಪಡಿಸಿ';

  @override
  String get tapToSpeak => 'ಮಾತನಾಡಲು ಟ್ಯಾಪ್ ಮಾಡಿ';

  @override
  String get tapToStop => 'ನಿಲ್ಲಿಸಲು ಟ್ಯಾಪ್ ಮಾಡಿ';

  @override
  String get setUpVoiceByDescribing =>
      'ಚಿತ್ರವನ್ನು ವಿವರಿಸುವ ಮೂಲಕ ಧ್ವನಿ ಸೆಟ್ ಮಾಡಿ ';

  @override
  String get describingTheImage => 'ಚಿತ್ರವನ್ನು ವಿವರಿಸಿ.';

  @override
  String get takesUnder15Seconds => '15 ಸೆಕೆಂಡ್‌ಗಳಲ್ಲಿ ಪೂರ್ಣಗೊಳ್ಳುತ್ತದೆ.';

  @override
  String get tapToStartSpeaking => 'ಮಾತನಾಡಲು ಪ್ರಾರಂಭಿಸಲು ಟ್ಯಾಪ್ ಮಾಡಿ';

  @override
  String recordingPercent(Object percent) {
    return 'ರೆಕಾರ್ಡಿಂಗ್... $percent%';
  }

  @override
  String get reRecord => 'ಮರು ರೆಕಾರ್ಡ್ ಮಾಡಿ';

  @override
  String get submit => 'ಸಲ್ಲಿಸಿ';

  @override
  String get voiceRegistration => 'ವಾಯ್ಸ್ ನೋಂದಣಿ';

  @override
  String get skip => 'ಬಿಟ್ಟುಬಿಡಿ';

  @override
  String get pleaseWaitForUpload => 'ಅಪ್‌ಲೋಡ್ ಪೂರ್ಣವಾಗುವವರೆಗೆ ಕಾಯಿರಿ';

  @override
  String get voiceRegistrationCompleted =>
      'ವಾಯ್ಸ್ ನೋಂದಣಿ ಯಶಸ್ವಿಯಾಗಿ ಪೂರ್ಣವಾಯಿತು!';

  @override
  String get unknownState => 'ಅಜ್ಞಾತ ಸ್ಥಿತಿ';

  @override
  String get uploadingVoiceRecordings =>
      'ವಾಯ್ಸ್ ರೆಕಾರ್ಡಿಂಗ್‌ಗಳನ್ನು ಅಪ್‌ಲೋಡ್ ಮಾಡಲಾಗುತ್ತಿದೆ...';

  @override
  String imageNumber(Object number) {
    return 'ಚಿತ್ರ $number';
  }

  @override
  String get somethingWentWrong => 'ಏನೋ ತಪ್ಪಾಗಿದೆ, ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ!';

  @override
  String get imageNotAvailable => 'ಚಿತ್ರ ಲಭ್ಯವಿಲ್ಲ';

  @override
  String stepOfTotal(Object current, Object total) {
    return 'ಹಂತ $current / $total';
  }

  @override
  String describeImageInstruction(Object seconds) {
    return 'ಈ ಚಿತ್ರದಲ್ಲಿ ನೀವು ಏನು ನೋಡುತ್ತೀರಿ ಎಂದು $seconds ಸೆಕೆಂಡ್‌ಗಳಲ್ಲಿ ವಿವರಿಸಿ. ಸ್ಪಷ್ಟವಾಗಿ ಮಾತನಾಡಿ ಮತ್ತು ಮುಖ್ಯ ಅಂಶಗಳನ್ನು ವಿವರಿಸಿ.';
  }

  @override
  String get stopRecording => 'ರೆಕಾರ್ಡಿಂಗ್ ನಿಲ್ಲಿಸಿ';

  @override
  String get startRecording => 'ರೆಕಾರ್ಡಿಂಗ್ ಪ್ರಾರಂಭಿಸಿ';

  @override
  String get recording => 'ರೆಕಾರ್ಡಿಂಗ್...';

  @override
  String get nextStep => 'ಮುಂದಿನ ಹಂತ';

  @override
  String get register => 'ನೋಂದಾಯಿಸಿ';

  @override
  String get pleaseWaitForDescription => 'ವಿವರಣೆ ಪ್ಲೇ ಆಗುವವರೆಗೆ ಕಾಯಿರಿ.';

  @override
  String get microphonePermissionRequired =>
      'ಮೈಕ್ರೋಫೋನ್ ಅನುಮತಿ ಅಗತ್ಯ. ಸೆಟ್ಟಿಂಗ್‌ಗಳಲ್ಲಿ ಸಕ್ರಿಯಗೊಳಿಸಿ.';

  @override
  String failedToStartRecording(Object error) {
    return 'ರೆಕಾರ್ಡಿಂಗ್ ಪ್ರಾರಂಭಿಸಲು ವಿಫಲವಾಗಿದೆ: $error';
  }

  @override
  String get recordingFailed => 'ರೆಕಾರ್ಡಿಂಗ್ ವಿಫಲವಾಯಿತು. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get recordingFileNotFound =>
      'ರೆಕಾರ್ಡಿಂಗ್ ಫೈಲ್ ಕಂಡುಬಂದಿಲ್ಲ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get recordingEmpty => 'ರೆಕಾರ್ಡಿಂಗ್ ಖಾಲಿ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String pleaseSpeakAtLeastSeconds(Object seconds) {
    return 'ಕನಿಷ್ಠ $seconds ಸೆಕೆಂಡ್‌ಗಳು ಮಾತನಾಡಿ.';
  }

  @override
  String failedToStopRecording(Object error) {
    return 'ರೆಕಾರ್ಡಿಂಗ್ ನಿಲ್ಲಿಸಲು ವಿಫಲವಾಗಿದೆ: $error';
  }

  @override
  String get pleaseStopRecordingBeforePlay =>
      'ವಿವರಣೆ ಪ್ಲೇ ಮಾಡುವ ಮೊದಲು ರೆಕಾರ್ಡಿಂಗ್ ನಿಲ್ಲಿಸಿ.';

  @override
  String failedToPlayDescription(Object error) {
    return 'ವಿವರಣೆ ಪ್ಲೇ ಮಾಡಲು ವಿಫಲವಾಗಿದೆ: $error';
  }

  @override
  String failedToStopDescription(Object error) {
    return 'ವಿವರಣೆ ನಿಲ್ಲಿಸಲು ವಿಫಲವಾಗಿದೆ: $error';
  }

  @override
  String get pleaseRecordBeforeProceeding =>
      'ಮುಂದುವರಿಯುವ ಮೊದಲು ನಿಮ್ಮ ಧ್ವನಿ ರೆಕಾರ್ಡ್ ಮಾಡಿ.';

  @override
  String get pleaseWaitForRecordingOrDescription =>
      'ರೆಕಾರ್ಡಿಂಗ್ ಅಥವಾ ವಿವರಣೆ ಪೂರ್ಣವಾಗುವವರೆಗೆ ಕಾಯಿರಿ.';

  @override
  String get pleaseCompleteAllRecordings =>
      'ಸಲ್ಲಿಸುವ ಮೊದಲು ಎಲ್ಲಾ 3 ರೆಕಾರ್ಡಿಂಗ್‌ಗಳನ್ನು ಪೂರ್ಣಗೊಳಿಸಿ.';

  @override
  String get userIdNotFound => 'ಬಳಕೆದಾರ ID ಕಂಡುಬಂದಿಲ್ಲ. ಮತ್ತೆ ಲಾಗಿನ್ ಮಾಡಿ.';

  @override
  String get recordingFilesMissing =>
      'ಒಂದು ಅಥವಾ ಹೆಚ್ಚಿನ ರೆಕಾರ್ಡಿಂಗ್ ಫೈಲ್‌ಗಳು ಕಾಣೆಯಾಗಿವೆ.';

  @override
  String get pleaseSaySomething => 'ದಯವಿಟ್ಟು ಏನಾದರೂ ಹೇಳಿ';

  @override
  String get imageDescriptionBoardMeeting =>
      'ಒಬ್ಬ ವೃತ್ತಿಪರ ವ್ಯಕ್ತಿ ಜೀವಂತ ನಗರದ ನೈರ್ಮಲ್ಯದ ಮುಂದೆ ಆಧುನಿಕ, ಬಿಸಿಲಿನ ಕಛೇರಿ ಬೋರ್ಡ್‌ರೂಮ್‌ನಲ್ಲಿ ಸಹೋದ್ಯೋಗಿಗಳಿಗೆ ಡೇಟಾ ಪ್ರಸ್ತುತಿ ನೀಡುತ್ತಿದ್ದಾರೆ.';

  @override
  String get imageDescriptionBoyWithDog =>
      'ಕನ್ನಡಕ ಧರಿಸಿದ ಹುಡುಗ ಬಿಸಿಲಿನ ಪಾರ್ಕ್ ಹಾದಿಯಲ್ಲಿ ಹಸ್ಕಿ ನಾಯಿಯನ್ನು ನಡೆಸುತ್ತಿದ್ದಾನೆ, ಲೀಶ್ ಹಿಡಿದುಕೊಂಡು ನಗುತ್ತಿದ್ದಾನೆ.';

  @override
  String get imageDescriptionChildrenPainting =>
      'ಐದು ಮಕ್ಕಳು ದೊಡ್ಡ ಕಿಟಕಿಯ ಬಳಿ ಕಾರ್ಪೆಟ್ ಮೇಲೆ ಕುಳಿತು ಪ್ರಕಾಶಮಾನವಾದ ಲಿವಿಂಗ್ ರೂಮ್‌ನಲ್ಲಿ ಸಂತೋಷದಿಂದ ಬಣ್ಣದ ಚಿತ್ರಗಳನ್ನು ಬಿಡಿಸುತ್ತಿದ್ದಾರೆ.';

  @override
  String get imageDescriptionChildrenWithDog =>
      'ನಾಲ್ಕು ಮಕ್ಕಳು ಹಸಿರು ತೋಟದಲ್ಲಿ ಎರಡು ನಾಯಿಗಳೊಂದಿಗೆ ಸಂತೋಷದಿಂದ ಆಡುತ್ತಿದ್ದಾರೆ, ಪ್ರಕಾಶಮಾನವಾದ ಮಧ್ಯಾಹ್ನ ಸೂರ್ಯನ ಕೆಳಗೆ ಫ್ರಿಸ್ಬಿ ಎಸೆಯುತ್ತಿದ್ದಾರೆ.';

  @override
  String get imageDescriptionConstructionSite =>
      'ನಾಲ್ಕು ನಿರ್ಮಾಣ ವೃತ್ತಿಪರರು ಸೆಫ್ಟಿ ವೆಸ್ಟ್‌ಗಳು ಮತ್ತು ಹಾರ್ಡ್ ಹ್ಯಾಟ್‌ಗಳನ್ನು ಧರಿಸಿ ಧೂಳಿನ ಸೈಟ್‌ನಲ್ಲಿ ನಿಂತಿದ್ದಾರೆ, ದೊಡ್ಡ ವಾಸ್ತುಶಿಲ್ಪ ನಿರ್ಮಾಣ ಬ್ಲೂಪ್ರಿಂಟ್‌ನ್ನು ಎಚ್ಚರಿಕೆಯಿಂದ ಪರಿಶೀಲಿಸುತ್ತಿದ್ದಾರೆ.';

  @override
  String get imageDescriptionFamilyDinner =>
      'ನಾಲ್ಕು ಸದಸ್ಯರ ಕುಟುಂಬ ರೆಸ್ಟೋರೆಂಟ್‌ನಲ್ಲಿ ಸಾಂಪ್ರದಾಯಿಕ ಭಾರತೀಯ ರಾತ್ರಿ ಊಟವನ್ನು ಆನಂದಿಸುತ್ತಿದೆ.';

  @override
  String get imageDescriptionHoliCelebration =>
      'ಕುಟುಂಬ ಮತ್ತು ಸ್ನೇಹಿತರ ಸಂತೋಷಕರ ಗುಂಪು ಹೋಳಿ ಆಚರಿಸುತ್ತಿದೆ, ಗಾಳಿಯಲ್ಲಿ ಬಣ್ಣದ ಪೌಡರ್ ಸ್ಫೋಟದ ನಡುವೆ ಒಟ್ಟಿಗೆ ನಗುತ್ತಿದೆ.';

  @override
  String get imageDescriptionLadyPainting =>
      'ಒಬ್ಬ ಯುವತಿ ತನ್ನ ಬಿಸಿಲಿನ, ಸುಖಕರ ಮನೆಯ ಕಲಾ ಸ್ಟುಡಿಯೋದಲ್ಲಿ ಕ್ಯಾನ್ವಾಸ್‌ನಲ್ಲಿ ಸುಂದರ ಹಳದಿ ಲ್ಯಾಂಡ್‌ಸ್ಕೇಪ್ ಚಿತ್ರಿಸುತ್ತಿದ್ದಾಳೆ.';

  @override
  String get imageDescriptionMomAndSon =>
      'ಒಬ್ಬ ತಾಯಿ ತನ್ನ ಚಿಕ್ಕ ಮಗುವಿಗೆ ಸ್ಟೋವ್‌ನಲ್ಲಿ ಮರದ ಸ್ಟೂಲ್ ಮೇಲೆ ನಿಂತು ಅಡುಗೆ ಮಾಡಲು ಸಹಾಯ ಮಾಡುತ್ತಿದ್ದಾಳೆ.';

  @override
  String get imageDescriptionPeopleDiwaliCelebration =>
      'ಜನರು ಸಾಂಪ್ರದಾಯಿಕ ಪೋಷಾಕಿನಲ್ಲಿ ಅಲಂಕೃತ ಬೀದಿಯಲ್ಲಿ ದೀಪಾವಳಿ ಆಚರಿಸುತ್ತಿದ್ದಾರೆ, ಜೀವಂತ ಲ್ಯಾಂಟರ್ನ್‌ಗಳು, ಉರಿಯುತ್ತಿರುವ ದೀಪಗಳು ಮತ್ತು ತಲೆಯ ಮೇಲೆ ಅದ್ಭುತ ಒಡಿಗೆ.';

  @override
  String get imageDescriptionTajMahal =>
      'ಡೆನಿಮ್ ಜಾಕೆಟ್‌ಗಳನ್ನು ಧರಿಸಿದ ಯುವ ಸ್ನೇಹಿತರ ಗುಂಪು ಛಾವಣಿಯ ಮೇಲೆ ನಿಂತಿದೆ, ಕಾಫಿ ಹಿಡಿದುಕೊಂಡು ಹಿಂದೆ ತಾಜ್ ಮಹಲ್‌ನೊಂದಿಗೆ ನಗುತ್ತಿದೆ.';

  @override
  String get imageDescriptionVillageScene =>
      'ಒಬ್ಬ ಮುದಿಯ ರೈತ ಚಿನ್ನದ ಸೂರ್ಯಾಸ್ತದ ಸಮಯದಲ್ಲಿ ಎರಡು ಬಿಳಿ ಎತ್ತುಗಳಿಂದ ಎಳೆಯಲ್ಪಡುವ ಮರದ ಬುಲಾಕ್ ಕಾರ್ಟ್ ಮೇಲೆ ಕುಳಿತು ದೊಡ್ಡ ಬೆಳೆ ಸಾಗಿಸುತ್ತಿದ್ದಾನೆ.';

  @override
  String get imageDescriptionWomenDiwaliCelebration =>
      'ಗುಲಾಬಿ ಸಾಂಪ್ರದಾಯಿಕ ಬಟ್ಟೆಯಲ್ಲಿ ಒಬ್ಬ ಮಹಿಳೆ ಪ್ರಕಾಶಮಾನವಾದ ಎಣ್ಣೆ ದೀಪಗಳಿಂದ ಸುತ್ತುವರಿಯಲ್ಪಟ್ಟ ನೆಲದ ಮೇಲೆ ಸುಂದರ ಬಣ್ಣದ ರಂಗೋಲಿ ರಚಿಸುತ್ತಿದ್ದಾಳೆ.';

  @override
  String get voiceConversationStartHint => 'Click to start conversation';

  @override
  String get voiceChatEmptyPlaceholder => 'Your conversation will appear here.';

  @override
  String get voiceConversationListeningHint => 'Listening… tap mic to stop';

  @override
  String get voiceSessionConnecting => 'Connecting…';

  @override
  String get voiceSessionReady => 'Ready — ask anything';

  @override
  String get voiceSessionListening => 'Listening… speak anytime';

  @override
  String get voiceSessionHearingYou => 'Hearing you…';

  @override
  String get voiceSessionUnderstanding => 'Understanding…';

  @override
  String get voiceSessionThinking => 'Thinking…';

  @override
  String get voiceSessionPreparingReply => 'Preparing reply…';

  @override
  String get voiceSessionFinSpeaking => 'Fin is speaking…';

  @override
  String get voiceSessionLiveYou => 'You';

  @override
  String get voiceSessionLiveAssistant => 'Fin';

  @override
  String get voiceSessionMicMuted => 'Mic is muted';

  @override
  String get voiceMicMuteLabel => 'Mute mic';

  @override
  String get voiceMicUnmuteLabel => 'Unmute mic';
}
