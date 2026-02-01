import '/config/theme.dart';
import '/pages/notifications/widgets/notification_tab_scroll_view.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NASH",
          style: TextStyle(
            color: context.colorScheme.secondary,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notifications",
                style: TextStyle(
                  color: context.colorScheme.onSurface,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Expanded(child: NotificationTabScrollView()),
            ],
          ),
        ),
      ),
    );
  }
}
