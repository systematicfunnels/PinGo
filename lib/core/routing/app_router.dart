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

part 'app_router.g.dart';

// Private navigators for each tab
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _mapNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'mapNav');
final _recordNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'recordNav');
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

      // Stateful Nested Navigation (The App Shell)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Branch 1: Map
          StatefulShellBranch(
            navigatorKey: _mapNavigatorKey,
            routes: [
              GoRoute(
                path: RoutePaths.map,
                builder: (context, state) => const MapScreen(),
              ),
            ],
          ),

          // Branch 2: Record (Go)
          StatefulShellBranch(
            navigatorKey: _recordNavigatorKey,
            routes: [
              GoRoute(
                path: RoutePaths.record,
                builder: (context, state) => const RecordScreen(),
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

          // Branch 4: Profile
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                path: RoutePaths.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
