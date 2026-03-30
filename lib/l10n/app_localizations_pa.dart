// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Panjabi Punjabi (`pa`).
class AppLocalizationsPa extends AppLocalizations {
  AppLocalizationsPa([String locale = 'pa']) : super(locale);

  @override
  String get appTitle => 'ਵੌਇਸ ਬੈਂਕਿੰਗ';

  @override
  String get voiceBank => 'ਵੌਇਸਬੈਂਕ';

  @override
  String get bankWithYourVoice => 'ਆਪਣੀ ਆਵਾਜ਼ ਨਾਲ ਬੈਂਕ ਕਰੋ';

  @override
  String get mobileNumber => 'ਮੋਬਾਈਲ ਨੰਬਰ';

  @override
  String get sendOtp => 'OTP ਭੇਜੋ';

  @override
  String get mobileNumberPlaceholder => '1234567890';

  @override
  String get termsDisclaimer => 'ਜਾਰੀ ਰੱਖ ਕੇ, ਤੁਸੀਂ ਸਾਡੀਆਂ ';

  @override
  String get termsAndConditions => 'ਸ਼ਰਤਾਂ ਅਤੇ ਨਿਯਮਾਂ ਨੂੰ ਮੰਨਦੇ ਹੋ';

  @override
  String get back => 'ਪਿੱਛੇ';

  @override
  String get verifyOtp => 'OTP ਤਸਦੀਕ ਕਰੋ';

  @override
  String get enterFourDigitCode =>
      'ਆਪਣੇ ਮੋਬਾਈਲ ਤੇ ਭੇਜਿਆ ਗਿਆ 4 ਅੰਕਾਂ ਦਾ ਕੋਡ ਦਰਜ ਕਰੋ';

  @override
  String get otpSentTo => 'ਅਸੀਂ 6 ਅੰਕਾਂ ਦਾ ਕੋਡ ਭੇਜ ਦਿੱਤਾ ਹੈ';

  @override
  String get enterOtp => 'OTP ਦਰਜ ਕਰੋ';

  @override
  String get verify => 'ਤਸਦੀਕ ਕਰੋ';

  @override
  String get resendOtp => 'OTP ਦੁਬਾਰਾ ਭੇਜੋ';

  @override
  String resendIn(Object seconds) {
    return '$seconds ਸਕਿੰਟਾਂ ਵਿੱਚ ਦੁਬਾਰਾ ਭੇਜੋ';
  }

  @override
  String otpResendIn(Object seconds) {
    return '$seconds ਸਕਿੰਟਾਂ ਵਿੱਚ OTP ਦੁਬਾਰਾ ਭੇਜੋ';
  }

  @override
  String get otpInvalid => 'ਕਿਰਪਾ ਕਰਕੇ ਵੈਧ 4 ਅੰਕਾਂ ਦਾ ਕੋਡ ਦਰਜ ਕਰੋ';

  @override
  String get userName => 'ਯੂਜ਼ਰ';

  @override
  String get selectLanguage => 'ਭਾਸ਼ਾ ਚੁਣੋ';

  @override
  String get continueButton => 'ਜਾਰੀ ਰੱਖੋ';

  @override
  String get tapToMute => 'ਮੂਕ ਕਰਨ ਲਈ ਟੈਪ ਕਰੋ';

  @override
  String get goodMorning => 'ਸ਼ੁਭ ਸਵੇਰ';

  @override
  String get goodAfternoon => 'ਸ਼ੁਭ ਦੁਪਹਿਰ';

  @override
  String get goodEvening => 'ਸ਼ੁਭ ਸ਼ਾਮ';

  @override
  String get availableBalance => 'ਉਪਲਬਧ ਬੈਲੇਂਸ';

  @override
  String get savingsAccount => 'ਬੱਚਤ ਖਾਤਾ';

  @override
  String get viewDetails => 'ਵੇਰਵੇ ਦੇਖੋ';

  @override
  String get recentTransactions => 'ਤਾਜ਼ਾ ਲੈਣ-ਦੇਣ';

  @override
  String get viewAll => 'ਸਭ ਦੇਖੋ';

  @override
  String get sayHeyFin => 'ਕਹੋ, \"ਹੇ ਫਿਨ\"';

