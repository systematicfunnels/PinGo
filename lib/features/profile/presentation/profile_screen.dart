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
<<<<<<< HEAD
=======
import 'widgets/profile_header.dart';
import 'widgets/profile_section.dart';
import 'widgets/stat_card.dart';
>>>>>>> 7bff084ce9060fcc732c36c2de38dd4d786fe41c

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.neutral.s50,
      body: SafeArea(
<<<<<<< HEAD
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => context.go(RoutePaths.homeFeed),
                    icon: const Icon(Icons.arrow_back),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      shape: const CircleBorder(),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Profile',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontFamily: 'Serif',
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'Your journey identity',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Profile Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
=======
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
>>>>>>> 7bff084ce9060fcc732c36c2de38dd4d786fe41c
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
<<<<<<< HEAD
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person, color: AppColors.primary, size: 40),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Trail Explorer',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontFamily: 'Serif',
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Member since February 2026',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    
                    const SizedBox(height: 24),
                    const Divider(height: 1),
                    const SizedBox(height: 24),

                    // Stats
                    statsAsync.when(
                      data: (stats) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _StatItem(
                            value: stats.totalJourneys.toString(),
                            label: 'Journeys',
                          ),
                          _StatItem(
                            value: stats.totalPins.toString(),
                            label: 'Pins',
                          ),
                          _StatItem(
                            value: '${stats.totalDistanceKm.toStringAsFixed(0)}km',
                            label: 'Explored',
                          ),
                        ],
                      ),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => const Text('Error loading stats'),
=======
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
>>>>>>> 7bff084ce9060fcc732c36c2de38dd4d786fe41c
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
<<<<<<< HEAD

              const SizedBox(height: 32),

              // Journey Style
              Text(
                'Your journey style',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _RoleChip(
                    label: 'Mountaineer',
                    icon: Icons.landscape,
                    color: AppColors.primary,
                  ),
                  _RoleChip(
                    label: 'Path Finder',
                    icon: Icons.map,
                    color: AppColors.accent,
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Settings
              Text(
                'Settings',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              _SettingsButton(
                icon: Icons.lock_outline,
                title: 'Privacy controls',
                subtitle: 'Manage who sees your journeys',
                onTap: () => context.push(RoutePaths.privacySharing),
              ),
              const SizedBox(height: 12),
              _SettingsButton(
                icon: Icons.wifi_off,
                title: 'Offline mode',
                subtitle: 'Download maps for offline use',
                onTap: () => context.push(RoutePaths.offlineManager),
              ),
              const SizedBox(height: 12),
              _SettingsButton(
                icon: Icons.location_on_outlined,
                title: 'Location settings',
                subtitle: 'Adjust GPS accuracy & permissions',
                onTap: () {},
              ),

              const SizedBox(height: 32),

              // Help & Safety
              Text(
                'Help & Safety',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              _SettingsButton(
                icon: Icons.help_outline,
                title: 'Help & Support',
                subtitle: 'Get answers to your questions',
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _SettingsButton(
                icon: Icons.security,
                title: 'Safety & Guidelines',
                subtitle: 'Community care practices',
                onTap: () => context.push(RoutePaths.safetyPin),
              ),

              const SizedBox(height: 40),
              
              // Footer
              Center(
                child: Column(
                  children: [
                    Text(
                      'Pingo',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontFamily: 'Serif',
                            color: AppColors.primary,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Pin it. Plan it. Go.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Version 1.0.0',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
=======
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
>>>>>>> 7bff084ce9060fcc732c36c2de38dd4d786fe41c
          ),
        ),
      ),
    );
  }
}

<<<<<<< HEAD
class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Serif',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
=======
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
>>>>>>> 7bff084ce9060fcc732c36c2de38dd4d786fe41c
          ),
        ),
      ],
    );
  }
}
<<<<<<< HEAD

class _RoleChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _RoleChip({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.background),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, color: AppColors.textPrimary, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
=======
>>>>>>> 7bff084ce9060fcc732c36c2de38dd4d786fe41c
