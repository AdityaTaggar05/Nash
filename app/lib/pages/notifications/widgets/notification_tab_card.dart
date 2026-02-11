import 'package:app/extensions/datetime.dart';
import 'package:app/models/notification.dart';
import 'package:flutter/material.dart' hide Notification;

import '/config/theme.dart';

class NotificationTabCard extends StatelessWidget {
  final Notification notification;

  const NotificationTabCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              notification.content,
              style: TextStyle(color: context.colorScheme.onSurface),
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                notification.createdAt.toReadableFormat(),
                style: TextStyle(
                  fontSize: 12,
                  color: context.colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
