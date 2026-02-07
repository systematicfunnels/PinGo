import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feature_flags.g.dart';

@Riverpod(keepAlive: true)
FeatureFlags featureFlags(Ref ref) {
  return FeatureFlags();
}

class FeatureFlags {
  // Core features
  final bool enableSharing = true;
  final bool enableSync = false; // Sync infrastructure pending
  final bool enableAnalytics = true; // Privacy-first analytics
  final bool enableTroupes = true;

  // Experimental
  final bool enableNewMapRenderer = false;

  // Debug
  final bool showDebugOverlay = false;

  const FeatureFlags();
}
