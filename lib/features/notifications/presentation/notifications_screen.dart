import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/features/notifications/domain/notification_entity.dart';
import 'package:pingo/features/notifications/presentation/notifications_controller.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            tooltip: 'Mark all as read',
            onPressed: notifications.isEmpty
                ? null
                : () {
                    ref
                        .read(notificationsControllerProvider.notifier)
                        .markAllAsRead();
                  },
          ),
          // Dev toggle for empty state
          IconButton(
            icon: const Icon(Icons.cleaning_services_outlined),
            tooltip: 'Toggle Empty State (Dev)',
            onPressed: () {
              if (notifications.isEmpty) {
                ref
                    .read(notificationsControllerProvider.notifier)
                    .restoreMockData();
              } else {
                ref.read(notificationsControllerProvider.notifier).clearAll();
              }
            },
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const _EmptyState()
          : ListView.builder(
              padding: AppSpacing.allLg,
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: Dismissible(
                    key: Key(notification.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) {
                      ref
                          .read(notificationsControllerProvider.notifier)
                          .removeNotification(notification.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Notification dismissed'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              ref
                                  .read(
                                      notificationsControllerProvider.notifier)
                                  .restoreMockData(); // Simplified undo for now
                            },
                          ),
                        ),
                      );
                    },
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: AppColors.error.s500,
                        borderRadius: BorderRadius.circular(AppSpacing.md),
                      ),
                      child:
                          const Icon(Icons.delete_outline, color: Colors.white),
                    ),
                    child: NotificationTile(item: notification),
                  ),
                );
              },
            ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 64,
            color: AppColors.neutral.s500.withValues(alpha: 0.5),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'All quiet here',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.neutral.s700,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'You are all caught up.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.neutral.s500,
                ),
          ),
        ],
      ),
    );
  }
}

class NotificationTile extends ConsumerWidget {
  final NotificationItem item;

  const NotificationTile({super.key, required this.item});

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSystem = item.type == NotificationType.system;
    final iconColor =
        isSystem ? AppColors.neutral.s700 : AppColors.primary.s500;
    final backgroundColor = item.isUnread
        ? AppColors.primary.s500.withValues(alpha: 0.05)
        : Colors.transparent;

    return Card(
      elevation: 0,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.md),
        side: BorderSide(
          color: AppColors.neutral.s300.withValues(alpha: 0.5),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        leading: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(item.icon, color: iconColor, size: 24),
        ),
        title: Text(
          item.title,
          style: TextStyle(
            fontWeight: item.isUnread ? FontWeight.bold : FontWeight.normal,
            color: AppColors.neutral.s900,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            item.subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.neutral.s700,
                ),
          ),
        ),
        trailing: Text(
          _formatTime(item.time),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.neutral.s500,
              ),
        ),
        onTap: () {
          if (item.isUnread) {
            ref
                .read(notificationsControllerProvider.notifier)
                .markAsRead(item.id);
          }
        },
      ),
    );
  }
}
