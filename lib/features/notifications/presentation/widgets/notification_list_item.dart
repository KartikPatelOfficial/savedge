import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:savedge/features/notifications/domain/entities/notification_entity.dart';

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
    final isRead = notification.isRead;
    final accent = _accentFor(notification.type);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Dismissible(
        key: Key('notification_${notification.id}'),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => onDismiss?.call(),
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 24),
          decoration: BoxDecoration(
            color: const Color(0xFFEF4444).withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.delete_outline_rounded,
            color: Color(0xFFEF4444),
            size: 24,
          ),
        ),
        child: Material(
          color: isRead ? Colors.white : const Color(0xFFFCFBFF),
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isRead
                      ? const Color(0xFFF0F0F0)
                      : const Color(0xFF6F3FCC).withValues(alpha: 0.10),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Type icon
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(
                      _iconFor(notification.type),
                      color: accent,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title row + unread dot
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                notification.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight:
                                      isRead ? FontWeight.w600 : FontWeight.w800,
                                  color: const Color(0xFF1A202C),
                                ),
                              ),
                            ),
                            if (!isRead) ...[
                              const SizedBox(width: 8),
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF6F3FCC),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        // Body
                        Text(
                          notification.body,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF1A202C).withValues(alpha: 0.5),
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Time
                        Text(
                          _formatTime(notification.sentAt),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFB0B7C3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _accentFor(NotificationType type) {
    switch (type) {
      case NotificationType.welcome:
        return const Color(0xFF10B981);
      case NotificationType.reEngagement:
        return const Color(0xFF3B82F6);
      case NotificationType.newDeal:
        return const Color(0xFFF59E0B);
      case NotificationType.expiringCoupon:
        return const Color(0xFFEF4444);
      case NotificationType.abandonedCoupon:
        return const Color(0xFF6F3FCC);
      case NotificationType.birthday:
        return const Color(0xFFEC407A);
      case NotificationType.anniversary:
        return const Color(0xFFEF4444);
      case NotificationType.milestoneReward:
        return const Color(0xFFF59E0B);
      case NotificationType.weeklyDigest:
        return const Color(0xFF00BCD4);
      case NotificationType.pointsExpiring:
        return const Color(0xFFFF6B6B);
      case NotificationType.custom:
        return const Color(0xFF6F3FCC);
    }
  }

  IconData _iconFor(NotificationType type) {
    switch (type) {
      case NotificationType.welcome:
        return Icons.celebration_rounded;
      case NotificationType.reEngagement:
        return Icons.waving_hand_rounded;
      case NotificationType.newDeal:
        return Icons.local_offer_rounded;
      case NotificationType.expiringCoupon:
        return Icons.schedule_rounded;
      case NotificationType.abandonedCoupon:
        return Icons.bookmark_rounded;
      case NotificationType.birthday:
        return Icons.cake_rounded;
      case NotificationType.anniversary:
        return Icons.favorite_rounded;
      case NotificationType.milestoneReward:
        return Icons.emoji_events_rounded;
      case NotificationType.weeklyDigest:
        return Icons.summarize_rounded;
      case NotificationType.pointsExpiring:
        return Icons.stars_rounded;
      case NotificationType.custom:
        return Icons.notifications_rounded;
    }
  }

  String _formatTime(DateTime dateTime) {
    final utcDateTime = dateTime.isUtc
        ? dateTime
        : DateTime.utc(
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
