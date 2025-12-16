import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:savedge/features/notifications/domain/entities/notification_entity.dart';

/// Widget to display a single notification item
class NotificationListItem extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;

  const NotificationListItem({
    super.key,
    required this.notification,
    this.onTap,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRead = notification.isRead;

    return Dismissible(
      key: Key('notification_${notification.id}'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss?.call(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isRead
                ? theme.scaffoldBackgroundColor
                : theme.colorScheme.primary.withOpacity(0.05),
            border: Border(
              bottom: BorderSide(
                color: theme.dividerColor.withOpacity(0.1),
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Notification icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getIconBackgroundColor(notification.type),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getIcon(notification.type),
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (!isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.body,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodySmall?.color,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _formatTime(notification.sentAt),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIcon(NotificationType type) {
    switch (type) {
      case NotificationType.welcome:
        return Icons.celebration;
      case NotificationType.reEngagement:
        return Icons.waving_hand;
      case NotificationType.newDeal:
        return Icons.local_offer;
      case NotificationType.expiringCoupon:
        return Icons.access_time;
      case NotificationType.abandonedCoupon:
        return Icons.bookmark;
      case NotificationType.birthday:
        return Icons.cake;
      case NotificationType.anniversary:
        return Icons.favorite;
      case NotificationType.milestoneReward:
        return Icons.emoji_events;
      case NotificationType.weeklyDigest:
        return Icons.summarize;
      case NotificationType.pointsExpiring:
        return Icons.stars;
      case NotificationType.custom:
        return Icons.notifications;
    }
  }

  Color _getIconBackgroundColor(NotificationType type) {
    switch (type) {
      case NotificationType.welcome:
        return Colors.green;
      case NotificationType.reEngagement:
        return Colors.blue;
      case NotificationType.newDeal:
        return Colors.orange;
      case NotificationType.expiringCoupon:
        return Colors.red;
      case NotificationType.abandonedCoupon:
        return Colors.purple;
      case NotificationType.birthday:
        return Colors.pink;
      case NotificationType.anniversary:
        return Colors.red;
      case NotificationType.milestoneReward:
        return Colors.amber;
      case NotificationType.weeklyDigest:
        return Colors.teal;
      case NotificationType.pointsExpiring:
        return Colors.deepOrange;
      case NotificationType.custom:
        return Colors.blueGrey;
    }
  }

  String _formatTime(DateTime dateTime) {
    // API returns UTC time without 'Z' suffix, so we need to treat it as UTC
    // and convert to local time for display
    final utcDateTime = dateTime.isUtc ? dateTime : DateTime.utc(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
      dateTime.millisecond,
      dateTime.microsecond,
    );
    final localDateTime = utcDateTime.toLocal();
    final now = DateTime.now();
    final difference = now.difference(localDateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM d, y').format(localDateTime);
    }
  }
}
