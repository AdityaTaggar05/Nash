import 'package:app/controllers/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/theme.dart';
import '/models/group.dart';
import '/pages/groups/group_info/widgets/group_info_card.dart';
import '/pages/groups/group_info/widgets/group_members_list.dart';
import '/providers/dio_provider.dart';

class GroupInfo extends ConsumerWidget {
  final String groupID;

  const GroupInfo({super.key, required this.groupID});

  Future<Group> getGroupInfo(WidgetRef ref) async {
    final dio = ref.read(dioProvider);
    final res = await dio.get("/group/$groupID");

    return Group.fromJSON(res.data);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          child: FutureBuilder(
            future: getGroupInfo(ref),
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

              final Group group = asyncSnapshot.data!;

              return Column(
                children: [
                  GroupInfoCard(group: group),
                  SizedBox(height: 8.0),
                  Expanded(
                    child: GroupMembersList(
                      userID: ref.read(userControllerProvider).value!.id,
                      groupID: groupID,
                      members: group.memberList,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
