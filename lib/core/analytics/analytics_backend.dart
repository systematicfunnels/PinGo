
abstract class AnalyticsBackend {
  Future<void> init();
  void logEvent(String name, Map<String, dynamic>? parameters);
  void setUserProperties(Map<String, dynamic> properties);
  void setUserId(String? userId);
}

class ConsoleAnalyticsBackend implements AnalyticsBackend {
  @override
  Future<void> init() async {
    // No initialization needed for console
  }

  @override
  void logEvent(String name, Map<String, dynamic>? parameters) {
    // In production, this would be disabled or filtered
    // print('Analytics: $name $parameters'); 
  }

  @override
  void setUserProperties(Map<String, dynamic> properties) {
    // print('Analytics User Properties: $properties');
  }

  @override
  void setUserId(String? userId) {
    // print('Analytics User ID: $userId');
  }
}
