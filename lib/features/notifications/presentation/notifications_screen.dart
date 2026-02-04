import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: AppSpacing.allLg,
        children: const [
          Text(
            'Today',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          NotificationTile(
            title: 'Welcome to PinGo!',
            subtitle: 'Start your first journey today.',
            time: '2h ago',
            isUnread: true,
          ),
          SizedBox(height: AppSpacing.xl),
          Text(
            'Yesterday',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          NotificationTile(
            title: 'Safety Alert',
            subtitle: 'Heavy rain reported in your area.',
            time: '1d ago',
            isUnread: false,
            icon: Icons.warning_amber_rounded,
            iconColor: AppColors.danger,
          ),
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final bool isUnread;
  final IconData icon;
  final Color iconColor;

  const NotificationTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    this.isUnread = false,
    this.icon = Icons.notifications,
    this.iconColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: isUnread
          ? AppColors.primary.withValues(alpha: 0.05)
          : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.md),
        side: BorderSide(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: ListTile(
        leading: Container(
          padding: AppSpacing.allSm,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Text(
          time,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        onTap: () {},
      ),
    );
  }
}
