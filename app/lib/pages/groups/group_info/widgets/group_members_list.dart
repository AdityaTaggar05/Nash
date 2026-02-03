import 'package:flutter/material.dart';

import '/config/theme.dart';
import '/models/member.dart';
import '/pages/groups/group_info/widgets/group_member_card.dart';
import '/pages/groups/group_info/widgets/kick_member_dialog.dart';
import 'add_member_dialog.dart';

class GroupMembersList extends StatelessWidget {
  final List<GroupMember> members;
  final String userID;
  final String groupID;

  const GroupMembersList({
    super.key,
    required this.members,
    required this.userID,
    required this.groupID,
  });

  @override
  Widget build(BuildContext context) {
    final GroupMember admin = members.firstWhere(
      (member) => member.role == Role.admin,
      orElse: () => members[0],
    );

    final List<GroupMember> otherMembers = members
        .where((member) => member.role == Role.member)
        .toList();

    final bool isAdmin = (admin.userID == userID);

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
              child: GroupMemberCard(
                member: admin,
                isCurrentUserAdmin: isAdmin,
              ),
            );
          }
          if (index == 2) {
            return Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Members",
                    style: TextStyle(
                      color: context.colorScheme.onSurface,
                      fontSize: 18,
                    ),
                  ),
                  if (isAdmin)
                    IconButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AddMemberDialog(groupID: groupID),
                      ),
                      icon: Icon(Icons.add),
                    ),
                ],
              ),
            );
          }
          final member = otherMembers[index - 3];
          return Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 4),
            child: GroupMemberCard(
              member: member,
              isCurrentUserAdmin: isAdmin,
              onKicked: () => showKickMemberDialog(context, member),
            ),
          );
        },
      ),
    );
  }
}
