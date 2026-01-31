import 'package:app/config/theme.dart';
import 'package:app/pages/group_bets/widgets/group_bet_details.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroupBets extends StatelessWidget {
  final String groupID;
  const GroupBets({super.key, required this.groupID});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = [
      {
        'total_pot': 300,
        'my_bet': {'amount': 100, 'expected_payout': 200},
        'title': "Keshav Ki iss sem Dassi?",
      },
      {
        'total_pot': 400,
        'my_bet': {'amount': 50, 'expected_payout': 150},
        'title': "Shrey ka khel khatam is sem?",
      },
      {
        'total_pot': 320,
        'my_bet': {'amount': 60, 'expected_payout': 200},
        'title': "Garv bhai try again on Maheek?",
      },
    ];

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
                context.push('/groups/:group_id');
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
              padding: const EdgeInsets.fromLTRB(8,0,0,0),
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
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: data.length,
                itemBuilder: (context, index) =>
                    GroupBetDetailsCard(data: data[index]),
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
