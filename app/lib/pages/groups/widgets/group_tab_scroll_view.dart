import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/theme.dart';
import '/models/group.dart';
import '/providers/dio_provider.dart';
import 'group_tab_card.dart';

class GroupTabScrollView extends ConsumerStatefulWidget {
  const GroupTabScrollView({super.key});

  @override
  ConsumerState<GroupTabScrollView> createState() => _GroupTabScrollViewState();
}

class _GroupTabScrollViewState extends ConsumerState<GroupTabScrollView> {
  Future<List<Group>> getUserGroups() async {
    final dio = ref.read(dioProvider);
    final res = await dio.get("/users/groups");

    return res.data.map<Group>((group) => Group.fromJSON(group)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserGroups(),
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

        if (asyncSnapshot.data == null) {
          return Center(
            child: Text(
              "You are not yet a part of any group!",
              style: TextStyle(
                color: context.colorScheme.onSurface,
                fontSize: 18,
              ),
            ),
          );
        }

        final List<Group> data = asyncSnapshot.data!;

        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GroupTabCard(
                id: data[index].id,
                name: data[index].name,
                description: data[index].description,
              ),
            );
          },
        );
      },
    );
  }
}
