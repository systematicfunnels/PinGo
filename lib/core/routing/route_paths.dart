class RoutePaths {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String persona = '/persona';
  static const String home = '/home';
  static const String explore = '/explore';
  static const String create = '/create';
  static const String startJourney = 'start_journey'; // Sub-route of create
  static const String addPin = 'add_pin'; // Sub-route of create
  static const String createTroupe = 'create_troupe'; // Sub-route of create
  static const String library = '/library';
  static const String journeyDetail = 'journey/:id'; // Relative to library
  static const String journeySummary = '/journey_summary/:id';
  static const String memoryReplay = '/memory_replay/:id';
  static const String notifications = 'notifications'; // Relative to profile
  static const String regionSelection = 'select'; // Relative to library
  static const String profile = '/profile';
  static const String mapPreview = '/preview/:id';
  static const String settings = 'settings'; // Relative to profile
  static const String editProfile = 'edit'; // Relative to profile
}