  @override
  String get enableVoiceBanking => 'ਵੌਇਸ ਬੈਂਕਿੰਗ ਚਾਲੂ ਕਰੋ';

  @override
  String get secureAccountWithVoice =>
      'ਵੌਇਸ ਬਾਇਓਮੈਟ੍ਰਿਕਸ ਨਾਲ ਖਾਤਾ ਸੁਰੱਖਿਅਤ ਕਰੋ';

  @override
  String get enhancedSecurity => 'ਬਿਹਤਰ ਸੁਰੱਖਿਆ';

  @override
  String get enhancedSecurityDesc =>
      'ਤੁਹਾਡੀ ਵਿਲੱਖਣ ਆਵਾਜ਼ ਦਾ ਪੈਟਰਨ ਅਤਿਰਿਕਤ ਸੁਰੱਖਿਆ ਦਿੰਦਾ ਹੈ';

  @override
  String get quickCommands => 'ਤੇਜ਼ ਕਮਾਂਡਾਂ';

  @override
  String get quickCommandsDesc => 'ਵੌਇਸ ਕਮਾਂਡਾਂ ਨਾਲ ਤੁਰੰਤ ਬੈਂਕਿੰਗ ਕੰਮ ਕਰੋ';

  @override
  String get threeSimpleSteps => '3 ਆਸਾਨ ਕਦਮ';

  @override
  String get threeSimpleStepsDesc =>
      'ਆਪਣਾ ਵਿਲੱਖਣ ਪ੍ਰੋਫਾਈਲ ਬਣਾਉਣ ਲਈ 3 ਵਾਰ ਆਵਾਜ਼ ਰਿਕਾਰਡ ਕਰੋ';

  @override
  String get voiceConsentText =>
      'ਮੈਂ ਪ੍ਰਮਾਣੀਕਰਨ ਲਈ ਵੌਇਸ ਡਾਟਾ ਇਕੱਠਾ ਕਰਨ ਲਈ ਸਹਿਮਤ ਹਾਂ। ਰਿਕਾਰਡਿੰਗ ਸਿਰਫ਼ ਤਸਦੀਕ ਲਈ ਸੁਰੱਖਿਅਤ ਢੰਗ ਨਾਲ ਸਟੋਰ ਕੀਤੀਆਂ ਜਾਣਗੀਆਂ।';

  @override
  String get voiceDataCollection => 'ਵੌਇਸ ਡਾਟਾ ਇਕੱਠਾ ਕਰਨਾ';

  @override
  String get authentication => 'ਪ੍ਰਮਾਣੀਕਰਨ';

  @override
  String get securelyStored => 'ਸੁਰੱਖਿਅਤ ਢੰਗ ਨਾਲ ਸਟੋਰ ਕੀਤਾ';

  @override
  String get startRegistration => 'ਰਜਿਸਟ੍ਰੇਸ਼ਨ ਸ਼ੁਰੂ ਕਰੋ';

  @override
  String get skipForNow => 'ਹੁਣ ਲਈ ਛੱਡੋ';

  @override
  String get tapToUnmute => 'ਅਨਮਿਊਟ ਕਰਨ ਲਈ ਟੈਪ ਕਰੋ';

  @override
  String get tapToMute2 => 'ਮੂਕ ਕਰਨ ਲਈ ਟੈਪ ਕਰੋ';

  @override
  String get setupVoiceBanking => 'ਵੌਇਸ ਬੈਂਕਿੰਗ ਸੈੱਟ ਅੱਪ ਕਰੋ';

  @override
  String get setupVoiceBankingDesc => 'ਵੌਇਸ ਬਾਇਓਮੈਟ੍ਰਿਕਸ ਨਾਲ ਖਾਤਾ ਸੁਰੱਖਿਅਤ ਕਰੋ';

  @override
  String get tapToSpeak => 'ਬੋਲਣ ਲਈ ਟੈਪ ਕਰੋ';

  @override
  String get tapToStop => 'ਰੋਕਣ ਲਈ ਟੈਪ ਕਰੋ';

  @override
  String get setUpVoiceByDescribing => 'ਚਿੱਤਰ ਬਿਆਨ ਕਰਕੇ ਆਵਾਜ਼ ਸੈੱਟ ਕਰੋ ';

