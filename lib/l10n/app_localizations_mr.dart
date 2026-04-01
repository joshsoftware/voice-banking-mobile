// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get appTitle => 'वॉइस बँकिंग';

  @override
  String get voiceBank => 'वॉइसबँक';

  @override
  String get bankWithYourVoice => 'तुमच्या आवाजाने बँक करा';

  @override
  String get mobileNumber => 'मोबाइल नंबर';

  @override
  String get sendOtp => 'OTP पाठवा';

  @override
  String get mobileNumberPlaceholder => '1234567890';

  @override
  String get termsDisclaimer => 'सुरू ठेवून, तुम्ही आमच्या ';

  @override
  String get termsAndConditions => 'अटी आणि नियमांशी सहमत आहात';

  @override
  String get back => 'मागे';

  @override
  String get verifyOtp => 'OTP सत्यापित करा';

  @override
  String get enterFourDigitCode =>
      'तुमच्या मोबाइलवर पाठवलेला 4 अंकी कोड प्रविष्ट करा';

  @override
  String get otpSentTo => 'आम्ही 6 अंकी कोड पाठवला आहे';

  @override
  String get enterOtp => 'OTP प्रविष्ट करा';

  @override
  String get verify => 'सत्यापित करा';

  @override
  String get resendOtp => 'OTP पुन्हा पाठवा';

  @override
  String resendIn(Object seconds) {
    return '$seconds सेकंदात पुन्हा पाठवा';
  }

  @override
  String otpResendIn(Object seconds) {
    return '$seconds सेकंदात OTP पुन्हा पाठवा';
  }

  @override
  String get otpInvalid => 'कृपया वैध 4 अंकी कोड प्रविष्ट करा';

  @override
  String get userName => 'वापरकर्ता';

  @override
  String get selectLanguage => 'भाषा निवडा';

  @override
  String get continueButton => 'सुरू ठेवा';

  @override
  String get tapToMute => 'म्यूट करण्यासाठी टॅप करा';

  @override
  String get goodMorning => 'सुप्रभात';

  @override
  String get goodAfternoon => 'शुभ दुपार';

  @override
  String get goodEvening => 'शुभ संध्याकाळ';

  @override
  String get availableBalance => 'उपलब्ध शिल्लक';

  @override
  String get savingsAccount => 'बचत खाते';

  @override
  String get viewDetails => 'तपशील पहा';

  @override
  String get recentTransactions => 'अलीकडील व्यवहार';

  @override
  String get viewAll => 'सर्व पहा';

  @override
  String get sayHeyFin => 'म्हणा, \"हे फिन\"';

  @override
  String get enableVoiceBanking => 'वॉइस बँकिंग सक्षम करा';

  @override
  String get secureAccountWithVoice => 'वॉइस बायोमेट्रिक्सने खाते सुरक्षित करा';

  @override
  String get enhancedSecurity => 'सुधारित सुरक्षा';

  @override
  String get enhancedSecurityDesc =>
      'तुमचा अद्वितीय वॉइस पॅटर्न अतिरिक्त सुरक्षा थर जोडतो';

  @override
  String get quickCommands => 'जलद आदेश';

  @override
  String get quickCommandsDesc => 'वॉइस आदेशांसह त्वरित बँकिंग कार्ये करा';

  @override
  String get threeSimpleSteps => '3 सोप्या पायऱ्या';

  @override
  String get threeSimpleStepsDesc =>
      'तुमचा अद्वितीय प्रोफाइल तयार करण्यासाठी 3 वेळा वॉइस रेकॉर्ड करा';

  @override
  String get voiceConsentText =>
      'मी प्रमाणीकरणासाठी वॉइस डेटा संग्रहासाठी संमती देतो/देते. रेकॉर्डिंग केवळ सत्यापनासाठी सुरक्षितपणे संग्रहित केल्या जातील.';

  @override
  String get voiceDataCollection => 'वॉइस डेटा संग्रह';

  @override
  String get authentication => 'प्रमाणीकरण';

  @override
  String get securelyStored => 'सुरक्षितपणे संग्रहित';

  @override
  String get startRegistration => 'नोंदणी सुरू करा';

  @override
  String get skipForNow => 'आत्तासाठी वगळा';

  @override
  String get tapToUnmute => 'अनम्यूट करण्यासाठी टॅप करा';

  @override
  String get tapToMute2 => 'म्यूट करण्यासाठी टॅप करा';

  @override
  String get setupVoiceBanking => 'वॉइस बँकिंग सेट अप करा';

  @override
  String get setupVoiceBankingDesc => 'वॉइस बायोमेट्रिक्सने खाते सुरक्षित करा';

  @override
  String get tapToSpeak => 'बोलण्यासाठी टॅप करा';

  @override
  String get tapToStop => 'थांबवण्यासाठी टॅप करा';

  @override
  String get setUpVoiceByDescribing => 'प्रतिमेचे वर्णन करून वॉइस सेट करा ';

  @override
  String get describingTheImage => 'प्रतिमा वर्णन करा.';

  @override
  String get takesUnder30Seconds => '30 सेकंदांत पूर्ण होते.';

  @override
  String get tapToStartSpeaking => 'बोलणे सुरू करण्यासाठी टॅप करा';

  @override
  String recordingPercent(Object percent) {
    return 'रेकॉर्डिंग... $percent%';
  }

  @override
  String get reRecord => 'पुन्हा रेकॉर्ड करा';

  @override
  String get submit => 'सादर करा';

  @override
  String get voiceRegistration => 'वॉइस नोंदणी';

  @override
  String get skip => 'वगळा';

  @override
  String get pleaseWaitForUpload => 'कृपया अपलोड पूर्ण होईपर्यंत प्रतीक्षा करा';

  @override
  String get voiceRegistrationCompleted =>
      'वॉइस नोंदणी यशस्वीरित्या पूर्ण झाली!';

  @override
  String get unknownState => 'अज्ञात स्थिती';

  @override
  String get uploadingVoiceRecordings => 'वॉइस रेकॉर्डिंग अपलोड होत आहेत...';

  @override
  String imageNumber(Object number) {
    return 'प्रतिमा $number';
  }

  @override
  String get somethingWentWrong =>
      'काहीतरी चूक झाली, कृपया पुन्हा प्रयत्न करा!';

  @override
  String get imageNotAvailable => 'प्रतिमा उपलब्ध नाही';

  @override
  String stepOfTotal(Object current, Object total) {
    return 'पायरी $current / $total';
  }

  @override
  String describeImageInstruction(Object seconds) {
    return 'या प्रतिमेत तुम्ही काय पाहता ते $seconds सेकंदांत वर्णन करा. स्पष्ट बोला आणि मुख्य घटक वर्णन करा.';
  }

  @override
  String get stopRecording => 'रेकॉर्डिंग थांबवा';

  @override
  String get startRecording => 'रेकॉर्डिंग सुरू करा';

  @override
  String get recording => 'रेकॉर्डिंग...';

  @override
  String get nextStep => 'पुढची पायरी';

  @override
  String get register => 'नोंदणी करा';

  @override
  String get pleaseWaitForDescription =>
      'कृपया वर्णन प्ले संपेपर्यंत प्रतीक्षा करा.';

  @override
  String get microphonePermissionRequired =>
      'मायक्रोफोन परवानगी आवश्यक आहे. सेटिंग्जमध्ये सक्षम करा.';

  @override
  String failedToStartRecording(Object error) {
    return 'रेकॉर्डिंग सुरू करण्यात अयशस्वी: $error';
  }

  @override
  String get recordingFailed => 'रेकॉर्डिंग अयशस्वी. कृपया पुन्हा प्रयत्न करा.';

  @override
  String get recordingFileNotFound =>
      'रेकॉर्डिंग फाइल आढळली नाही. कृपया पुन्हा प्रयत्न करा.';

  @override
  String get recordingEmpty =>
      'रेकॉर्डिंग रिक्त आहे. कृपया पुन्हा प्रयत्न करा.';

  @override
  String pleaseSpeakAtLeastSeconds(Object seconds) {
    return 'कृपया किमान $seconds सेकंद बोला.';
  }

  @override
  String failedToStopRecording(Object error) {
    return 'रेकॉर्डिंग थांबवण्यात अयशस्वी: $error';
  }

  @override
  String get pleaseStopRecordingBeforePlay =>
      'कृपया वर्णन प्ले करण्यापूर्वी रेकॉर्डिंग थांबवा.';

  @override
  String failedToPlayDescription(Object error) {
    return 'वर्णन प्ले करण्यात अयशस्वी: $error';
  }

  @override
  String failedToStopDescription(Object error) {
    return 'वर्णन थांबवण्यात अयशस्वी: $error';
  }

  @override
  String get pleaseRecordBeforeProceeding =>
      'कृपया पुढे जाण्यापूर्वी वॉइस रेकॉर्ड करा.';

  @override
  String get pleaseWaitForRecordingOrDescription =>
      'कृपया रेकॉर्डिंग किंवा वर्णन पूर्ण होईपर्यंत प्रतीक्षा करा.';

  @override
  String get pleaseCompleteAllRecordings =>
      'कृपया सादर करण्यापूर्वी सर्व 3 रेकॉर्डिंग पूर्ण करा.';

  @override
  String get userIdNotFound =>
      'वापरकर्ता ID आढळला नाही. कृपया पुन्हा लॉगिन करा.';

  @override
  String get recordingFilesMissing =>
      'एक किंवा अधिक रेकॉर्डिंग फाइल्स गहाळ आहेत.';

  @override
  String get pleaseSaySomething => 'कृपया काहीतरी म्हणा';

  @override
  String get imageDescriptionBoardMeeting =>
      'एक व्यावसायिक व्यक्ती आधुनिक, सूर्यप्रकाशित ऑफिस बोर्डरूममध्ये शहराच्या दृश्यासमोर सहकर्म्यांना डेटा प्रस्तुती देत आहे.';

  @override
  String get imageDescriptionBoyWithDog =>
      'चष्मा घातलेला मुलगा सूर्यप्रकाशित पार्क मार्गावर हस्की कुत्र्याला चालवत आहे, दोरी पकडून हसत.';

  @override
  String get imageDescriptionChildrenPainting =>
      'पाच मुले मोठ्या खिडकीजवळ कार्पेटवर बसून उज्ज्वल लिव्हिंग रूममध्ये आनंदाने रंगीत चित्रे रंगवत आहेत.';

  @override
  String get imageDescriptionChildrenWithDog =>
      'चार मुले हिरव्या बागेत दोन कुत्र्यांसोबत आनंदाने खेळत आहेत, उज्ज्वल दुपारच्या सूर्याखाली फ्रिसबी फेकत.';

  @override
  String get imageDescriptionConstructionSite =>
      'चार बांधकाम व्यावसायिक सेफ्टी वेस्ट आणि हार्ड हॅट घालून धुळीच्या साइटवर उभे आहेत, मोठा आर्किटेक्चरल ब्लूप्रिंट काळजीपूर्वक तपासत आहेत.';

  @override
  String get imageDescriptionFamilyDinner =>
      'चार सदस्यांचे कुटुंब रेस्टॉरंटमध्ये पारंपरिक भारतीय रात्रीचे जेवण घेत आहे.';

  @override
  String get imageDescriptionHoliCelebration =>
      'कुटुंब आणि मित्रांचा आनंदी गट होळी साजरा करत आहे, हवेत रंगीत पावडरच्या स्फोटात एकत्र हसत.';

  @override
  String get imageDescriptionLadyPainting =>
      'एक तरुणी तिच्या सूर्यप्रकाशित, आरामदायक घराच्या आर्ट स्टुडिओमध्ये कॅनव्हासवर सुंदर पिवळे लँडस्केप रंगवत आहे.';

  @override
  String get imageDescriptionMomAndSon =>
      'एक आई तिच्या लहान मुलाला स्टोव्हवर लाकडी स्टूलवर उभी राहून स्वयंपाक करण्यात मदत करते.';

  @override
  String get imageDescriptionPeopleDiwaliCelebration =>
      'लोक पारंपरिक पोशाकात सजलेल्या रस्त्यावर दिवाळी साजरी करत आहेत, उज्ज्वल लँटर्न्स, चमकणारे दिवे आणि मस्तकावर भव्य आतषबाजी.';

  @override
  String get imageDescriptionTajMahal =>
      'डेनिम जाकीट घातलेले तरुण मित्रांचा गट छतावर उभा आहे, कॉफी पकडून मागे ताजमहाल घेऊन हसत.';

  @override
  String get imageDescriptionVillageScene =>
      'एक वृद्ध शेतकरी सोनेरी सूर्यास्ताच्या वेळी दोन पांढऱ्या बैलांनी ओढलेल्या लाकडी बैलगाडीवर बसून मोठी पीक नेत आहे.';

  @override
  String get imageDescriptionWomenDiwaliCelebration =>
      'गुलाबी पारंपरिक कपड्यातील महिला चमकणारे तेलाचे दिवे असलेल्या जमिनीवर सुंदर रंगीत रंगोली तयार करते.';

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
