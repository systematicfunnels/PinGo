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
import 'package:pingo/features/home/presentation/home_screen.dart';

import 'package:pingo/features/route_recording/presentation/journey_summary_screen.dart';
import 'package:pingo/features/route_recording/presentation/memory_replay_screen.dart';
import 'package:pingo/features/notifications/presentation/notifications_screen.dart';
import 'package:pingo/features/map/presentation/region_selection_screen.dart';
import 'package:pingo/features/create/presentation/create_screen.dart';
import 'package:pingo/features/create/presentation/screens/add_pin_screen.dart';
import 'package:pingo/features/create/presentation/screens/create_troupe_screen.dart';
import 'package:pingo/features/map/presentation/map_preview_screen.dart';

part 'app_router.g.dart';

// Private navigators for each tab
final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNav');
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'homeNav');
final _exploreNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'exploreNav');
final _createNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'createNav');
final _libraryNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'libraryNav');
final _profileNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'profileNav');

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePaths.splash,
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

      // Stateful Nested Navigation (The App Shell)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Branch 1: Home
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: RoutePaths.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

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
        ],
      ),
    ],
  );
}
