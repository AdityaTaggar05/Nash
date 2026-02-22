import 'package:app/controllers/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/theme.dart';
import '/extensions/datetime.dart';
import '/models/message.dart';

class MessageCard extends ConsumerWidget {
  final Message message;
  final bool displayTime;
  final bool displayUsername;

  const MessageCard({
    super.key,
    required this.message,
    this.displayTime = false,
    this.displayUsername = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool ownMessage =
        ref.read(userControllerProvider).value!.id == message.senderID;

    return Align(
      alignment: ownMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: ownMessage
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (displayUsername)
            Text(
              message.username,
              style: TextStyle(color: context.colorScheme.onSurfaceVariant),
            ),
          Card(
            color: ownMessage
                ? context.colorScheme.primary
                : context.colorScheme.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(ownMessage ? 0 : 20),
                topLeft: Radius.circular(ownMessage ? 20 : 0),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              padding: EdgeInsets.all(16),
              child: Text(
                message.content,
                style: TextStyle(color: context.colorScheme.onPrimary),
              ),
            ),
          ),
          if (displayTime)
            Text(
              message.createdAt.toReadableFormat(),
              style: TextStyle(color: context.colorScheme.onSurfaceVariant),
            ),
        ],
      ),
    );
  }
}
