import 'package:flutter/foundation.dart';

// Analytics service interface
class AnalyticsService {
  void logEvent(String name, [Map<String, dynamic>? parameters]) {
    if (kDebugMode) {
      debugPrint('Analytics: $name $parameters');
    }
  }
}
