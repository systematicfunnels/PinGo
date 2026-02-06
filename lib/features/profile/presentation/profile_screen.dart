import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/presentation/widgets/molecules/pingo_button.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/core/utils/geo_utils.dart';
import '../domain/profile_state.dart';
import 'controllers/profile_controller.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_section.dart';
import 'widgets/stat_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.neutral.s50,
      body: SafeArea(
        child: profileAsync.when(
          data: (state) {
            final user = state.user;
            if (user == null) {
              return const Center(child: Text('User not found'));
            }

            return RefreshIndicator(
              onRefresh: () =>
                  ref.read(profileControllerProvider.notifier).refresh(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: AppSpacing.allXl,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Overview
                    ProfileHeader(
                      username: user.username,
                      role: user.role,
                      bio: user.bio,
                      mapCount: state.stats.totalJourneys,
                    ),
                    const SizedBox(height: AppSpacing.xxl),

                    // 2. Stats
                    _StatsRow(stats: state.stats),
                    const SizedBox(height: AppSpacing.xxl),

                    // 3. Public View
                    ProfileSection(
                      title: 'Public View',
                      children: [
                        ProfileMenuTile(
                          icon: Icons.map_outlined,
                          title: 'Public Maps',
                          subtitle:
                              '${state.stats.totalJourneys} visible to everyone',
                          onTap: () {},
                        ),
                        const Divider(height: 1, indent: 56),
                        ProfileMenuTile(
                          icon: Icons.history_edu,
                          title: 'Shared Stories',
                          subtitle:
                              '${state.stats.totalPins} stories published',
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // 4. Trusted Circle
                    ProfileSection(
                      title: 'Trusted Circle',
                      children: [
                        ProfileMenuTile(
                          icon: Icons.verified_user_outlined,
                          title: 'Trusted Users',
                          subtitle: 'Manage who can see your private pins',
                          onTap: () {},
                        ),
                        const Divider(height: 1, indent: 56),
                        ProfileMenuTile(
                          icon: Icons.person_add_outlined,
                          title: 'Invite / Remove',
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // 5. Settings
                    ProfileSection(
                      title: 'Settings',
                      children: [
                        ProfileMenuTile(
                          icon: Icons.security,
                          title: 'Privacy & Permissions',
                          onTap: () {},
                        ),
                        const Divider(height: 1, indent: 56),
                        ProfileMenuTile(
                          icon: Icons.offline_pin_outlined,
                          title: 'Offline & Storage',
                          onTap: () {},
                        ),
                        const Divider(height: 1, indent: 56),
                        ProfileMenuTile(
                          icon: Icons.notifications_outlined,
                          title: 'Notifications',
                          onTap: () => context.push(RoutePaths.notifications),
                        ),
                        const Divider(height: 1, indent: 56),
                        ProfileMenuTile(
                          icon: Icons.manage_accounts_outlined,
                          title: 'Account',
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    // 6. Help & Safety
                    ProfileSection(
                      title: 'Help & Safety',
                      children: [
                        ProfileMenuTile(
                          icon: Icons.menu_book_outlined,
                          title: 'Guidelines',
                          onTap: () {},
                        ),
                        const Divider(height: 1, indent: 56),
                        ProfileMenuTile(
                          icon: Icons.report_problem_outlined,
                          title: 'Report Issue',
                          onTap: () {},
                        ),
                        const Divider(height: 1, indent: 56),
                        ProfileMenuTile(
                          icon: Icons.local_hospital_outlined,
                          title: 'Emergency Info',
                          iconColor: AppColors.error.s500,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                  ],
                ),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: $error'),
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  width: 120,
                  child: PingoButton.primary(
                    onPressed: () =>
                        ref.read(profileControllerProvider.notifier).refresh(),
                    label: 'Retry',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final ProfileStats stats;

  const _StatsRow({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            label: 'Pins',
            value: stats.totalPins.toString(),
            icon: Icons.push_pin_outlined,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: StatCard(
            label: 'Distance',
            value: GeoUtils.formatDistance(stats.totalDistanceMeters),
            icon: Icons.directions_walk_outlined,
          ),
        ),
      ],
    );
  }
}
