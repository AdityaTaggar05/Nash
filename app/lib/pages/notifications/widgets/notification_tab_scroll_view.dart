import 'package:app/config/theme.dart';
import 'package:app/models/notification.dart';
import 'package:app/providers/dio_provider.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/pages/notifications/widgets/notification_tab_card.dart';

class NotificationTabScrollView extends ConsumerWidget {
  const NotificationTabScrollView({super.key});

  Future<List<Notification>> getNotifications(WidgetRef ref) async {
    final dio = ref.read(dioProvider);
    final res = await dio.get("/notification/user");

    return res.data['notifications']
        .map<Notification>(
          (notification) => Notification.fromJSON(notification),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: getNotifications(ref),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (asyncSnapshot.hasError) {
          return Center(
            child: Text(
              "Something went wrong",
              style: TextStyle(
                color: context.colorScheme.onSurface,
                fontSize: 18,
              ),
            ),
          );
        }

        if (!asyncSnapshot.hasData || (asyncSnapshot.data ?? []).isEmpty) {
          return Center(
            child: Text(
              "You have no notifications yet!",
              style: TextStyle(
                color: context.colorScheme.onSurface,
                fontSize: 18,
              ),
            ),
          );
        }

        final List<Notification> data = asyncSnapshot.data!;

        return SizedBox(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: data.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: NotificationTabCard(notification: data[index]),
            ),
          ),
        );
      },
    );
  }
}
