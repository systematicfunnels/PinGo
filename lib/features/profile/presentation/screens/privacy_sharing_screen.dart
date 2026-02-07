import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/theme/app_theme.dart';

class PrivacySharingScreen extends StatefulWidget {
  const PrivacySharingScreen({super.key});

  @override
  State<PrivacySharingScreen> createState() => _PrivacySharingScreenState();
}

class _PrivacySharingScreenState extends State<PrivacySharingScreen> {
  String? _selectedId;

  final List<_PrivacyOption> _options = [
    _PrivacyOption(
      id: 'private',
      icon: Icons.lock_outline,
      title: 'Private',
      description: 'Only you can see this journey',
      details: 'This journey will be saved to your device only. No one else can access it unless you change this setting later.',
    ),
    _PrivacyOption(
      id: 'trusted',
      icon: Icons.people_outline,
      title: 'Trusted Circle',
      description: 'Share with specific friends',
      details: 'Visible only to people you have explicitly added to your Trusted Circle. You can manage this list in Settings.',
    ),
    _PrivacyOption(
      id: 'link',
      icon: Icons.link,
      title: 'Anyone with link',
      description: 'Share via unique URL',
      details: 'Anyone who has the link can view this journey. It will not appear in public search results or the Explore feed.',
    ),
    _PrivacyOption(
      id: 'public',
      icon: Icons.public,
      title: 'Public',
      description: 'Visible to everyone',
      details: 'Your journey can be discovered by anyone on PinGo. It may appear in the Explore feed and search results.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      shape: const CircleBorder(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _selectedId == null
                        ? null
                        : () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Confirm Change'),
                                content: Text(
                                  'Are you sure you want to change the privacy setting to ${_options.firstWhere((o) => o.id == _selectedId).title}?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => context.pop(),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.pop(); // Close dialog
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Privacy setting saved')),
                                      );
                                      context.pop(); // Close screen
                                    },
                                    child: const Text('Confirm'),
                                  ),
                                ],
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text('Continue'),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  Text(
                    'Privacy & Sharing',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontFamily: 'Serif',
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Control who can see your journey and how it is shared with the community.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 32),
                  ..._options.map((option) {
                    final isSelected = _selectedId == option.id;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () => setState(() => _selectedId = option.id),
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withValues(alpha: 0.05)
                                : AppColors.surface,
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(alpha: 0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    )
                                  ]
                                : null,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.primary.withValues(alpha: 0.2)
                                          : AppColors.background,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      option.icon,
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.textPrimary,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          option.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Serif',
                                              ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          option.description,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: AppColors.textSecondary,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (isSelected) ...[
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.background.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.info_outline,
                                        size: 16,
                                        color: AppColors.textSecondary,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          option.details,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: AppColors.textSecondary,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      'You can always change this later in settings',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
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

class _PrivacyOption {
  final String id;
  final IconData icon;
  final String title;
  final String description;
  final String details;

  _PrivacyOption({
    required this.id,
    required this.icon,
    required this.title,
    required this.description,
    required this.details,
  });
}
