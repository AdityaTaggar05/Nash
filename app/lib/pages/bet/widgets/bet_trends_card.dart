import '/widgets/transactions_modal.dart';
import 'package:flutter/material.dart';

import '/config/theme.dart';
import '/widgets/transaction_tile.dart';

class BetTrendsCard extends StatelessWidget {
  const BetTrendsCard({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bet Trends",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              color: context.colorScheme.onSurfaceVariant,
              child: Container(
                height: 250,
                alignment: Alignment.center,
                child: Text(
                  "GRAPH GOES HERE",
                  style: TextStyle(
                    fontSize: 20,
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "Recent Bets",
              style: TextStyle(
                fontSize: 20,
                color: context.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            ...List.generate(data["transactions"].length.clamp(0, 5), (index) {
              final Map<String, dynamic> transaction =
                  data["transactions"][index];

              return TransactionTile(
                transaction: transaction,
                showBorder: index < 4,
              );
            }),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) => TransactionsModalSheet(
                    heading: "Recent Bets",
                    transactions: data["transactions"],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50.0),
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                backgroundColor: context.colorScheme.primary,
                foregroundColor: context.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text("See More >"),
            ),
          ],
        ),
      ),
    );
  }
}
