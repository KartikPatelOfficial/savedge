import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/features/notifications/presentation/bloc/notification_bloc.dart';

/// Badge widget showing unread notification count
class NotificationBadge extends StatelessWidget {
  final Widget child;
  final Color badgeColor;
  final Color textColor;
  final double badgeSize;

  const NotificationBadge({
    super.key,
    required this.child,
    this.badgeColor = Colors.red,
    this.textColor = Colors.white,
    this.badgeSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        final count = state.unreadCount;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            child,
            if (count > 0)
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  constraints: BoxConstraints(
                    minWidth: badgeSize,
                    minHeight: badgeSize,
                  ),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(badgeSize / 2),
                    border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      count > 99 ? '99+' : count.toString(),
                      style: TextStyle(
                        color: textColor,
                        fontSize: count > 99 ? 8 : 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// Icon button with notification badge
class NotificationIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? iconColor;
  final double iconSize;

  const NotificationIconButton({
    super.key,
    required this.onPressed,
    this.iconColor,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: NotificationBadge(
        child: Icon(
          Icons.notifications_outlined,
          color: iconColor ?? Theme.of(context).iconTheme.color,
          size: iconSize,
        ),
      ),
    );
  }
}
