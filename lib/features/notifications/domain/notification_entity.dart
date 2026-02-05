import 'package:flutter/material.dart';

enum NotificationType { activity, system }

class NotificationItem {
  final String id;
  final String title;
  final String subtitle;
  final DateTime time;
  final bool isUnread;
  final NotificationType type;
  final IconData icon;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isUnread,
    required this.type,
    required this.icon,
  });

  NotificationItem copyWith({
    String? id,
    String? title,
    String? subtitle,
    DateTime? time,
    bool? isUnread,
    NotificationType? type,
    IconData? icon,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      time: time ?? this.time,
      isUnread: isUnread ?? this.isUnread,
      type: type ?? this.type,
      icon: icon ?? this.icon,
    );
  }
}
