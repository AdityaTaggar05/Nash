import '/config/theme.dart';
import 'package:flutter/material.dart';

class NotificationTabCard extends StatelessWidget {
  const NotificationTabCard({super.key});

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
              "Notification Title",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2.0),
            Text(
              "Notification description",
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}