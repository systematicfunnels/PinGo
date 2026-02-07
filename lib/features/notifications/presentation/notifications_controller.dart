import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pingo/features/notifications/domain/notification_entity.dart';

part 'notifications_controller.g.dart';

@riverpod
class NotificationsController extends _$NotificationsController {
  @override
  List<NotificationItem> build() {
    return [
      NotificationItem(
        id: '1',
        title: 'Route processed',
        subtitle: 'Your "Morning Run" is now ready for offline use.',
        time: DateTime.now().subtract(const Duration(minutes: 15)),
        isUnread: true,
        type: NotificationType.system,
        icon: Icons.check_circle_outline,
      ),
      NotificationItem(
        id: '2',
        title: 'New follower',
        subtitle: 'Alex is following your "Coffee Spots" map.',
        time: DateTime.now().subtract(const Duration(hours: 2)),
        isUnread: true,
        type: NotificationType.activity,
        icon: Icons.person_add_alt_1_outlined,
      ),
      NotificationItem(
        id: '3',
        title: 'Offline ready',
        subtitle: 'London Central map downloaded successfully.',
        time: DateTime.now().subtract(const Duration(hours: 5)),
        isUnread: false,
        type: NotificationType.system,
        icon: Icons.download_done,
      ),
      NotificationItem(
        id: '4',
        title: 'Pin saved',
        subtitle: 'Sarah saved your "Hidden Garden" pin.',
        time: DateTime.now().subtract(const Duration(days: 1)),
        isUnread: false,
        type: NotificationType.activity,
        icon: Icons.bookmark_border,
      ),
      NotificationItem(
        id: '5',
        title: 'Trust update',
        subtitle: 'You earned the "Reliable Guide" badge.',
        time: DateTime.now().subtract(const Duration(days: 2)),
        isUnread: false,
        type: NotificationType.system,
        icon: Icons.verified_user_outlined,
      ),
    ];
  }

  void markAsRead(String id) {
    state = [
      for (final item in state)
        if (item.id == id) item.copyWith(isUnread: false) else item
    ];
  }

  void markAllAsRead() {
    state = [
      for (final item in state) item.copyWith(isUnread: false)
    ];
  }

  void removeNotification(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void clearAll() {
    state = [];
  }
  
  // For dev testing
  void restoreMockData() {
    ref.invalidateSelf();
  }
}
