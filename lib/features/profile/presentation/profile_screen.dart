import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'controllers/profile_controller.dart';
import 'widgets/stat_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(profileControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.allXl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.xl),
              // Header
              Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child:
                        const Icon(Icons.person, color: Colors.white, size: 32),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Explorer',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        'Offline Mode',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.xxl),

              // Stats Grid
              Text(
                'Overview',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppSpacing.lg),

              statsAsync.when(
                data: (stats) => Column(
                  children: [
                    StatCard(
                      label: 'Pins Dropped',
                      value: stats.totalPins.toString(),
                      icon: Icons.location_on_outlined,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    StatCard(
                      label: 'Journeys',
                      value: stats.totalJourneys.toString(),
                      icon: Icons.directions_walk,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    StatCard(
                      label: 'Km Walked',
                      value: stats.totalDistanceKm.toStringAsFixed(1),
                      icon: Icons.straighten,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    StatCard(
                      label: 'Hours',
                      value: stats.totalDurationHours.toString(),
                      icon: Icons.timer_outlined,
                    ),
                  ],
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Text('Error loading stats: $err'),
              ),

              const SizedBox(height: AppSpacing.xxl),

              // Settings List
              Text(
                'Settings',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppSpacing.lg),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppSpacing.lg),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.notifications_outlined),
                      title: const Text('Notifications'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push(RoutePaths.notifications),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.cloud_off_outlined),
                      title: const Text('Sync Status'),
                      subtitle: const Text('Local only (Private)'),
                      trailing: Switch(
                        value: false,
                        onChanged: (val) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Cloud sync is coming soon!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.map_outlined),
                      title: const Text('Offline Maps'),
                      subtitle: const Text('Manage downloaded regions'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push(RoutePaths.savedMaps),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: const Text('About PinGo'),
                      subtitle: const Text('v1.0.0'),
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationName: 'PinGo',
                          applicationVersion: '1.0.0',
                          applicationLegalese: '© 2024 PinGo Explorer',
                          children: [
                            const SizedBox(height: 16),
                            const Text(
                                'PinGo is a local-first exploration app designed for off-grid adventures.'),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xxl),

              // Danger Zone
              Text(
                'Danger Zone',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.danger,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Reset App Data?'),
                        content: const Text(
                            'This will delete all your pins, journeys, and settings. This action cannot be undone.'),
                        actions: [
                          TextButton(
                            onPressed: () => context.pop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              context.pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Reset feature coming soon')),
                              );
                            },
                            child: const Text('Reset Everything',
                                style: TextStyle(color: AppColors.danger)),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete_forever, color: AppColors.danger),
                  label: const Text('Reset App Data',
                      style: TextStyle(color: AppColors.danger)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.danger),
                    padding: const EdgeInsets.all(AppSpacing.lg),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}