  @override
  String get describingTheImage => 'ਚਿੱਤਰ ਬਿਆਨ ਕਰੋ।';

  @override
  String get takesUnder30Seconds => '30 ਸਕਿੰਟ ਤੋਂ ਘੱਟ ਸਮਾਂ ਲਗਦਾ ਹੈ।';

  @override
  String get tapToStartSpeaking => 'ਬੋਲਣਾ ਸ਼ੁਰੂ ਕਰਨ ਲਈ ਟੈਪ ਕਰੋ';

  @override
  String recordingPercent(Object percent) {
    return 'ਰਿਕਾਰਡਿੰਗ... $percent%';
  }

  @override
  String get reRecord => 'ਦੁਬਾਰਾ ਰਿਕਾਰਡ ਕਰੋ';

  @override
  String get submit => 'ਜਮ੍ਹਾਂ ਕਰੋ';

  @override
  String get voiceRegistration => 'ਵੌਇਸ ਰਜਿਸਟ੍ਰੇਸ਼ਨ';

  @override
  String get skip => 'ਛੱਡੋ';

  @override
  String get pleaseWaitForUpload => 'ਕਿਰਪਾ ਕਰਕੇ ਅੱਪਲੋਡ ਪੂਰਾ ਹੋਣ ਦੀ ਉਡੀਕ ਕਰੋ';

  @override
  String get voiceRegistrationCompleted =>
      'ਵੌਇਸ ਰਜਿਸਟ੍ਰੇਸ਼ਨ ਸਫਲਤਾਪੂਰਵਕ ਪੂਰੀ ਹੋ ਗਈ!';

  @override
  String get unknownState => 'ਅਣਜਾਣ ਅਵਸਥਾ';

  @override
  String get uploadingVoiceRecordings =>
      'ਵੌਇਸ ਰਿਕਾਰਡਿੰਗਾਂ ਅੱਪਲੋਡ ਹੋ ਰਹੀਆਂ ਹਨ...';

  @override
  String imageNumber(Object number) {
    return 'ਚਿੱਤਰ $number';
  }

  @override
  String get somethingWentWrong =>
      'ਕੁਝ ਗਲਤ ਹੋ ਗਿਆ, ਕਿਰਪਾ ਕਰਕੇ ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ!';

  @override
  String get imageNotAvailable => 'ਚਿੱਤਰ ਉਪਲਬਧ ਨਹੀਂ';

  @override
  String stepOfTotal(Object current, Object total) {
    return 'ਕਦਮ $current / $total';
  }

  @override
  String describeImageInstruction(Object seconds) {
    return 'ਕਿਰਪਾ ਕਰਕੇ ਇਸ ਚਿੱਤਰ ਵਿੱਚ ਜੋ ਤੁਸੀਂ ਦੇਖਦੇ ਹੋ ਉਸਨੂੰ $seconds ਸਕਿੰਟਾਂ ਵਿੱਚ ਬਿਆਨ ਕਰੋ। ਸਪੱਸ਼ਟ ਬੋਲੋ ਅਤੇ ਮੁੱਖ ਤੱਤ ਬਿਆਨ ਕਰੋ।';
  }

  @override
  String get stopRecording => 'ਰਿਕਾਰਡਿੰਗ ਰੋਕੋ';

  @override
  String get startRecording => 'ਰਿਕਾਰਡਿੰਗ ਸ਼ੁਰੂ ਕਰੋ';

  @override
  String get recording => 'ਰਿਕਾਰਡਿੰਗ...';

  @override
  String get nextStep => 'ਅਗਲਾ ਕਦਮ';

  @override
  String get register => 'ਰਜਿਸਟਰ ਕਰੋ';

  @override
  String get pleaseWaitForDescription =>
      'ਕਿਰਪਾ ਕਰਕੇ ਬਿਆਨ ਚੱਲਣ ਖਤਮ ਹੋਣ ਦੀ ਉਡੀਕ ਕਰੋ।';

