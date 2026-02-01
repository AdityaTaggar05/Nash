import 'package:app/config/theme.dart';
import 'package:app/pages/groups/group_info/widgets/group_member_card.dart';
import 'package:app/pages/groups/group_info/widgets/kick_member_dialog.dart';
import 'package:flutter/material.dart';

class GroupMembersList extends StatelessWidget {
  final List<Map<String, dynamic>> members;
  final String currentUserId;
  const GroupMembersList({
    super.key,
    required this.members,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> admin = members.firstWhere(
      (m) => m['role'] == 'ADMIN',
      orElse: () => members[0],
    );

    final List<Map<String, dynamic>> otherMembers = members
        .where((m) => m['role'] != "ADMIN")
        .toList();

    final bool amIAdmin = (admin['user_id'] == currentUserId);

    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 3 + otherMembers.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 8),
              child: Text(
                "Admin",
                style: TextStyle(
                  color: context.colorScheme.onSurface,
                  fontSize: 18,
                ),
              ),
            );
          }
          if (index == 1) {
            return Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 4),
              child: GroupMemberCard(data: admin, isCurrentUserAdmin: amIAdmin),
            );
          }
          if (index == 2) {
            return Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 4),
              child: Text(
                "Members",
                style: TextStyle(
                  color: context.colorScheme.onSurface,
                  fontSize: 18,
                ),
              ),
            );
          }
          final member = otherMembers[index - 3];
          return Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 4),
            child: GroupMemberCard(
              data: member,
              isCurrentUserAdmin: amIAdmin,
              onKicked: () {
                showAlertDialog(context, member);
              },
            ),
          );
        },
      ),
    );
  }
}
