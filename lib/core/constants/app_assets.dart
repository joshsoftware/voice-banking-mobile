/// Central constants for asset paths. Do not hardcode paths in UI/VM code.
class AppAssets {
  AppAssets._();

  static const String loginScreenLogo = 'assets/svg/login_screen_logo.svg';
  static const String voiceRecordingAnimation =
      'assets/animations/voice-recording-animation.json';
  static const String voiceRegistrationOffice =
      'assets/images/voice_registration_office.jpg';

  /// 13 images for voice registration (pick 3 randomly).
  static const List<String> voiceRegistrationImages = [
    'assets/images/board_meeting.png',
    'assets/images/boy_with_dog.png',
    'assets/images/children_painting.png',
    'assets/images/children_with_dog.png',
    'assets/images/construction_site.png',
    'assets/images/family_dinner.png',
    'assets/images/holi_celebration.png',
    'assets/images/lady_painting.png',
    'assets/images/mom_and_son.png',
    'assets/images/people_diwali_celebration.png',
    'assets/images/taj_mahal.png',
    'assets/images/village_scene.png',
    'assets/images/women_diwali_celebration.png',
  ];
}
