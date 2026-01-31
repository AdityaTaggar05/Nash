import 'package:app/config/theme.dart';
import 'package:app/pages/bet/widgets/bet_tile.dart';
import 'package:flutter/material.dart';

class RecentBetsModalSheet extends StatelessWidget {
  final ScrollController controller;
  final List<Map<String, dynamic>> transactions;

  const RecentBetsModalSheet({
    super.key,
    required this.controller,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Bets",
            style: TextStyle(
              fontSize: 26,
              color: context.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(height: 24),
          Expanded(
            child: ListView.builder(
              controller: controller,
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) => RecentBetTile(
                transaction: transactions[index],
                showBorder: index != transactions.length - 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
