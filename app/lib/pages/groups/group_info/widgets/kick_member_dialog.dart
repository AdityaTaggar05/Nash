import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/theme.dart';
import '/models/member.dart';

void showKickMemberDialog(BuildContext context, GroupMember member) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Kick ${member.username}?",
          style: TextStyle(color: context.colorScheme.onSurface, fontSize: 24),
        ),
        content: Text(
          "Are you sure you want to kick ${member.username}?",
          style: TextStyle(
            color: context.colorScheme.onSurfaceVariant,
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              "Cancel",
              style: TextStyle(
                color: context.colorScheme.onSurfaceVariant,
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              "Kick",
              style: TextStyle(color: context.colorScheme.error, fontSize: 16),
            ),
          ),
        ],
      );
    },
  );
}
