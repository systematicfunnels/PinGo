import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'package:pingo/core/presentation/widgets/layouts/layouts.dart';
import 'package:pingo/features/onboarding/presentation/splash_screen.dart';
import 'package:pingo/features/onboarding/presentation/welcome_screen.dart';
import 'package:pingo/features/onboarding/presentation/persona_selection_screen.dart';
import 'package:pingo/features/library/presentation/library_screen.dart';
import 'package:pingo/features/explore/presentation/explore_screen.dart';
import 'package:pingo/features/route_recording/presentation/record_screen.dart';
import 'package:pingo/features/route_recording/presentation/journey_detail_screen.dart';
import 'package:pingo/features/profile/presentation/profile_screen.dart';
<<<<<<< HEAD
import 'package:pingo/features/pins/presentation/screens/pin_editor_screen.dart';
import 'package:pingo/features/pins/presentation/screens/enhanced_pin_editor_screen.dart';
=======
import 'package:pingo/features/home/presentation/home_screen.dart';
>>>>>>> 7bff084ce9060fcc732c36c2de38dd4d786fe41c

import 'package:pingo/features/route_recording/presentation/journey_summary_screen.dart';
import 'package:pingo/features/route_recording/presentation/memory_replay_screen.dart';
import 'package:pingo/features/notifications/presentation/notifications_screen.dart';
<<<<<<< HEAD
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
=======
import 'package:pingo/features/map/presentation/region_selection_screen.dart';
import 'package:pingo/features/create/presentation/create_screen.dart';
import 'package:pingo/features/create/presentation/screens/add_pin_screen.dart';
import 'package:pingo/features/create/presentation/screens/create_troupe_screen.dart';
import 'package:pingo/features/map/presentation/map_preview_screen.dart';
>>>>>>> 7bff084ce9060fcc732c36c2de38dd4d786fe41c

part 'app_router.g.dart';

// Private navigators for each tab
<<<<<<< HEAD
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'homeNav');
final _mapNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'mapNav');
=======
final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNav');
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'homeNav');
final _exploreNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'exploreNav');
final _createNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'createNav');
>>>>>>> 7bff084ce9060fcc732c36c2de38dd4d786fe41c
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
        path: RoutePaths.mapPreview,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return MapPreviewScreen(mapId: id);
        },
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
<<<<<<< HEAD
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
=======
>>>>>>> 7bff084ce9060fcc732c36c2de38dd4d786fe41c

      // Stateful Nested Navigation (The App Shell)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
<<<<<<< HEAD
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
=======
          // Branch 1: Home
>>>>>>> 7bff084ce9060fcc732c36c2de38dd4d786fe41c
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: RoutePaths.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

<<<<<<< HEAD
          // Branch 3: Library (Pins List)
=======
          // Branch 2: Explore (Map)
          StatefulShellBranch(
            navigatorKey: _exploreNavigatorKey,
            routes: [
              GoRoute(
                path: RoutePaths.explore,
                builder: (context, state) => const ExploreScreen(),
              ),
            ],
          ),

          // Branch 3: Create
>>>>>>> 7bff084ce9060fcc732c36c2de38dd4d786fe41c
          StatefulShellBranch(
            navigatorKey: _createNavigatorKey,
            routes: [
              GoRoute(
                path: RoutePaths.create,
                builder: (context, state) => const CreateScreen(),
                routes: [
                  GoRoute(
                    path: RoutePaths.startJourney,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const RecordScreen(),
                  ),
                  GoRoute(
                    path: RoutePaths.addPin,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      final extra = state.extra as Map<String, dynamic>?;
                      final journeyId = extra?['journeyId'] as int?;
                      return AddPinScreen(journeyId: journeyId);
                    },
                  ),
                  GoRoute(
                    path: RoutePaths.createTroupe,
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const CreateTroupeScreen(),
                  ),
                ],
              ),
            ],
          ),
<<<<<<< HEAD
=======

          // Branch 4: Library
          StatefulShellBranch(
            navigatorKey: _libraryNavigatorKey,
            routes: [
              GoRoute(
                path: RoutePaths.library,
                builder: (context, state) => const LibraryScreen(),
                routes: [
                  GoRoute(
                    path: RoutePaths.journeyDetail,
                    builder: (context, state) {
                      final id = int.parse(state.pathParameters['id']!);
                      return JourneyDetailScreen(journeyId: id);
                    },
                  ),
                  GoRoute(
                    path: RoutePaths.regionSelection,
                    builder: (context, state) => const RegionSelectionScreen(),
                  ),
                ],
              ),
            ],
          ),

          // Branch 5: Profile
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                path: RoutePaths.profile,
                builder: (context, state) => const ProfileScreen(),
                routes: [
                  GoRoute(
                    path: RoutePaths.notifications,
                    builder: (context, state) => const NotificationsScreen(),
                  ),
                ],
              ),
            ],
          ),
>>>>>>> 7bff084ce9060fcc732c36c2de38dd4d786fe41c
        ],
      ),
    ],
  );
}
