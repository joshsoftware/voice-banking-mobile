import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_kn.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
    Locale('gu'),
    Locale('hi'),
    Locale('kn'),
    Locale('ml'),
    Locale('mr'),
    Locale('pa'),
    Locale('ta'),
    Locale('te')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Voice Banking'**
  String get appTitle;

  /// No description provided for @voiceBank.
  ///
  /// In en, this message translates to:
  /// **'VoiceBank'**
  String get voiceBank;

  /// No description provided for @bankWithYourVoice.
  ///
  /// In en, this message translates to:
  /// **'Bank with Your Voice'**
  String get bankWithYourVoice;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @sendOtp.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOtp;

  /// No description provided for @mobileNumberPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'1234567890'**
  String get mobileNumberPlaceholder;

  /// No description provided for @termsDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our '**
  String get termsDisclaimer;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndConditions;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @verifyOtp.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get verifyOtp;

  /// No description provided for @enterFourDigitCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the 4-digit code sent to your mobile'**
  String get enterFourDigitCode;

  /// No description provided for @otpSentTo.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a 6-digit code to'**
  String get otpSentTo;

  /// No description provided for @enterOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enterOtp;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtp;

  /// No description provided for @resendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend in {seconds}s'**
  String resendIn(Object seconds);

  /// No description provided for @otpResendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP in {seconds}s'**
  String otpResendIn(Object seconds);

  /// No description provided for @otpInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid 4-digit code'**
  String get otpInvalid;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userName;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get selectLanguage;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @tapToMute.
  ///
  /// In en, this message translates to:
  /// **'Tap to mute'**
  String get tapToMute;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get goodEvening;

  /// No description provided for @availableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get availableBalance;

  /// No description provided for @savingsAccount.
  ///
  /// In en, this message translates to:
  /// **'Savings Account'**
  String get savingsAccount;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @recentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get recentTransactions;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @sayHeyFin.
  ///
  /// In en, this message translates to:
  /// **'Say, \"Hey Fin\"'**
  String get sayHeyFin;

  /// No description provided for @enableVoiceBanking.
  ///
  /// In en, this message translates to:
  /// **'Enable Voice Banking'**
  String get enableVoiceBanking;

  /// No description provided for @secureAccountWithVoice.
  ///
  /// In en, this message translates to:
  /// **'Secure your account with voice biometrics'**
  String get secureAccountWithVoice;

  /// No description provided for @enhancedSecurity.
  ///
  /// In en, this message translates to:
  /// **'Enhanced Security'**
  String get enhancedSecurity;

  /// No description provided for @enhancedSecurityDesc.
  ///
  /// In en, this message translates to:
  /// **'Your unique voice pattern adds an extra layer of protection'**
  String get enhancedSecurityDesc;

  /// No description provided for @quickCommands.
  ///
  /// In en, this message translates to:
  /// **'Quick Commands'**
  String get quickCommands;

  /// No description provided for @quickCommandsDesc.
  ///
  /// In en, this message translates to:
  /// **'Perform banking tasks instantly with voice commands'**
  String get quickCommandsDesc;

  /// No description provided for @threeSimpleSteps.
  ///
  /// In en, this message translates to:
  /// **'3 Simple Steps'**
  String get threeSimpleSteps;

  /// No description provided for @threeSimpleStepsDesc.
  ///
  /// In en, this message translates to:
  /// **'Record your voice 3 times to create your unique profile'**
  String get threeSimpleStepsDesc;

  /// No description provided for @voiceConsentText.
  ///
  /// In en, this message translates to:
  /// **'I consent to voice data collection for authentication. Recordings will be securely stored for verification only.'**
  String get voiceConsentText;

  /// No description provided for @voiceDataCollection.
  ///
  /// In en, this message translates to:
  /// **'voice data collection'**
  String get voiceDataCollection;

  /// No description provided for @authentication.
  ///
  /// In en, this message translates to:
  /// **'authentication'**
  String get authentication;

  /// No description provided for @securelyStored.
  ///
  /// In en, this message translates to:
  /// **'securely stored'**
  String get securelyStored;

  /// No description provided for @startRegistration.
  ///
  /// In en, this message translates to:
  /// **'Start Registration'**
  String get startRegistration;

  /// No description provided for @skipForNow.
  ///
  /// In en, this message translates to:
  /// **'Skip for Now'**
  String get skipForNow;

  /// No description provided for @tapToUnmute.
  ///
  /// In en, this message translates to:
  /// **'Tap to unmute'**
  String get tapToUnmute;

  /// No description provided for @tapToMute2.
  ///
  /// In en, this message translates to:
  /// **'Tap to mute'**
  String get tapToMute2;

  /// No description provided for @setupVoiceBanking.
  ///
  /// In en, this message translates to:
  /// **'Set up Voice Banking'**
  String get setupVoiceBanking;

  /// No description provided for @setupVoiceBankingDesc.
  ///
  /// In en, this message translates to:
  /// **'Secure your account with voice biometrics'**
  String get setupVoiceBankingDesc;

  /// No description provided for @tapToSpeak.
  ///
  /// In en, this message translates to:
  /// **'Tap to speak'**
  String get tapToSpeak;

  /// No description provided for @tapToStop.
  ///
  /// In en, this message translates to:
  /// **'Tap to stop'**
  String get tapToStop;

  /// No description provided for @setUpVoiceByDescribing.
  ///
  /// In en, this message translates to:
  /// **'Set up your voice by '**
  String get setUpVoiceByDescribing;

  /// No description provided for @describingTheImage.
  ///
  /// In en, this message translates to:
  /// **'describing the image.'**
  String get describingTheImage;

  /// No description provided for @takesUnder30Seconds.
  ///
  /// In en, this message translates to:
  /// **'Takes under 30 seconds.'**
  String get takesUnder30Seconds;

  /// No description provided for @tapToStartSpeaking.
  ///
  /// In en, this message translates to:
  /// **'Tap to start speaking'**
  String get tapToStartSpeaking;

  /// No description provided for @recordingPercent.
  ///
  /// In en, this message translates to:
  /// **'Recording...{percent}%'**
  String recordingPercent(Object percent);

  /// No description provided for @reRecord.
  ///
  /// In en, this message translates to:
  /// **'Re-record'**
  String get reRecord;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @voiceRegistration.
  ///
  /// In en, this message translates to:
  /// **'Voice Registration'**
  String get voiceRegistration;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @pleaseWaitForUpload.
  ///
  /// In en, this message translates to:
  /// **'Please wait for upload to complete'**
  String get pleaseWaitForUpload;

  /// No description provided for @voiceRegistrationCompleted.
  ///
  /// In en, this message translates to:
  /// **'Voice registration completed successfully!'**
  String get voiceRegistrationCompleted;

  /// No description provided for @unknownState.
  ///
  /// In en, this message translates to:
  /// **'Unknown state'**
  String get unknownState;

  /// No description provided for @uploadingVoiceRecordings.
  ///
  /// In en, this message translates to:
  /// **'Uploading voice recordings...'**
  String get uploadingVoiceRecordings;

  /// No description provided for @imageNumber.
  ///
  /// In en, this message translates to:
  /// **'Image {number}'**
  String imageNumber(Object number);

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, please try again!'**
  String get somethingWentWrong;

  /// No description provided for @imageNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Image not available'**
  String get imageNotAvailable;

  /// No description provided for @stepOfTotal.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String stepOfTotal(Object current, Object total);

  /// No description provided for @describeImageInstruction.
  ///
  /// In en, this message translates to:
  /// **'Please describe what you see in this image in up to {seconds} seconds. Speak clearly and describe the main elements.'**
  String describeImageInstruction(Object seconds);

  /// No description provided for @stopRecording.
  ///
  /// In en, this message translates to:
  /// **'Stop Recording'**
  String get stopRecording;

  /// No description provided for @startRecording.
  ///
  /// In en, this message translates to:
  /// **'Start Recording'**
  String get startRecording;

  /// No description provided for @recording.
  ///
  /// In en, this message translates to:
  /// **'Recording...'**
  String get recording;

  /// No description provided for @nextStep.
  ///
  /// In en, this message translates to:
  /// **'Next Step'**
  String get nextStep;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @pleaseWaitForDescription.
  ///
  /// In en, this message translates to:
  /// **'Please wait for the description to finish playing.'**
  String get pleaseWaitForDescription;

  /// No description provided for @microphonePermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Microphone permission is required. Please enable it in Settings.'**
  String get microphonePermissionRequired;

  /// No description provided for @failedToStartRecording.
  ///
  /// In en, this message translates to:
  /// **'Failed to start recording: {error}'**
  String failedToStartRecording(Object error);

  /// No description provided for @recordingFailed.
  ///
  /// In en, this message translates to:
  /// **'Recording failed. Please try again.'**
  String get recordingFailed;

  /// No description provided for @recordingFileNotFound.
  ///
  /// In en, this message translates to:
  /// **'Recording file not found. Please try again.'**
  String get recordingFileNotFound;

  /// No description provided for @recordingEmpty.
  ///
  /// In en, this message translates to:
  /// **'Recording is empty. Please try again.'**
  String get recordingEmpty;

  /// No description provided for @pleaseSpeakAtLeastSeconds.
  ///
  /// In en, this message translates to:
  /// **'Please speak for at least {seconds} seconds.'**
  String pleaseSpeakAtLeastSeconds(Object seconds);

  /// No description provided for @failedToStopRecording.
  ///
  /// In en, this message translates to:
  /// **'Failed to stop recording: {error}'**
  String failedToStopRecording(Object error);

  /// No description provided for @pleaseStopRecordingBeforePlay.
  ///
  /// In en, this message translates to:
  /// **'Please stop recording before playing the description.'**
  String get pleaseStopRecordingBeforePlay;

  /// No description provided for @failedToPlayDescription.
  ///
  /// In en, this message translates to:
  /// **'Failed to play description: {error}'**
  String failedToPlayDescription(Object error);

  /// No description provided for @failedToStopDescription.
  ///
  /// In en, this message translates to:
  /// **'Failed to stop description: {error}'**
  String failedToStopDescription(Object error);

  /// No description provided for @pleaseRecordBeforeProceeding.
  ///
  /// In en, this message translates to:
  /// **'Please record your voice before proceeding.'**
  String get pleaseRecordBeforeProceeding;

  /// No description provided for @pleaseWaitForRecordingOrDescription.
  ///
  /// In en, this message translates to:
  /// **'Please wait for recording or description to complete.'**
  String get pleaseWaitForRecordingOrDescription;

  /// No description provided for @pleaseCompleteAllRecordings.
  ///
  /// In en, this message translates to:
  /// **'Please complete all 3 recordings before submitting.'**
  String get pleaseCompleteAllRecordings;

  /// No description provided for @userIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'User ID not found. Please log in again.'**
  String get userIdNotFound;

  /// No description provided for @recordingFilesMissing.
  ///
  /// In en, this message translates to:
  /// **'One or more recording files are missing.'**
  String get recordingFilesMissing;

  /// No description provided for @pleaseSaySomething.
  ///
  /// In en, this message translates to:
  /// **'Please say something'**
  String get pleaseSaySomething;

  /// No description provided for @imageDescriptionBoardMeeting.
  ///
  /// In en, this message translates to:
  /// **'A professional man gives a data presentation to colleagues in a modern, sunlit office boardroom overlooking a scenic city skyline.'**
  String get imageDescriptionBoardMeeting;

  /// No description provided for @imageDescriptionBoyWithDog.
  ///
  /// In en, this message translates to:
  /// **'A boy wearing glasses walks a husky dog on a sunny park pathway, smiling while holding the leash.'**
  String get imageDescriptionBoyWithDog;

  /// No description provided for @imageDescriptionChildrenPainting.
  ///
  /// In en, this message translates to:
  /// **'Five children sit on a carpet near a large window, happily painting colorful pictures together inside a bright living room.'**
  String get imageDescriptionChildrenPainting;

  /// No description provided for @imageDescriptionChildrenWithDog.
  ///
  /// In en, this message translates to:
  /// **'Four children play joyfully with two dogs in a lush green garden, tossing a frisbee under the bright afternoon sun.'**
  String get imageDescriptionChildrenWithDog;

  /// No description provided for @imageDescriptionConstructionSite.
  ///
  /// In en, this message translates to:
  /// **'Four construction professionals in safety vests and hard hats stand on a dusty site, carefully reviewing a large architectural building blueprint.'**
  String get imageDescriptionConstructionSite;

  /// No description provided for @imageDescriptionFamilyDinner.
  ///
  /// In en, this message translates to:
  /// **'A happy family of four enjoys a traditional Indian dinner at a restaurant, sharing food and laughter in a warm atmosphere.'**
  String get imageDescriptionFamilyDinner;

  /// No description provided for @imageDescriptionHoliCelebration.
  ///
  /// In en, this message translates to:
  /// **'A joyful group of family and friends celebrate Holi, laughing together amidst a vibrant explosion of colorful powders in the air.'**
  String get imageDescriptionHoliCelebration;

  /// No description provided for @imageDescriptionLadyPainting.
  ///
  /// In en, this message translates to:
  /// **'A young woman focuses on painting a beautiful yellow landscape on a canvas in her sun-drenched, cozy home art studio.'**
  String get imageDescriptionLadyPainting;

  /// No description provided for @imageDescriptionMomAndSon.
  ///
  /// In en, this message translates to:
  /// **'A mother helps her young son cook at the stove, standing on a wooden stool in a bright, modern white kitchen.'**
  String get imageDescriptionMomAndSon;

  /// No description provided for @imageDescriptionPeopleDiwaliCelebration.
  ///
  /// In en, this message translates to:
  /// **'People in traditional attire celebrate Diwali on a decorated street with vibrant lanterns, glowing diyas, and a spectacular firework display overhead.'**
  String get imageDescriptionPeopleDiwaliCelebration;

  /// No description provided for @imageDescriptionTajMahal.
  ///
  /// In en, this message translates to:
  /// **'A group of young friends in denim jackets stands on a rooftop, holding coffee and smiling with the Taj Mahal behind.'**
  String get imageDescriptionTajMahal;

  /// No description provided for @imageDescriptionVillageScene.
  ///
  /// In en, this message translates to:
  /// **'An elderly farmer sits atop a wooden bullock cart pulled by two white oxen, carrying a large harvest during a golden sunset.'**
  String get imageDescriptionVillageScene;

  /// No description provided for @imageDescriptionWomenDiwaliCelebration.
  ///
  /// In en, this message translates to:
  /// **'A woman in pink traditional clothing carefully creates a beautiful, colorful rangoli on the ground surrounded by glowing oil lamps.'**
  String get imageDescriptionWomenDiwaliCelebration;

  /// No description provided for @voiceConversationStartHint.
  ///
  /// In en, this message translates to:
  /// **'Say \"Hey, Fin\" \nto start conversation'**
  String get voiceConversationStartHint;

  /// No description provided for @voiceConversationListeningHint.
  ///
  /// In en, this message translates to:
  /// **'Listening… tap mic to stop'**
  String get voiceConversationListeningHint;

  /// No description provided for @voiceSessionConnecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting…'**
  String get voiceSessionConnecting;

  /// No description provided for @voiceSessionReady.
  ///
  /// In en, this message translates to:
  /// **'Ready — ask Fin anything'**
  String get voiceSessionReady;

  /// No description provided for @voiceSessionListening.
  ///
  /// In en, this message translates to:
  /// **'Listening… speak anytime'**
  String get voiceSessionListening;

  /// No description provided for @voiceSessionHearingYou.
  ///
  /// In en, this message translates to:
  /// **'Hearing you…'**
  String get voiceSessionHearingYou;

  /// No description provided for @voiceSessionUnderstanding.
  ///
  /// In en, this message translates to:
  /// **'Understanding…'**
  String get voiceSessionUnderstanding;

  /// No description provided for @voiceSessionThinking.
  ///
  /// In en, this message translates to:
  /// **'Thinking…'**
  String get voiceSessionThinking;

  /// No description provided for @voiceSessionPreparingReply.
  ///
  /// In en, this message translates to:
  /// **'Preparing reply…'**
  String get voiceSessionPreparingReply;

  /// No description provided for @voiceSessionFinSpeaking.
  ///
  /// In en, this message translates to:
  /// **'Fin is speaking…'**
  String get voiceSessionFinSpeaking;

  /// No description provided for @voiceSessionLiveYou.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get voiceSessionLiveYou;

  /// No description provided for @voiceSessionLiveAssistant.
  ///
  /// In en, this message translates to:
  /// **'Fin'**
  String get voiceSessionLiveAssistant;

  /// No description provided for @voiceSessionMicMuted.
  ///
  /// In en, this message translates to:
  /// **'Mic is muted'**
  String get voiceSessionMicMuted;

  /// No description provided for @voiceMicMuteLabel.
  ///
  /// In en, this message translates to:
  /// **'Mute mic'**
  String get voiceMicMuteLabel;

  /// No description provided for @voiceMicUnmuteLabel.
  ///
  /// In en, this message translates to:
  /// **'Unmute mic'**
  String get voiceMicUnmuteLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'bn',
        'en',
        'gu',
        'hi',
        'kn',
        'ml',
        'mr',
        'pa',
        'ta',
        'te'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
    case 'gu':
      return AppLocalizationsGu();
    case 'hi':
      return AppLocalizationsHi();
    case 'kn':
      return AppLocalizationsKn();
    case 'ml':
      return AppLocalizationsMl();
    case 'mr':
      return AppLocalizationsMr();
    case 'pa':
      return AppLocalizationsPa();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
