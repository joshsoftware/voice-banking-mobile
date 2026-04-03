// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Voice Banking';

  @override
  String get voiceBank => 'VoiceBank';

  @override
  String get bankWithYourVoice => 'Bank with Your Voice';

  @override
  String get mobileNumber => 'Mobile Number';

  @override
  String get sendOtp => 'Send OTP';

  @override
  String get mobileNumberPlaceholder => '1234567890';

  @override
  String get termsDisclaimer => 'By continuing, you agree to our ';

  @override
  String get termsAndConditions => 'Terms & Conditions';

  @override
  String get back => 'Back';

  @override
  String get verifyOtp => 'Verify OTP';

  @override
  String get enterFourDigitCode => 'Enter the 4-digit code sent to your mobile';

  @override
  String get otpSentTo => 'We\'ve sent a 6-digit code to';

  @override
  String get enterOtp => 'Enter OTP';

  @override
  String get verify => 'Verify';

  @override
  String get resendOtp => 'Resend OTP';

  @override
  String resendIn(Object seconds) {
    return 'Resend in ${seconds}s';
  }

  @override
  String otpResendIn(Object seconds) {
    return 'Resend OTP in ${seconds}s';
  }

  @override
  String get otpInvalid => 'Please enter a valid 4-digit code';

  @override
  String get userName => 'User';

  @override
  String get selectLanguage => 'Select language';

  @override
  String get continueButton => 'Continue';

  @override
  String get tapToMute => 'Tap to mute';

  @override
  String get goodMorning => 'Good Morning';

  @override
  String get goodAfternoon => 'Good Afternoon';

  @override
  String get goodEvening => 'Good Evening';

  @override
  String get availableBalance => 'Available Balance';

  @override
  String get savingsAccount => 'Savings Account';

  @override
  String get viewDetails => 'View Details';

  @override
  String get recentTransactions => 'Recent Transactions';

  @override
  String get viewAll => 'View All';

  @override
  String get sayHeyFin => 'Say, \"Hey Fin\"';

  @override
  String get enableVoiceBanking => 'Enable Voice Banking';

  @override
  String get secureAccountWithVoice =>
      'Secure your account with voice biometrics';

  @override
  String get enhancedSecurity => 'Enhanced Security';

  @override
  String get enhancedSecurityDesc =>
      'Your unique voice pattern adds an extra layer of protection';

  @override
  String get quickCommands => 'Quick Commands';

  @override
  String get quickCommandsDesc =>
      'Perform banking tasks instantly with voice commands';

  @override
  String get threeSimpleSteps => '3 Simple Steps';

  @override
  String get threeSimpleStepsDesc =>
      'Record your voice 3 times to create your unique profile';

  @override
  String get voiceConsentText =>
      'I consent to voice data collection for authentication. Recordings will be securely stored for verification only.';

  @override
  String get voiceDataCollection => 'voice data collection';

  @override
  String get authentication => 'authentication';

  @override
  String get securelyStored => 'securely stored';

  @override
  String get startRegistration => 'Start Registration';

  @override
  String get skipForNow => 'Skip for Now';

  @override
  String get tapToUnmute => 'Tap to unmute';

  @override
  String get tapToMute2 => 'Tap to mute';

  @override
  String get setupVoiceBanking => 'Set up Voice Banking';

  @override
  String get setupVoiceBankingDesc =>
      'Secure your account with voice biometrics';

  @override
  String get tapToSpeak => 'Tap to speak';

  @override
  String get tapToStop => 'Tap to stop';

  @override
  String get setUpVoiceByDescribing => 'Set up your voice by ';

  @override
  String get describingTheImage => 'describing the image.';

  @override
  String get takesUnder15Seconds => 'Takes under 15 seconds.';

  @override
  String get tapToStartSpeaking => 'Tap to start speaking';

  @override
  String recordingPercent(Object percent) {
    return 'Recording...$percent%';
  }

  @override
  String get reRecord => 'Re-record';

  @override
  String get submit => 'Submit';

  @override
  String get voiceRegistration => 'Voice Registration';

  @override
  String get skip => 'Skip';

  @override
  String get pleaseWaitForUpload => 'Please wait for upload to complete';

  @override
  String get voiceRegistrationCompleted =>
      'Voice registration completed successfully!';

  @override
  String get unknownState => 'Unknown state';

  @override
  String get uploadingVoiceRecordings => 'Uploading voice recordings...';

  @override
  String imageNumber(Object number) {
    return 'Image $number';
  }

  @override
  String get somethingWentWrong => 'Something went wrong, please try again!';

  @override
  String get imageNotAvailable => 'Image not available';

  @override
  String stepOfTotal(Object current, Object total) {
    return 'Step $current of $total';
  }

  @override
  String describeImageInstruction(Object seconds) {
    return 'Please describe what you see in this image in up to $seconds seconds. Speak clearly and describe the main elements.';
  }

  @override
  String get stopRecording => 'Stop Recording';

  @override
  String get startRecording => 'Start Recording';

  @override
  String get recording => 'Recording...';

  @override
  String get nextStep => 'Next Step';

  @override
  String get register => 'Register';

  @override
  String get pleaseWaitForDescription =>
      'Please wait for the description to finish playing.';

  @override
  String get microphonePermissionRequired =>
      'Microphone permission is required. Please enable it in Settings.';

  @override
  String failedToStartRecording(Object error) {
    return 'Failed to start recording: $error';
  }

  @override
  String get recordingFailed => 'Recording failed. Please try again.';

  @override
  String get recordingFileNotFound =>
      'Recording file not found. Please try again.';

  @override
  String get recordingEmpty => 'Recording is empty. Please try again.';

  @override
  String pleaseSpeakAtLeastSeconds(Object seconds) {
    return 'Please speak for at least $seconds seconds.';
  }

  @override
  String failedToStopRecording(Object error) {
    return 'Failed to stop recording: $error';
  }

  @override
  String get pleaseStopRecordingBeforePlay =>
      'Please stop recording before playing the description.';

  @override
  String failedToPlayDescription(Object error) {
    return 'Failed to play description: $error';
  }

  @override
  String failedToStopDescription(Object error) {
    return 'Failed to stop description: $error';
  }

  @override
  String get pleaseRecordBeforeProceeding =>
      'Please record your voice before proceeding.';

  @override
  String get pleaseWaitForRecordingOrDescription =>
      'Please wait for recording or description to complete.';

  @override
  String get pleaseCompleteAllRecordings =>
      'Please complete all 3 recordings before submitting.';

  @override
  String get userIdNotFound => 'User ID not found. Please log in again.';

  @override
  String get recordingFilesMissing =>
      'One or more recording files are missing.';

  @override
  String get pleaseSaySomething => 'Please say something';

  @override
  String get imageDescriptionBoardMeeting =>
      'A professional man gives a data presentation to colleagues in a modern, sunlit office boardroom overlooking a scenic city skyline.';

  @override
  String get imageDescriptionBoyWithDog =>
      'A boy wearing glasses walks a husky dog on a sunny park pathway, smiling while holding the leash.';

  @override
  String get imageDescriptionChildrenPainting =>
      'Five children sit on a carpet near a large window, happily painting colorful pictures together inside a bright living room.';

  @override
  String get imageDescriptionChildrenWithDog =>
      'Four children play joyfully with two dogs in a lush green garden, tossing a frisbee under the bright afternoon sun.';

  @override
  String get imageDescriptionConstructionSite =>
      'Four construction professionals in safety vests and hard hats stand on a dusty site, carefully reviewing a large architectural building blueprint.';

  @override
  String get imageDescriptionFamilyDinner =>
      'A happy family of four enjoys a traditional Indian dinner at a restaurant, sharing food and laughter in a warm atmosphere.';

  @override
  String get imageDescriptionHoliCelebration =>
      'A joyful group of family and friends celebrate Holi, laughing together amidst a vibrant explosion of colorful powders in the air.';

  @override
  String get imageDescriptionLadyPainting =>
      'A young woman focuses on painting a beautiful yellow landscape on a canvas in her sun-drenched, cozy home art studio.';

  @override
  String get imageDescriptionMomAndSon =>
      'A mother helps her young son cook at the stove, standing on a wooden stool in a bright, modern white kitchen.';

  @override
  String get imageDescriptionPeopleDiwaliCelebration =>
      'People in traditional attire celebrate Diwali on a decorated street with vibrant lanterns, glowing diyas, and a spectacular firework display overhead.';

  @override
  String get imageDescriptionTajMahal =>
      'A group of young friends in denim jackets stands on a rooftop, holding coffee and smiling with the Taj Mahal behind.';

  @override
  String get imageDescriptionVillageScene =>
      'An elderly farmer sits atop a wooden bullock cart pulled by two white oxen, carrying a large harvest during a golden sunset.';

  @override
  String get imageDescriptionWomenDiwaliCelebration =>
      'A woman in pink traditional clothing carefully creates a beautiful, colorful rangoli on the ground surrounded by glowing oil lamps.';

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
