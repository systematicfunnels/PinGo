class RoutePaths {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String persona = '/persona';
<<<<<<< HEAD
  static const String map = '/map';
  static const String homeFeed = '/feed';
  static const String record = '/record';
=======
  static const String home = '/home';
  static const String explore = '/explore';
  static const String create = '/create';
  static const String startJourney = 'start_journey'; // Sub-route of create
  static const String addPin = 'add_pin'; // Sub-route of create
  static const String createTroupe = 'create_troupe'; // Sub-route of create
>>>>>>> 7bff084ce9060fcc732c36c2de38dd4d786fe41c
  static const String library = '/library';
  static const String journeyDetail = 'journey/:id'; // Relative to library
  static const String journeySummary = '/journey_summary/:id';
  static const String memoryReplay = '/memory_replay/:id';
<<<<<<< HEAD
  static const String savedMaps = '/saved_maps'; // New
  static const String notifications = '/notifications';
  static const String profile = '/profile';
  static const String pinEditor = '/pin_editor';
  static const String enhancedPinEditor = '/enhanced_pin_editor';
  static const String askContext = '/ask_context';
  static const String askIntent = '/ask_intent';
  static const String askInput = '/ask_input';
  static const String askProcessing = '/ask_processing';
  static const String askResponse = '/ask_response';
  
  // Profile
  static const String privacySharing = '/privacy_sharing';
  static const String offlineManager = '/offline_manager';
  static const String safetyPin = '/safety_pin';
=======
  static const String notifications = 'notifications'; // Relative to profile
  static const String regionSelection = 'select'; // Relative to library
  static const String profile = '/profile';
  static const String mapPreview = '/preview/:id';
  static const String settings = 'settings'; // Relative to profile
  static const String editProfile = 'edit'; // Relative to profile
>>>>>>> 7bff084ce9060fcc732c36c2de38dd4d786fe41c
}
