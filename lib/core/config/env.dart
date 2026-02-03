// Core environment configuration
class Env {
  static const String apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'https://api.pingo.app/v1',
  );

  static const bool debugMode = bool.fromEnvironment(
    'DEBUG_MODE',
    defaultValue: true,
  );
  
  static const String appName = 'PinGo';
}
