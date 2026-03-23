// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'ভয়েস ব্যাংকিং';

  @override
  String get voiceBank => 'ভয়েসব্যাংক';

  @override
  String get bankWithYourVoice => 'আপনার কণ্ঠ দিয়ে ব্যাংক করুন';

  @override
  String get mobileNumber => 'মোবাইল নম্বর';

  @override
  String get sendOtp => 'OTP পাঠান';

  @override
  String get mobileNumberPlaceholder => '1234567890';

  @override
  String get termsDisclaimer => 'চালিয়ে যাওয়ার মাধ্যমে, আপনি আমাদের ';

  @override
  String get termsAndConditions => 'নিয়ম ও শর্তাবলীতে সম্মত হচ্ছেন';

  @override
  String get back => 'পিছনে';

  @override
  String get verifyOtp => 'OTP যাচাই করুন';

  @override
  String get enterFourDigitCode => 'আপনার মোবাইলে পাঠানো ৪ অঙ্কের কোড লিখুন';

  @override
  String get otpSentTo => 'আমরা ৬ অঙ্কের কোড পাঠিয়েছি';

  @override
  String get enterOtp => 'OTP লিখুন';

  @override
  String get verify => 'যাচাই করুন';

  @override
  String get resendOtp => 'OTP পুনরায় পাঠান';

  @override
  String resendIn(Object seconds) {
    return '$seconds সেকেন্ডে পুনরায় পাঠান';
  }

  @override
  String otpResendIn(Object seconds) {
    return '$seconds সেকেন্ডে OTP পুনরায় পাঠান';
  }

  @override
  String get otpInvalid => 'সঠিক ৪ অঙ্কের কোড লিখুন';

  @override
  String get userName => 'ব্যবহারকারী';

  @override
  String get selectLanguage => 'ভাষা নির্বাচন করুন';

  @override
  String get continueButton => 'চালিয়ে যান';

  @override
  String get tapToMute => 'মিউট করতে ট্যাপ করুন';

  @override
  String get goodMorning => 'শুভ সকাল';

  @override
  String get goodAfternoon => 'শুভ বিকাল';

  @override
  String get goodEvening => 'শুভ সন্ধ্যা';

  @override
  String get availableBalance => 'উপলব্ধ ব্যালেন্স';

  @override
  String get savingsAccount => 'সঞ্চয় অ্যাকাউন্ট';

  @override
  String get viewDetails => 'বিবরণ দেখুন';

  @override
  String get recentTransactions => 'সাম্প্রতিক লেনদেন';

  @override
  String get viewAll => 'সব দেখুন';

  @override
  String get sayHeyFin => 'বলুন, \"হেই ফিন\"';

  @override
  String get enableVoiceBanking => 'ভয়েস ব্যাংকিং সক্ষম করুন';

  @override
  String get secureAccountWithVoice =>
      'ভয়েস বায়োমেট্রিক্স দিয়ে অ্যাকাউন্ট সুরক্ষিত করুন';

  @override
  String get enhancedSecurity => 'উন্নত সুরক্ষা';

  @override
  String get enhancedSecurityDesc =>
      'আপনার অনন্য ভয়েস প্যাটার্ন অতিরিক্ত সুরক্ষা স্তর যোগ করে';

  @override
  String get quickCommands => 'দ্রুত কমান্ড';

  @override
  String get quickCommandsDesc =>
      'ভয়েস কমান্ড দিয়ে তাৎক্ষণিক ব্যাংকিং কাজ করুন';

  @override
  String get threeSimpleSteps => '৩টি সহজ ধাপ';

  @override
  String get threeSimpleStepsDesc =>
      'আপনার অনন্য প্রোফাইল তৈরি করতে ৩ বার ভয়েস রেকর্ড করুন';

  @override
  String get voiceConsentText =>
      'আমি প্রমাণীকরণের জন্য কণ্ঠস্বর ডেটা সংগ্রহে সম্মতি দিচ্ছি। রেকর্ডিং শুধুমাত্র যাচাইয়ের জন্য নিরাপদে সংরক্ষিত থাকবে।';

  @override
  String get voiceDataCollection => 'ভয়েস ডেটা সংগ্রহ';

  @override
  String get authentication => 'প্রমাণীকরণ';

  @override
  String get securelyStored => 'নিরাপদে সংরক্ষিত';

  @override
  String get startRegistration => 'নিবন্ধন শুরু করুন';

  @override
  String get skipForNow => 'এখনই এড়িয়ে যান';

  @override
  String get tapToUnmute => 'আনমিউট করতে ট্যাপ করুন';

  @override
  String get tapToMute2 => 'মিউট করতে ট্যাপ করুন';

  @override
  String get setupVoiceBanking => 'ভয়েস ব্যাংকিং সেটআপ করুন';

  @override
  String get setupVoiceBankingDesc =>
      'ভয়েস বায়োমেট্রিক্স দিয়ে অ্যাকাউন্ট সুরক্ষিত করুন';

  @override
  String get tapToSpeak => 'বলতে ট্যাপ করুন';

  @override
  String get tapToStop => 'বন্ধ করতে ট্যাপ করুন';

  @override
  String get setUpVoiceByDescribing => 'ছবির বর্ণনা দিয়ে ভয়েস সেটআপ করুন ';

  @override
  String get describingTheImage => 'ছবিটি বর্ণনা করুন।';

  @override
  String get takesUnder30Seconds => '৩০ সেকেন্ডের কম সময় লাগে।';

  @override
  String get tapToStartSpeaking => 'বলতে শুরু করতে ট্যাপ করুন';

  @override
  String recordingPercent(Object percent) {
    return 'রেকর্ডিং... $percent%';
  }

  @override
  String get reRecord => 'পুনরায় রেকর্ড করুন';

  @override
  String get submit => 'জমা দিন';

  @override
  String get voiceRegistration => 'ভয়েস নিবন্ধন';

  @override
  String get skip => 'এড়িয়ে যান';

  @override
  String get pleaseWaitForUpload => 'আপলোড সম্পূর্ণ হওয়া পর্যন্ত অপেক্ষা করুন';

  @override
  String get voiceRegistrationCompleted =>
      'ভয়েস নিবন্ধন সফলভাবে সম্পন্ন হয়েছে!';

  @override
  String get unknownState => 'অজানা অবস্থা';

  @override
  String get uploadingVoiceRecordings => 'ভয়েস রেকর্ডিং আপলোড হচ্ছে...';

  @override
  String imageNumber(Object number) {
    return 'ছবি $number';
  }

  @override
  String get somethingWentWrong => 'কিছু ভুল হয়েছে, আবার চেষ্টা করুন!';

  @override
  String get imageNotAvailable => 'ছবি উপলব্ধ নয়';

  @override
  String stepOfTotal(Object current, Object total) {
    return 'ধাপ $current / $total';
  }

  @override
  String describeImageInstruction(Object seconds) {
    return 'এই ছবিতে যা দেখছেন তা $seconds সেকেন্ডের মধ্যে বর্ণনা করুন। পরিষ্কার করে বলুন এবং মূল উপাদান বর্ণনা করুন।';
  }

  @override
  String get stopRecording => 'রেকর্ডিং বন্ধ করুন';

  @override
  String get startRecording => 'রেকর্ডিং শুরু করুন';

  @override
  String get recording => 'রেকর্ডিং...';

  @override
  String get nextStep => 'পরবর্তী ধাপ';

  @override
  String get register => 'নিবন্ধন করুন';

  @override
  String get pleaseWaitForDescription =>
      'বর্ণনা বাজানো শেষ হওয়া পর্যন্ত অপেক্ষা করুন।';

  @override
  String get microphonePermissionRequired =>
      'মাইক্রোফোন অনুমতি প্রয়োজন। সেটিংসে সক্ষম করুন।';

  @override
  String failedToStartRecording(Object error) {
    return 'রেকর্ডিং শুরু করতে ব্যর্থ: $error';
  }

  @override
  String get recordingFailed => 'রেকর্ডিং ব্যর্থ। আবার চেষ্টা করুন।';

  @override
  String get recordingFileNotFound =>
      'রেকর্ডিং ফাইল পাওয়া যায়নি। আবার চেষ্টা করুন।';

  @override
  String get recordingEmpty => 'রেকর্ডিং খালি। আবার চেষ্টা করুন।';

  @override
  String pleaseSpeakAtLeastSeconds(Object seconds) {
    return 'কমপক্ষে $seconds সেকেন্ড বলুন।';
  }

  @override
  String failedToStopRecording(Object error) {
    return 'রেকর্ডিং বন্ধ করতে ব্যর্থ: $error';
  }

  @override
  String get pleaseStopRecordingBeforePlay =>
      'বর্ণনা বাজানোর আগে রেকর্ডিং বন্ধ করুন।';

  @override
  String failedToPlayDescription(Object error) {
    return 'বর্ণনা বাজাতে ব্যর্থ: $error';
  }

  @override
  String failedToStopDescription(Object error) {
    return 'বর্ণনা বন্ধ করতে ব্যর্থ: $error';
  }

  @override
  String get pleaseRecordBeforeProceeding =>
      'অগ্রসর হওয়ার আগে ভয়েস রেকর্ড করুন।';

  @override
  String get pleaseWaitForRecordingOrDescription =>
      'রেকর্ডিং বা বর্ণনা সম্পূর্ণ হওয়া পর্যন্ত অপেক্ষা করুন।';

  @override
  String get pleaseCompleteAllRecordings =>
      'জমা দেওয়ার আগে ৩টি রেকর্ডিং সম্পূর্ণ করুন।';

  @override
  String get userIdNotFound => 'ব্যবহারকারী ID পাওয়া যায়নি। আবার লগইন করুন।';

  @override
  String get recordingFilesMissing => 'এক বা একাধিক রেকর্ডিং ফাইল অনুপস্থিত।';

  @override
  String get pleaseSaySomething => 'দয়া করে কিছু বলুন';

  @override
  String get imageDescriptionBoardMeeting =>
      'একজন পেশাদার ব্যক্তি একটি আধুনিক, রোদেলা অফিস বোর্ডরুমে শহরের দৃশ্য overlooking সহকর্মীদের কাছে ডেটা উপস্থাপনা দিচ্ছেন।';

  @override
  String get imageDescriptionBoyWithDog =>
      'চশমা পরা একটি ছেলে রোদেলা পার্ক পথে হাস্কি কুকুর হাঁটাচ্ছে, পটি ধরে হেসে।';

  @override
  String get imageDescriptionChildrenPainting =>
      'পাঁচটি শিশু বড় জানালার কাছে কার্পেটে বসে উজ্জ্বল লিভিং রুমে একসাথে রঙিন ছবি আঁকছে।';

  @override
  String get imageDescriptionChildrenWithDog =>
      'চারটি শিশু সবুজ বাগানে দুইটি কুকুরের সাথে আনন্দে খেলছে, রোদেলা বিকেলে ফ্রিসবি ছুড়ছে।';

  @override
  String get imageDescriptionConstructionSite =>
      'চারজন নির্মাণ পেশাদার সেফটি ভেস্ট ও হার্ড হ্যাট পরে ধূলিময় সাইটে দাঁড়িয়ে বড় স্থাপত্য ব্লুপ্রিন্ট পর্যালোচনা করছেন।';

  @override
  String get imageDescriptionFamilyDinner =>
      'চার সদস্যের পরিবার রেস্টুরেন্টে ঐতিহ্যবাহী ভারতীয় রাতের খাবার উপভোগ করছে, খাবার ও হাসি ভাগ করে নিচ্ছে।';

  @override
  String get imageDescriptionHoliCelebration =>
      'পরিবার ও বন্ধুদের আনন্দময় দল হোলি উদযাপন করছে, বাতাসে রঙিন গুঁড়োর বিস্ফোরণের মধ্যে একসাথে হেসে।';

  @override
  String get imageDescriptionLadyPainting =>
      'এক তরুণী তার রোদেলা, আরামদায়ক বাড়ির আর্ট স্টুডিওতে ক্যানভাসে সুন্দর হলুদ ল্যান্ডস্কেপ আঁকতে মনোযোগ দিচ্ছেন।';

  @override
  String get imageDescriptionMomAndSon =>
      'এক মা তার ছোট ছেলেকে রান্নাঘরে কাঠের স্টুলে দাঁড়িয়ে চুলায় রান্নায় সাহায্য করছেন।';

  @override
  String get imageDescriptionPeopleDiwaliCelebration =>
      'মানুষ ঐতিহ্যবাহী পোশাকে সজ্জিত রাস্তায় দীপাবলি উদযাপন করছে, জীবন্ত লণ্ঠন, জ্বলন্ত দীপ ও মাথার উপরে মনোরম আতশবাজি।';

  @override
  String get imageDescriptionTajMahal =>
      'ডেনিম জ্যাকেট পরা যুব বন্ধুদের দল ছাদে দাঁড়িয়ে কফি ধরে পেছনে তাজমহল নিয়ে হেসে।';

  @override
  String get imageDescriptionVillageScene =>
      'এক বয়স্ক কৃষক সোনালি সূর্যাস্তের সময় দুটি সাদা বলদ দ্বারা টানা কাঠের গরুর গাড়ির ওপর বসে বড় ফসল নিয়ে যাচ্ছেন।';

  @override
  String get imageDescriptionWomenDiwaliCelebration =>
      'গোলাপী ঐতিহ্যবাহী পোশাকে একজন মহিলা জ্বলন্ত তেলের দীপ দিয়ে ঘেরা মাটিতে সুন্দর রঙিন রঙ্গলি তৈরি করছেন।';
}
