import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'package:pingo/core/presentation/widgets/scaffold_with_nav_bar.dart';
import 'package:pingo/features/onboarding/presentation/splash_screen.dart';
import 'package:pingo/features/onboarding/presentation/welcome_screen.dart';
import 'package:pingo/features/onboarding/presentation/persona_selection_screen.dart';
import 'package:pingo/features/pins/presentation/screens/pins_screen.dart';
import 'package:pingo/features/map/presentation/map_screen.dart';
import 'package:pingo/features/route_recording/presentation/record_screen.dart';
import 'package:pingo/features/route_recording/presentation/journey_detail_screen.dart';
import 'package:pingo/features/profile/presentation/profile_screen.dart';
import 'package:pingo/features/pins/presentation/screens/pin_editor_screen.dart';
import 'package:pingo/features/pins/presentation/screens/enhanced_pin_editor_screen.dart';

import 'package:pingo/features/route_recording/presentation/journey_summary_screen.dart';
import 'package:pingo/features/route_recording/presentation/memory_replay_screen.dart';
import 'package:pingo/features/notifications/presentation/notifications_screen.dart';
import 'package:pingo/features/feed/presentation/home_feed_screen.dart';
import 'package:pingo/features/map/presentation/saved_maps_screen.dart';
import 'package:pingo/features/ask_pingo/presentation/screens/ask_context_screen.dart';
import 'package:pingo/features/ask_pingo/presentation/screens/ask_intent_screen.dart';
import 'package:pingo/features/ask_pingo/presentation/screens/ask_input_screen.dart';
import 'package:pingo/features/ask_pingo/presentation/screens/ask_processing_screen.dart';
import 'package:pingo/features/ask_pingo/presentation/screens/ask_response_screen.dart';

import 'package:pingo/features/profile/presentation/screens/privacy_sharing_screen.dart';
import 'package:pingo/features/profile/presentation/screens/offline_manager_screen.dart';
import 'package:pingo/features/pins/presentation/screens/safety_pin_screen.dart';

part 'app_router.g.dart';

// Private navigators for each tab
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'homeNav');
final _mapNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'mapNav');
final _libraryNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'libraryNav');

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePaths.homeFeed,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: RoutePaths.persona,
        builder: (context, state) => const PersonaSelectionScreen(),
      ),
      GoRoute(
        path: RoutePaths.journeySummary,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return JourneySummaryScreen(journeyId: id);
        },
      ),
      GoRoute(
        path: RoutePaths.memoryReplay,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return MemoryReplayScreen(journeyId: id);
        },
      ),
      GoRoute(
        path: RoutePaths.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: RoutePaths.savedMaps,
        builder: (context, state) => const SavedMapsScreen(),
      ),
      GoRoute(
        path: RoutePaths.record,
        builder: (context, state) => const RecordScreen(),
      ),
      GoRoute(
        path: RoutePaths.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: RoutePaths.pinEditor,
        builder: (context, state) {
          final lat = state.uri.queryParameters['lat'] != null
              ? double.tryParse(state.uri.queryParameters['lat']!)
              : null;
          final lng = state.uri.queryParameters['lng'] != null
              ? double.tryParse(state.uri.queryParameters['lng']!)
              : null;
          return PinEditorScreen(lat: lat, lng: lng);
        },
      ),
      GoRoute(
        path: RoutePaths.enhancedPinEditor,
        builder: (context, state) => const EnhancedPinEditorScreen(),
      ),
      GoRoute(
        path: RoutePaths.askContext,
        builder: (context, state) => const AskContextScreen(),
      ),
      GoRoute(
        path: RoutePaths.askIntent,
        builder: (context, state) => const AskIntentScreen(),
      ),
      GoRoute(
        path: RoutePaths.askInput,
        builder: (context, state) => const AskInputScreen(),
      ),
      GoRoute(
        path: RoutePaths.askProcessing,
        builder: (context, state) => const AskProcessingScreen(),
      ),
      GoRoute(
        path: RoutePaths.askResponse,
        builder: (context, state) => const AskResponseScreen(),
      ),
      GoRoute(
        path: RoutePaths.privacySharing,
        builder: (context, state) => const PrivacySharingScreen(),
      ),
      GoRoute(
        path: RoutePaths.offlineManager,
        builder: (context, state) => const OfflineManagerScreen(),
      ),
      GoRoute(
        path: RoutePaths.safetyPin,
        builder: (context, state) => const SafetyPinScreen(),
      ),

      // Stateful Nested Navigation (The App Shell)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Branch 1: Home (Feed)
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: RoutePaths.homeFeed,
                builder: (context, state) => const HomeFeedScreen(),
              ),
            ],
          ),

          // Branch 2: Explore (Map)
          StatefulShellBranch(
            navigatorKey: _mapNavigatorKey,
            routes: [
              GoRoute(
                path: RoutePaths.map,
                builder: (context, state) => const MapScreen(),
              ),
            ],
          ),

          // Branch 3: Library (Pins List)
          StatefulShellBranch(
            navigatorKey: _libraryNavigatorKey,
            routes: [
              GoRoute(
                path: RoutePaths.library,
                builder: (context, state) => const PinsScreen(),
                routes: [
                  GoRoute(
                    path: 'journey/:id',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return JourneyDetailScreen(journeyId: id);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
