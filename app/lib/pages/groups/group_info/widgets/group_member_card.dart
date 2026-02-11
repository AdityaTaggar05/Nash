import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/theme.dart';
import '/models/member.dart';

class GroupMemberCard extends StatelessWidget {
  final GroupMember member;
  final bool isCurrentUserAdmin;
  final VoidCallback? onKicked;

  const GroupMemberCard({
    super.key,
    required this.member,
    required this.isCurrentUserAdmin,
    this.onKicked,
  });

  @override
  Widget build(BuildContext context) {
    final bool showActions = isCurrentUserAdmin && member.role != Role.admin;

    return GestureDetector(
      onTap: () => context.push("/profile/${member.userID}"),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: context.colorScheme.surface,
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://cdn.dribbble.com/users/18924830/avatars/normal/25cecaeb59d31d07887ff220ea9ab686.png?1728297612",
                ),
                radius: 24,
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    member.username,
                    style: TextStyle(
                      color: context.colorScheme.onSurface,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    member.role.name,
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
      ),
    );
  }
}