  @override
  String get microphonePermissionRequired =>
      'ਮਾਈਕ੍ਰੋਫੋਨ ਇਜਾਜ਼ਤ ਲੋੜੀਂਦੀ ਹੈ। ਸੈਟਿੰਗਾਂ ਵਿੱਚ ਚਾਲੂ ਕਰੋ।';

  @override
  String failedToStartRecording(Object error) {
    return 'ਰਿਕਾਰਡਿੰਗ ਸ਼ੁਰੂ ਕਰਨ ਵਿੱਚ ਅਸਫਲ: $error';
  }

  @override
  String get recordingFailed => 'ਰਿਕਾਰਡਿੰਗ ਅਸਫਲ। ਕਿਰਪਾ ਕਰਕੇ ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get recordingFileNotFound =>
      'ਰਿਕਾਰਡਿੰਗ ਫਾਈਲ ਨਹੀਂ ਮਿਲੀ। ਕਿਰਪਾ ਕਰਕੇ ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get recordingEmpty =>
      'ਰਿਕਾਰਡਿੰਗ ਖਾਲੀ ਹੈ। ਕਿਰਪਾ ਕਰਕੇ ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String pleaseSpeakAtLeastSeconds(Object seconds) {
    return 'ਕਿਰਪਾ ਕਰਕੇ ਘੱਟੋ-ਘੱਟ $seconds ਸਕਿੰਟ ਬੋਲੋ।';
  }

  @override
  String failedToStopRecording(Object error) {
    return 'ਰਿਕਾਰਡਿੰਗ ਰੋਕਣ ਵਿੱਚ ਅਸਫਲ: $error';
  }

  @override
  String get pleaseStopRecordingBeforePlay =>
      'ਕਿਰਪਾ ਕਰਕੇ ਬਿਆਨ ਚਲਾਉਣ ਤੋਂ ਪਹਿਲਾਂ ਰਿਕਾਰਡਿੰਗ ਰੋਕੋ।';

  @override
  String failedToPlayDescription(Object error) {
    return 'ਬਿਆਨ ਚਲਾਉਣ ਵਿੱਚ ਅਸਫਲ: $error';
  }

  @override
  String failedToStopDescription(Object error) {
    return 'ਬਿਆਨ ਰੋਕਣ ਵਿੱਚ ਅਸਫਲ: $error';
  }

  @override
  String get pleaseRecordBeforeProceeding =>
      'ਕਿਰਪਾ ਕਰਕੇ ਅੱਗੇ ਵਧਣ ਤੋਂ ਪਹਿਲਾਂ ਆਪਣੀ ਆਵਾਜ਼ ਰਿਕਾਰਡ ਕਰੋ।';

  @override
  String get pleaseWaitForRecordingOrDescription =>
      'ਕਿਰਪਾ ਕਰਕੇ ਰਿਕਾਰਡਿੰਗ ਜਾਂ ਬਿਆਨ ਪੂਰਾ ਹੋਣ ਦੀ ਉਡੀਕ ਕਰੋ।';

  @override
  String get pleaseCompleteAllRecordings =>
      'ਕਿਰਪਾ ਕਰਕੇ ਜਮ੍ਹਾਂ ਕਰਨ ਤੋਂ ਪਹਿਲਾਂ ਸਾਰੀਆਂ 3 ਰਿਕਾਰਡਿੰਗਾਂ ਪੂਰੀਆਂ ਕਰੋ।';

  @override
  String get userIdNotFound =>
      'ਯੂਜ਼ਰ ID ਨਹੀਂ ਮਿਲੀ। ਕਿਰਪਾ ਕਰਕੇ ਦੁਬਾਰਾ ਲੌਗ ਇਨ ਕਰੋ।';

  @override
  String get recordingFilesMissing => 'ਇੱਕ ਜਾਂ ਵੱਧ ਰਿਕਾਰਡਿੰਗ ਫਾਈਲਾਂ ਗਾਇਬ ਹਨ।';

  @override
  String get pleaseSaySomething => 'ਕਿਰਪਾ ਕਰਕੇ ਕੁਝ ਕਹੋ';

  @override
  String get imageDescriptionBoardMeeting =>
      'ਇੱਕ ਪੇਸ਼ੇਵਰ ਵਿਅਕਤੀ ਆਧੁਨਿਕ, ਧੁੱਪ ਵਾਲੇ ਦਫਤਰ ਬੋਰਡਰੂਮ ਵਿੱਚ ਸ਼ਹਿਰ ਦੇ ਦ੍ਰਿਸ਼ ਦੇ ਸਾਹਮਣੇ ਸਹਿਕਰਮੀਆਂ ਨੂੰ ਡੇਟਾ ਪੇਸ਼ਕਾਰੀ ਦਿੰਦਾ ਹੈ।';

  @override
  String get imageDescriptionBoyWithDog =>
      'ਚਸ਼ਮੇ ਪਹਿਨੇ ਇੱਕ ਮੁੰਡਾ ਧੁੱਪ ਵਾਲੇ ਪਾਰਕ ਰਸਤੇ ਉੱਤੇ ਹਸਕੀ ਕੁੱਤੇ ਨੂੰ ਚਲਾਉਂਦਾ ਹੈ, ਲੀਸ਼ ਪਕੜ ਕੇ ਮੁਸਕਰਾਉਂਦਾ ਹੈ।';

  @override
  String get imageDescriptionChildrenPainting =>
      'ਪੰਜ ਬੱਚੇ ਵੱਡੀ ਖਿੜਕੀ ਦੇ ਕੋਲ ਕਾਰਪੇਟ ਉੱਤੇ ਬੈਠੇ ਚਮਕਦਾਰ ਲਿਵਿੰਗ ਰੂਮ ਵਿੱਚ ਖੁਸ਼ੀ ਨਾਲ ਰੰਗੀਨ ਤਸਵੀਰਾਂ ਪੇਂਟ ਕਰ ਰਹੇ ਹਨ।';

  @override
  String get imageDescriptionChildrenWithDog =>
      'ਚਾਰ ਬੱਚੇ ਹਰੇ ਬਾਗ ਵਿੱਚ ਦੋ ਕੁੱਤਿਆਂ ਨਾਲ ਖੁਸ਼ੀ ਨਾਲ ਖੇਡ ਰਹੇ ਹਨ, ਚਮਕਦਾਰ ਦੁਪਹਿਰ ਦੇ ਸੂਰਜ ਹੇਠਾਂ ਫ੍ਰਿਸਬੀ ਸੁੱਟ ਰਹੇ ਹਨ।';

  @override
  String get imageDescriptionConstructionSite =>
      'ਚਾਰ ਨਿਰਮਾਣ ਪੇਸ਼ੇਵਰ ਸੁਰੱਖਿਆ ਵੈਸਟ ਅਤੇ ਹਾਰਡ ਹੈਟ ਪਹਿਨ ਕੇ ਧੂੜ ਭਰੀ ਸਾਈਟ ਉੱਤੇ ਖੜੇ ਹਨ, ਵੱਡੀ ਆਰਕੀਟੈਕਚਰਲ ਬਿਲਡਿੰਗ ਬਲੂਪ੍ਰਿੰਟ ਦੀ ਸਾਵਧਾਨੀ ਨਾਲ ਸਮੀਖਿਆ ਕਰ ਰਹੇ ਹਨ।';

  @override
  String get imageDescriptionFamilyDinner =>
      'ਚਾਰ ਮੈਂਬਰਾਂ ਦਾ ਖੁਸ਼ਹਾਲ ਪਰਿਵਾਰ ਰੈਸਟੋਰੈਂਟ ਵਿੱਚ ਪਰੰਪਰਾਗਤ ਭਾਰਤੀ ਰਾਤ ਦੇ ਖਾਣੇ ਦਾ ਆਨੰਦ ਲੈ ਰਿਹਾ ਹੈ।';

  @override
  String get imageDescriptionHoliCelebration =>
      'ਪਰਿਵਾਰ ਅਤੇ ਦੋਸਤਾਂ ਦਾ ਖੁਸ਼ਹਾਲ ਸਮੂਹ ਹੋਲੀ ਮਨਾ ਰਿਹਾ ਹੈ, ਹਵਾ ਵਿੱਚ ਰੰਗੀਨ ਪਾਊਡਰ ਦੇ ਧਮਾਕੇ ਵਿੱਚ ਇਕੱਠੇ ਹੱਸ ਰਹੇ ਹਨ।';

  @override
  String get imageDescriptionLadyPainting =>
      'ਇੱਕ ਜਵਾਨ ਔਰਤ ਆਪਣੇ ਧੁੱਪ ਵਾਲੇ, ਆਰਾਮਦਾਇਕ ਘਰ ਦੇ ਆਰਟ ਸਟੂਡੀਓ ਵਿੱਚ ਕੈਨਵਸ ਉੱਤੇ ਸੁੰਦਰ ਪੀਲਾ ਲੈਂਡਸਕੇਪ ਪੇਂਟ ਕਰਨ ਉੱਤੇ ਧਿਆਨ ਦੇ ਰਹੀ ਹੈ।';

  @override
  String get imageDescriptionMomAndSon =>
      'ਇੱਕ ਮਾਂ ਆਪਣੇ ਛੋਟੇ ਬੇਟੇ ਨੂੰ ਸਟੋਵ ਉੱਤੇ ਲੱਕੜ ਦੇ ਸਟੂਲ ਉੱਤੇ ਖੜੇ ਹੋ ਕੇ ਖਾਣਾ ਬਣਾਉਣ ਵਿੱਚ ਮਦਦ ਕਰ ਰਹੀ ਹੈ।';

  @override
  String get imageDescriptionPeopleDiwaliCelebration =>
      'ਲੋਕ ਪਰੰਪਰਾਗਤ ਪੁਸ਼ਾਕ ਵਿੱਚ ਸਜੀ ਗਲੀ ਵਿੱਚ ਦੀਵਾਲੀ ਮਨਾ ਰਹੇ ਹਨ, ਚਮਕਦਾਰ ਲੈਂਟਰਨ, ਦੀਵੇ ਅਤੇ ਸਿਰ ਉੱਤੇ ਸ਼ਾਨਦਾਰ ਆਤਿਸ਼ਬਾਜ਼ੀ।';

  @override
  String get imageDescriptionTajMahal =>
      'ਡੈਨਿਮ ਜੈਕਟਾਂ ਪਹਿਨੇ ਜਵਾਨ ਦੋਸਤਾਂ ਦਾ ਸਮੂਹ ਛੱਤ ਉੱਤੇ ਖੜਾ ਹੈ, ਕਾਫੀ ਪਕੜ ਕੇ ਪਿੱਛੇ ਤਾਜ ਮਹਿਲ ਨਾਲ ਮੁਸਕਰਾ ਰਿਹਾ ਹੈ।';

  @override
  String get imageDescriptionVillageScene =>
      'ਇੱਕ ਬਜ਼ੁਰਗ ਕਿਸਾਨ ਸੋਨੇਰੀ ਸੂਰਜ ਡੁੱਬਣ ਦੇ ਸਮੇਂ ਦੋ ਚਿੱਟੇ ਬਲਦਾਂ ਨਾਲ ਖਿੱਚੀ ਜਾ ਰਹੀ ਲੱਕੜ ਦੀ ਬੱਲਡ ਕਾਰਟ ਉੱਤੇ ਬੈਠਾ ਹੈ, ਵੱਡੀ ਫਸਲ ਲਿਜਾ ਰਿਹਾ ਹੈ।';

  @override
  String get imageDescriptionWomenDiwaliCelebration =>
      'ਗੁਲਾਬੀ ਪਰੰਪਰਾਗਤ ਕੱਪੜੇ ਵਿੱਚ ਇੱਕ ਔਰਤ ਚਮਕਦਾਰ ਤੇਲ ਦੇ ਦੀਵਿਆਂ ਨਾਲ ਘਿਰੀ ਜ਼ਮੀਨ ਉੱਤੇ ਸੁੰਦਰ ਰੰਗੀਨ ਰੰਗੋਲੀ ਬਣਾ ਰਹੀ ਹੈ।';

  @override
  String get voiceConversationStartHint =>
      'Say \"Hey, Fin\" \nto start conversation';

  @override
  String get voiceConversationListeningHint => 'Listening… tap mic to stop';

  @override
  String get voiceSessionConnecting => 'Connecting…';

  @override
  String get voiceSessionReady => 'Ready — ask Fin anything';

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
