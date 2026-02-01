import '/pages/notifications/widgets/notification_tab_card.dart';
import 'package:flutter/material.dart';

class NotificationTabScrollView extends StatelessWidget {
  const NotificationTabScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const NotificationTabCard(
              
            ),
          );
        },
      ),
    );
  }
}