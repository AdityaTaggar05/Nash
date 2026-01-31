import 'package:app/config/theme.dart';
import 'package:flutter/material.dart';

class GroupMemberCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isCurrentUserAdmin;
  final VoidCallback? onKicked;
  const GroupMemberCard({
    super.key,
    required this.data,
    required this.isCurrentUserAdmin,
    this.onKicked,
  });

  @override
  Widget build(BuildContext context) {
    final bool showActions = isCurrentUserAdmin && data['role'] != "ADMIN";

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: context.colorScheme.surface,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/user_pfp.png'),
              radius: 24,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data['username'],
                  style: TextStyle(
                    color: context.colorScheme.onSurface,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  data['role'] == 'ADMIN' ? "admin" : "member",
                  style: TextStyle(
                    color: context.colorScheme.onSurfaceVariant,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
            Spacer(),
            if (showActions)
              IconButton(
                onPressed: onKicked,
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: context.colorScheme.error,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
