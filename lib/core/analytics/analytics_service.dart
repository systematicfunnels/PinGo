import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'analytics_backend.dart';

part 'analytics_service.g.dart';

@Riverpod(keepAlive: true)
AnalyticsService analyticsService(Ref ref) {
  // Switch to RealBackend when ready
  return AnalyticsService(ConsoleAnalyticsBackend());
}

// Analytics service implementation
class AnalyticsService {
  final AnalyticsBackend _backend;
  bool _enabled = true;

  AnalyticsService(this._backend) {
    _backend.init();
  }

  /// Enable or disable analytics tracking (Privacy)
  void setEnabled(bool enabled) {
    _enabled = enabled;
    if (kDebugMode) {
      debugPrint('Analytics: ${enabled ? 'Enabled' : 'Disabled'}');
    }
  }

  void logEvent(String name, [Map<String, dynamic>? parameters]) {
    if (!_enabled) return;

    if (kDebugMode) {
      debugPrint('Analytics: $name $parameters');
    }
    
    _backend.logEvent(name, parameters);
  }
  
  void setUserId(String? userId) {
    if (!_enabled) return;
    _backend.setUserId(userId);
  }
  
  void setUserProperties(Map<String, dynamic> properties) {
    if (!_enabled) return;
    _backend.setUserProperties(properties);
  }
}
