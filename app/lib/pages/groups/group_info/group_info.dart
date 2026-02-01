import 'package:app/config/theme.dart';
import 'package:app/pages/groups/group_info/widgets/group_info_card.dart';
import 'package:app/pages/groups/group_info/widgets/group_members_list.dart';
import 'package:flutter/material.dart';

class GroupInfo extends StatelessWidget {
  final String groupID;

  const GroupInfo({super.key, required this.groupID});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> groupData = {
      'title' : "ChaCha chaudhary ke 4 chode",
      'description': "This is a group for betting on keshav lab nahayega BKL",
      'created_by': '1'
    };
    List<Map<String, dynamic>> memberData = [
      {
        'username': 'keshav bhadwa',
        'user_id': '1',
        'role': 'ADMIN'
      },
      {
        'username': 'taggar bhadwa',
        'user_id': '0',
        'role': 'member'
      },
      {
        'username': 'Shasak baby',
        'user_id': '2',
        'role': 'member'
      }
    ];
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(16.0),
          child: Column(
            children: [
              GroupInfoCard(data: groupData),
              SizedBox(height: 8.0),
              Expanded(child: GroupMembersList(currentUserId: "1", members: memberData)),
            ]
          )
        )
      )
    );
  }
}
