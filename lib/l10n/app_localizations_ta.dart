// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appTitle => 'குரல் வங்கி';

  @override
  String get voiceBank => 'வாய்ஸ்பேங்க்';

  @override
  String get bankWithYourVoice => 'உங்கள் குரலுடன் வங்கி செய்யுங்கள்';

  @override
  String get mobileNumber => 'மொபைல் எண்';

  @override
  String get sendOtp => 'OTP அனுப்பு';

  @override
  String get mobileNumberPlaceholder => '1234567890';

  @override
  String get termsDisclaimer => 'தொடர்வதன் மூலம், நீங்கள் எங்கள் ';

  @override
  String get termsAndConditions =>
      'விதிமுறைகள் மற்றும் நிபந்தனைகளை ஒப்புக்கொள்கிறீர்கள்';

  @override
  String get back => 'பின் செல்';

  @override
  String get verifyOtp => 'OTP சரிபார்க்கவும்';

  @override
  String get enterFourDigitCode =>
      'உங்கள் மொபைலுக்கு அனுப்பப்பட்ட 4 இலக்க குறியீட்டை உள்ளிடவும்';

  @override
  String get otpSentTo => '6 இலக்க குறியீட்டை அனுப்பியுள்ளோம்';

  @override
  String get enterOtp => 'OTP உள்ளிடவும்';

  @override
  String get verify => 'சரிபார்க்கவும்';

  @override
  String get resendOtp => 'OTP மீண்டும் அனுப்பு';

  @override
  String resendIn(Object seconds) {
    return '$seconds விநாடிகளில் மீண்டும் அனுப்பு';
  }

  @override
  String otpResendIn(Object seconds) {
    return '$seconds விநாடிகளில் OTP மீண்டும் அனுப்பு';
  }

  @override
  String get otpInvalid => 'செல்லுபடியான 4 இலக்க குறியீட்டை உள்ளிடவும்';

  @override
  String get userName => 'பயனர்';

  @override
  String get selectLanguage => 'மொழியைத் தேர்ந்தெடுக்கவும்';

  @override
  String get continueButton => 'தொடரவும்';

  @override
  String get tapToMute => 'அமைதியாக்க டேப் செய்யவும்';

  @override
  String get goodMorning => 'காலை வணக்கம்';

  @override
  String get goodAfternoon => 'மதிய வணக்கம்';

  @override
  String get goodEvening => 'மாலை வணக்கம்';

  @override
  String get availableBalance => 'கிடைக்கும் இருப்பு';

  @override
  String get savingsAccount => 'சேமிப்பு கணக்கு';

  @override
  String get viewDetails => 'விவரங்களைக் காணுங்கள்';

  @override
  String get recentTransactions => 'சமீபத்திய பரிவர்த்தனைகள்';

  @override
  String get viewAll => 'அனைத்தையும் காணுங்கள்';

  @override
  String get sayHeyFin => 'சொல்லுங்கள், \"ஏய் ஃபின்\"';

  @override
  String get enableVoiceBanking => 'குரல் வங்கியை இயக்கு';

  @override
  String get secureAccountWithVoice =>
      'குரல் உயிரளவுகளால் உங்கள் கணக்கை பாதுகாக்கவும்';

  @override
  String get enhancedSecurity => 'மேம்பட்ட பாதுகாப்பு';

  @override
  String get enhancedSecurityDesc =>
      'உங்கள் தனித்துவமான குரல் மாதிரி கூடுதல் பாதுகாப்பு அடுக்கை சேர்க்கிறது';

  @override
  String get quickCommands => 'விரைவு கட்டளைகள்';

  @override
  String get quickCommandsDesc =>
      'குரல் கட்டளைகளுடன் உடனடியாக வங்கி பணிகளைச் செய்யுங்கள்';

  @override
  String get threeSimpleSteps => '3 எளிய படிகள்';

  @override
  String get threeSimpleStepsDesc =>
      'உங்கள் தனித்துவமான சுயவிவரத்தை உருவாக்க 3 முறை குரலைப் பதிவு செய்யுங்கள்';

  @override
  String get voiceConsentText =>
      'நான் சான்றளிப்பிற்காக குரல் தரவு சேகரிப்புக்கு சம்மதிக்கிறேன். பதிவுகள் சரிபார்ப்புக்கு மட்டுமே பாதுகாப்பாக சேமிக்கப்படும்.';

  @override
  String get voiceDataCollection => 'குரல் தரவு சேகரிப்பு';

  @override
  String get authentication => 'சான்றளிப்பு';

  @override
  String get securelyStored => 'பாதுகாப்பாக சேமிக்கப்பட்டது';

  @override
  String get startRegistration => 'பதிவு தொடங்கு';

  @override
  String get skipForNow => 'இப்போதைக்கு தவிர்';

  @override
  String get tapToUnmute => 'ஒலியை இயக்க டேப் செய்யவும்';

  @override
  String get tapToMute2 => 'அமைதியாக்க டேப் செய்யவும்';

  @override
  String get setupVoiceBanking => 'குரல் வங்கியை அமைக்கவும்';

  @override
  String get setupVoiceBankingDesc =>
      'குரல் உயிரளவுகளால் உங்கள் கணக்கை பாதுகாக்கவும்';

  @override
  String get tapToSpeak => 'பேச டேப் செய்யவும்';

  @override
  String get tapToStop => 'நிறுத்த டேப் செய்யவும்';

  @override
  String get setUpVoiceByDescribing =>
      'படத்தை விவரிப்பதன் மூலம் உங்கள் குரலை அமைக்கவும் ';

  @override
  String get describingTheImage => 'படத்தை விவரிக்கவும்.';

  @override
  String get takesUnder30Seconds => '30 விநாடிகளுக்குள் முடிகிறது.';

  @override
  String get tapToStartSpeaking => 'பேசத் தொடங்க டேப் செய்யவும்';

  @override
  String recordingPercent(Object percent) {
    return 'பதிவு... $percent%';
  }

  @override
  String get reRecord => 'மீண்டும் பதிவு செய்';

  @override
  String get submit => 'சமர்ப்பிக்கவும்';

  @override
  String get voiceRegistration => 'குரல் பதிவு';

  @override
  String get skip => 'தவிர்';

  @override
  String get pleaseWaitForUpload => 'பதிவேற்றம் முடியும் வரை காத்திருக்கவும்';

  @override
  String get voiceRegistrationCompleted => 'குரல் பதிவு வெற்றிகரமாக முடிந்தது!';

  @override
  String get unknownState => 'அறியப்படாத நிலை';

  @override
  String get uploadingVoiceRecordings =>
      'குரல் பதிவுகள் பதிவேற்றப்படுகின்றன...';

  @override
  String imageNumber(Object number) {
    return 'படம் $number';
  }

  @override
  String get somethingWentWrong =>
      'ஏதோ தவறு நேர்ந்தது, மீண்டும் முயற்சிக்கவும்!';

  @override
  String get imageNotAvailable => 'படம் கிடைக்கவில்லை';

  @override
  String stepOfTotal(Object current, Object total) {
    return 'படி $current / $total';
  }

  @override
  String describeImageInstruction(Object seconds) {
    return 'இந்த படத்தில் நீங்கள் பார்ப்பதை $seconds விநாடிகளுக்குள் விவரிக்கவும். தெளிவாகப் பேசி முக்கிய கூறுகளை விவரிக்கவும்.';
  }

  @override
  String get stopRecording => 'பதிவை நிறுத்து';

  @override
  String get startRecording => 'பதிவைத் தொடங்கு';

  @override
  String get recording => 'பதிவு...';

  @override
  String get nextStep => 'அடுத்த படி';

  @override
  String get register => 'பதிவு செய்';

  @override
  String get pleaseWaitForDescription => 'விவரம் முடியும் வரை காத்திருக்கவும்.';

  @override
  String get microphonePermissionRequired =>
      'மைக்ரோஃபோன் அனுமதி தேவை. அமைப்புகளில் இயக்கவும்.';

  @override
  String failedToStartRecording(Object error) {
    return 'பதிவைத் தொடங்க தோல்வி: $error';
  }

  @override
  String get recordingFailed => 'பதிவு தோல்வி. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get recordingFileNotFound =>
      'பதிவு கோப்பு கிடைக்கவில்லை. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get recordingEmpty => 'பதிவு காலியாக உள்ளது. மீண்டும் முயற்சிக்கவும்.';

  @override
  String pleaseSpeakAtLeastSeconds(Object seconds) {
    return 'குறைந்தது $seconds விநாடிகள் பேசவும்.';
  }

  @override
  String failedToStopRecording(Object error) {
    return 'பதிவை நிறுத்த தோல்வி: $error';
  }

  @override
  String get pleaseStopRecordingBeforePlay =>
      'விவரம் இயக்குவதற்கு முன் பதிவை நிறுத்தவும்.';

  @override
  String failedToPlayDescription(Object error) {
    return 'விவரம் இயக்க தோல்வி: $error';
  }

  @override
  String failedToStopDescription(Object error) {
    return 'விவரத்தை நிறுத்த தோல்வி: $error';
  }

  @override
  String get pleaseRecordBeforeProceeding =>
      'தொடருவதற்கு முன் உங்கள் குரலைப் பதிவு செய்யவும்.';

  @override
  String get pleaseWaitForRecordingOrDescription =>
      'பதிவு அல்லது விவரம் முடியும் வரை காத்திருக்கவும்.';

  @override
  String get pleaseCompleteAllRecordings =>
      'சமர்ப்பிப்பதற்கு முன் அனைத்து 3 பதிவுகளையும் முடிக்கவும்.';

  @override
  String get userIdNotFound => 'பயனர் ID கிடைக்கவில்லை. மீண்டும் உள்நுழையவும்.';

  @override
  String get recordingFilesMissing =>
      'ஒன்று அல்லது அதற்கு மேற்பட்ட பதிவு கோப்புகள் காணவில்லை.';

  @override
  String get pleaseSaySomething => 'தயவுசெய்து ஏதாவது சொல்லுங்கள்';

  @override
  String get imageDescriptionBoardMeeting =>
      'ஒரு வல்லுநர் நவீன, சூரிய ஒளி நிறைந்த அலுவலக பலகை அறையில் நகர்ப்புற காட்சியை நோக்கி சக ஊழியர்களுக்கு தரவு விளக்கக்காட்சி அளிக்கிறார்.';

  @override
  String get imageDescriptionBoyWithDog =>
      'மூக்குக் கண்ணாடி அணிந்த ஒரு சிறுவன் சூரிய ஒளி நிறைந்த பூங்கா பாதையில் ஹஸ்கி நாயுடன் நடக்கிறான், கம்பியைப் பிடித்து புன்னகைத்துக்கொண்டு.';

  @override
  String get imageDescriptionChildrenPainting =>
      'ஐந்து குழந்தைகள் பெரிய ஜன்னலுக்கு அருகில் விரிப்பில் அமர்ந்து பிரகாசமான வாழ்க்கை அறையில் மகிழ்ச்சியாக வண்ணப் படங்கள் வரைந்து கொண்டிருக்கின்றனர்.';

  @override
  String get imageDescriptionChildrenWithDog =>
      'நான்கு குழந்தைகள் இரண்டு நாய்களுடன் பசுமையான தோட்டத்தில் மகிழ்ச்சியாக விளையாடுகிறார்கள், பிரகாசமான மதிய நேரத்தில் பிரிஸ்பீ வீசுகிறார்கள்.';

  @override
  String get imageDescriptionConstructionSite =>
      'நான்கு கட்டுமான வல்லுநர்கள் பாதுகாப்பு வெஸ்ட் மற்றும் கடின தொப்பிகள் அணிந்து தூசி நிறைந்த தளத்தில் நிற்கிறார்கள், பெரிய கட்டிட வரைபடத்தை கவனமாக ஆராய்கிறார்கள்.';

  @override
  String get imageDescriptionFamilyDinner =>
      'நான்கு நபர்களின் மகிழ்ச்சியான குடும்பம் உணவகத்தில் பாரம்பரிய இந்திய இரவு உணவை அனுபவிக்கிறது, உணவு மற்றும் சிரிப்பை பகிர்ந்து கொள்கிறது.';

  @override
  String get imageDescriptionHoliCelebration =>
      'குடும்பம் மற்றும் நண்பர்களின் மகிழ்ச்சியான குழு ஹோலி கொண்டாடுகிறது, காற்றில் வண்ண தூள்களின் வெடிப்புக்கு இடையில் சேர்ந்து சிரிக்கிறார்கள்.';

  @override
  String get imageDescriptionLadyPainting =>
      'ஒரு இளம் பெண் தனது சூரிய ஒளி நிறைந்த வசந்தமான வீட்டு கலை படிப்பகத்தில் கேன்வாஸில் அழகான மஞ்சள் இயற்கைக் காட்சியை வரைவதில் கவனம் செலுத்துகிறார்.';

  @override
  String get imageDescriptionMomAndSon =>
      'ஒரு அம்மா தனது சிறிய மகனுக்கு மிளகாய் அடுப்பில் மர இருக்கை மீது நின்று சமைப்பதில் உதவுகிறார், பிரகாசமான நவீன வெள்ளை சமையலறையில்.';

  @override
  String get imageDescriptionPeopleDiwaliCelebration =>
      'மக்கள் பாரம்பரிய உடையில் அலங்கரிக்கப்பட்ட தெருவில் தீபாவளி கொண்டாடுகிறார்கள், சிறப்பம்ச விளக்குகள், பிரகாசிக்கும் தீவர்த்திகள் மற்றும் தலைக்கு மேலே கண்கொள்ளாக்காட்சி.';

  @override
  String get imageDescriptionTajMahal =>
      'ஜீன்ஸ் ஜாக்கெட்டுகள் அணிந்த இளம் நண்பர்களின் குழு கூரை மீது நிற்கிறார்கள், காஃபி பிடித்துக்கொண்டு பின்னால் தாஜ் மஹால் உடன் புன்னகைத்துக்கொண்டு.';

  @override
  String get imageDescriptionVillageScene =>
      'ஒரு முதிய விவசாயி சூனிய ஒளி மங்கலில் இரண்டு வெள்ளை எருதுகளால் இழுக்கப்படும் மர எருது வண்டியின் மீது அமர்ந்திருக்கிறார், பெரிய அறுவடையை எடுத்துச் செல்கிறார்.';

  @override
  String get imageDescriptionWomenDiwaliCelebration =>
      'இளஞ்சிவப்பு பாரம்பரிய ஆடையில் ஒரு பெண் பிரகாசிக்கும் எண்ணெய் விளக்குகளால் சூழப்பட்ட தரையில் அழகான வண்ண ரங்கோலியை உருவாக்குகிறார்.';

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
