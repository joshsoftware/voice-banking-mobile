// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'वॉयस बैंकिंग';

  @override
  String get voiceBank => 'वॉयसबैंक';

  @override
  String get bankWithYourVoice => 'अपनी आवाज़ से बैंकिंग करें';

  @override
  String get mobileNumber => 'मोबाइल नंबर';

  @override
  String get sendOtp => 'OTP भेजें';

  @override
  String get mobileNumberPlaceholder => '1234567890';

  @override
  String get termsDisclaimer => 'जारी रखकर, आप हमारी ';

  @override
  String get termsAndConditions => 'नियम और शर्तें';

  @override
  String get back => 'वापस';

  @override
  String get verifyOtp => 'OTP सत्यापित करें';

  @override
  String get enterFourDigitCode =>
      'अपने मोबाइल पर भेजा गया 4 अंकों का कोड दर्ज करें';

  @override
  String get otpSentTo => 'हमने 6 अंकों का कोड भेजा है';

  @override
  String get enterOtp => 'OTP दर्ज करें';

  @override
  String get verify => 'सत्यापित करें';

  @override
  String get resendOtp => 'OTP पुनः भेजें';

  @override
  String resendIn(Object seconds) {
    return '$seconds सेकंड में पुनः भेजें';
  }

  @override
  String otpResendIn(Object seconds) {
    return '$seconds सेकंड में OTP पुनः भेजें';
  }

  @override
  String get otpInvalid => 'कृपया वैध 4 अंकों का कोड दर्ज करें';

  @override
  String get userName => 'उपयोगकर्ता';

  @override
  String get selectLanguage => 'भाषा चुनें';

  @override
  String get continueButton => 'जारी रखें';

  @override
  String get tapToMute => 'म्यूट करने के लिए टैप करें';

  @override
  String get goodMorning => 'सुप्रभात';

  @override
  String get goodAfternoon => 'शुभ अपराह्न';

  @override
  String get goodEvening => 'शुभ संध्या';

  @override
  String get availableBalance => 'उपलब्ध शेष';

  @override
  String get savingsAccount => 'बचत खाता';

  @override
  String get viewDetails => 'विवरण देखें';

  @override
  String get recentTransactions => 'हाल की लेनदेन';

  @override
  String get viewAll => 'सभी देखें';

  @override
  String get sayHeyFin => 'बोलें, \"हे फिन\"';

  @override
  String get enableVoiceBanking => 'वॉयस बैंकिंग सक्षम करें';

  @override
  String get secureAccountWithVoice =>
      'वॉयस बायोमेट्रिक्स से अपने खाते को सुरक्षित करें';

  @override
  String get enhancedSecurity => 'उन्नत सुरक्षा';

  @override
  String get enhancedSecurityDesc =>
      'आपकी अनूठी आवाज़ का पैटर्न सुरक्षा की एक अतिरिक्त परत जोड़ता है';

  @override
  String get quickCommands => 'त्वरित आदेश';

  @override
  String get quickCommandsDesc => 'वॉयस कमांड से तुरंत बैंकिंग कार्य करें';

  @override
  String get threeSimpleSteps => '3 सरल कदम';

  @override
  String get threeSimpleStepsDesc =>
      'अपना अनूठा प्रोफ़ाइल बनाने के लिए अपनी आवाज़ 3 बार रिकॉर्ड करें';

  @override
  String get voiceConsentText =>
      'मैं प्रमाणीकरण के लिए वॉयस डेटा संग्रह की सहमति देता/देती हूं। रिकॉर्डिंग केवल सत्यापन के लिए सुरक्षित रूप से संग्रहीत की जाएंगी।';

  @override
  String get voiceDataCollection => 'वॉयस डेटा संग्रह';

  @override
  String get authentication => 'प्रमाणीकरण';

  @override
  String get securelyStored => 'सुरक्षित रूप से संग्रहीत';

  @override
  String get startRegistration => 'पंजीकरण शुरू करें';

  @override
  String get skipForNow => 'अभी के लिए छोड़ें';

  @override
  String get tapToUnmute => 'अनम्यूट करने के लिए टैप करें';

  @override
  String get tapToMute2 => 'म्यूट करने के लिए टैप करें';

  @override
  String get setupVoiceBanking => 'वॉयस बैंकिंग सेट अप करें';

  @override
  String get setupVoiceBankingDesc =>
      'वॉयस बायोमेट्रिक्स से अपने खाते को सुरक्षित करें';

  @override
  String get tapToSpeak => 'बोलने के लिए टैप करें';

  @override
  String get tapToStop => 'रोकने के लिए टैप करें';

  @override
  String get setUpVoiceByDescribing =>
      'इमेज का वर्णन करके अपनी आवाज़ सेट अप करें ';

  @override
  String get describingTheImage => 'चित्र का वर्णन करें।';

  @override
  String get takesUnder30Seconds => '30 सेकंड से कम समय लगता है।';

  @override
  String get tapToStartSpeaking => 'बोलना शुरू करने के लिए टैप करें';

  @override
  String recordingPercent(Object percent) {
    return 'रिकॉर्डिंग... $percent%';
  }

  @override
  String get reRecord => 'पुनः रिकॉर्ड करें';

  @override
  String get submit => 'सबमिट करें';

  @override
  String get voiceRegistration => 'वॉयस पंजीकरण';

  @override
  String get skip => 'छोड़ें';

  @override
  String get pleaseWaitForUpload => 'कृपया अपलोड पूर्ण होने तक प्रतीक्षा करें';

  @override
  String get voiceRegistrationCompleted =>
      'वॉयस पंजीकरण सफलतापूर्वक पूर्ण हुआ!';

  @override
  String get unknownState => 'अज्ञात स्थिति';

  @override
  String get uploadingVoiceRecordings => 'वॉयस रिकॉर्डिंग अपलोड हो रही हैं...';

  @override
  String imageNumber(Object number) {
    return 'छवि $number';
  }

  @override
  String get somethingWentWrong => 'कुछ गलत हो गया, कृपया पुनः प्रयास करें!';

  @override
  String get imageNotAvailable => 'छवि उपलब्ध नहीं है';

  @override
  String stepOfTotal(Object current, Object total) {
    return 'चरण $current / $total';
  }

  @override
  String describeImageInstruction(Object seconds) {
    return 'कृपया इस छवि में जो देखते हैं उसे $seconds सेकंड तक बताएं। स्पष्ट बोलें और मुख्य तत्वों का वर्णन करें।';
  }

  @override
  String get stopRecording => 'रिकॉर्डिंग रोकें';

  @override
  String get startRecording => 'रिकॉर्डिंग शुरू करें';

  @override
  String get recording => 'रिकॉर्डिंग...';

  @override
  String get nextStep => 'अगला कदम';

  @override
  String get register => 'पंजीकरण करें';

  @override
  String get pleaseWaitForDescription =>
      'कृपया विवरण बजने समाप्त होने तक प्रतीक्षा करें।';

  @override
  String get microphonePermissionRequired =>
      'माइक्रोफोन अनुमति आवश्यक है। कृपया सेटिंग्स में सक्षम करें।';

  @override
  String failedToStartRecording(Object error) {
    return 'रिकॉर्डिंग शुरू करने में विफल: $error';
  }

  @override
  String get recordingFailed => 'रिकॉर्डिंग विफल। कृपया पुनः प्रयास करें।';

  @override
  String get recordingFileNotFound =>
      'रिकॉर्डिंग फ़ाइल नहीं मिली। कृपया पुनः प्रयास करें।';

  @override
  String get recordingEmpty => 'रिकॉर्डिंग खाली है। कृपया पुनः प्रयास करें।';

  @override
  String pleaseSpeakAtLeastSeconds(Object seconds) {
    return 'कृपया कम से कम $seconds सेकंड बोलें।';
  }

  @override
  String failedToStopRecording(Object error) {
    return 'रिकॉर्डिंग रोकने में विफल: $error';
  }

  @override
  String get pleaseStopRecordingBeforePlay =>
      'कृपया विवरण बजाने से पहले रिकॉर्डिंग रोकें।';

  @override
  String failedToPlayDescription(Object error) {
    return 'विवरण बजाने में विफल: $error';
  }

  @override
  String failedToStopDescription(Object error) {
    return 'विवरण रोकने में विफल: $error';
  }

  @override
  String get pleaseRecordBeforeProceeding =>
      'कृपया आगे बढ़ने से पहले अपनी आवाज़ रिकॉर्ड करें।';

  @override
  String get pleaseWaitForRecordingOrDescription =>
      'कृपया रिकॉर्डिंग या विवरण पूर्ण होने तक प्रतीक्षा करें।';

  @override
  String get pleaseCompleteAllRecordings =>
      'कृपया सबमिट करने से पहले सभी 3 रिकॉर्डिंग पूरी करें।';

  @override
  String get userIdNotFound =>
      'उपयोगकर्ता ID नहीं मिली। कृपया पुनः लॉगिन करें।';

  @override
  String get recordingFilesMissing => 'एक या अधिक रिकॉर्डिंग फ़ाइलें गायब हैं।';

  @override
  String get pleaseSaySomething => 'कृपया कुछ बोलें';

  @override
  String get imageDescriptionBoardMeeting =>
      'एक पेशेवर व्यक्ति आधुनिक, धूप वाली बोर्डरूम में शहर के दृश्य के सामने सहकर्मियों को डेटा प्रस्तुति दे रहा है।';

  @override
  String get imageDescriptionBoyWithDog =>
      'चश्मा पहने एक लड़का धूप वाले पार्क मार्ग पर एक हस्की कुत्ते को चला रहा है, पट्टा पकड़े मुस्कुराते हुए।';

  @override
  String get imageDescriptionChildrenPainting =>
      'पांच बच्चे बड़ी खिड़की के पास गलीचे पर बैठकर उज्ज्वल लिविंग रूम में एक साथ रंगीन चित्र बना रहे हैं।';

  @override
  String get imageDescriptionChildrenWithDog =>
      'चार बच्चे हरी-भरी बगीचे में दो कुत्तों के साथ खुशी से खेल रहे हैं, धूप भरी दोपहर में फ्रिसबी फेंकते हुए।';

  @override
  String get imageDescriptionConstructionSite =>
      'चार निर्माण पेशेवर सुरक्षा जैकेट और हार्ड हैट पहने धूल भरी साइट पर खड़े हैं, बड़ी वास्तुकला ब्लूप्रिंट की समीक्षा कर रहे हैं।';

  @override
  String get imageDescriptionFamilyDinner =>
      'एक खुश परिवार रेस्तरां में पारंपरिक भारतीय रात्रिभोज का आनंद ले रहा है, भोजन और हंसी साझा करते हुए।';

  @override
  String get imageDescriptionHoliCelebration =>
      'परिवार और दोस्तों का खुश समूह होली मना रहा है, हवा में रंगीन पाउडर के विस्फोट के बीच एक साथ हंस रहा है।';

  @override
  String get imageDescriptionLadyPainting =>
      'एक युवती अपने धूप वाले आरामदायक घर के आर्ट स्टूडियो में कैनवास पर सुंदर पीला लैंडस्केप पेंट करने पर ध्यान दे रही है।';

  @override
  String get imageDescriptionMomAndSon =>
      'एक मां अपने छोटे बेटे की रसोई में लकड़ी के स्टूल पर खड़े होकर खाना पकाने में मदद कर रही है।';

  @override
  String get imageDescriptionPeopleDiwaliCelebration =>
      'लोग पारंपरिक पोशाक में सजी हुई सड़क पर दीवाली मना रहे हैं, जीवंत लालटेन, चमकती दीयों और सिर के ऊपर शानदार आतिशबाजी के साथ।';

  @override
  String get imageDescriptionTajMahal =>
      'जींस जैकेट में युवा दोस्तों का समूह छत पर खड़ा है, कॉफी पकड़े और पीछे ताज महल के साथ मुस्कुरा रहा है।';

  @override
  String get imageDescriptionVillageScene =>
      'एक वृद्ध किसान सुनहरी सूर्यास्त के दौरान दो सफेद बैलों द्वारा खींची जा रही लकड़ी की बैलगाड़ी पर बैठा है, बड़ी फसल ले जा रहा है।';

  @override
  String get imageDescriptionWomenDiwaliCelebration =>
      'गुलाबी पारंपरिक कपड़े में एक महिला चमकती तेल के दीयों से घिरी जमीन पर सुंदर रंगोली बना रही है।';

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
