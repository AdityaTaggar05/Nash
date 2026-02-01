import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/config/theme.dart';
import '/models/bet.dart';
import '/pages/groups/group_bets/widgets/group_bet_details.dart';
import '/providers/dio_provider.dart';

class GroupBets extends ConsumerWidget {
  final String groupID;
  const GroupBets({super.key, required this.groupID});

  Future<List<Bet>> getGroupBets(WidgetRef ref) async {
    final dio = ref.read(dioProvider);
    final res = await dio.get("/group/$groupID/bet");

    return res.data.map<Bet>((bet) => Bet.fromJSON(bet)).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NASH",
          style: TextStyle(
            color: context.colorScheme.secondary,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                context.push('/groups/$groupID');
              },
              icon: Icon(Icons.info_outline_rounded),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Text(
                "Group's Ongoing Bets",
                style: TextStyle(
                  color: context.colorScheme.onSurface,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: FutureBuilder(
                future: getGroupBets(ref),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState ==
                      ConnectionState.waiting) {
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
                        "No bets created in this group!",
                        style: TextStyle(
                          color: context.colorScheme.onSurface,
                          fontSize: 18,
                        ),
                      ),
                    );
                  }

                  final List<Bet> data = asyncSnapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: data.length,
                    itemBuilder: (context, index) =>
                        GroupBetDetailsCard(bet: data[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/groups/:group_id/bet_creation');
        },
        backgroundColor: context.colorScheme.secondary,
        child: Icon(Icons.add, color: context.colorScheme.onSecondary),
      ),
    );
  }
}
