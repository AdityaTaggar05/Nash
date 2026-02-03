import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/theme.dart';
import '/models/group.dart';
import '/providers/dio_provider.dart';
import 'group_card.dart';

class GroupCardScrollView extends ConsumerWidget {
  const GroupCardScrollView({super.key});

  Future<List<Group>> getUserGroups(WidgetRef ref) async {
    final dio = ref.read(dioProvider);
    final res = await dio.get("/users/groups");

    return res.data.map<Group>((group) => Group.fromJSON(group)).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: getUserGroups(ref),
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

        if (asyncSnapshot.data == null || asyncSnapshot.data!.isEmpty) {
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

        return SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemCount: data.length,
            itemBuilder: (context, index) => GroupCard(
              id: data[index].id,
              name: data[index].name,
              description: data[index].description,
            ),
          ),
        );
      },
    );
  }
}
