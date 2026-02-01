import 'package:app/providers/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/theme.dart';
import '/models/bet_transaction.dart';
import '/widgets/transaction_tile.dart';
import '/widgets/transactions_modal.dart';

class BetTrendsCard extends ConsumerWidget {
  final String betID;

  const BetTrendsCard({super.key, required this.betID});

  Future<List<BetTransaction>> getBetTransactions(WidgetRef ref) async {
    final dio = ref.read(dioProvider);
    final res = await dio.get("/transaction/bet/$betID");

    return res.data["transactions"]
        .map<BetTransaction>(
          (transaction) => BetTransaction.fromJSON(transaction),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            FutureBuilder(
              future: getBetTransactions(ref),
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

                if (asyncSnapshot.data == null ||
                    (asyncSnapshot.data?.isEmpty ?? false)) {
                  return Center(
                    child: Text(
                      "No bets have been placed yet!",
                      style: TextStyle(
                        color: context.colorScheme.onSurface,
                        fontSize: 18,
                      ),
                    ),
                  );
                }

                final List<BetTransaction> transactions = asyncSnapshot.data!;

                return Column(
                  children: [
                    ...List.generate(transactions.length.clamp(0, 5), (index) {
                      final BetTransaction transaction = transactions[index];

                      return TransactionTile(
                        transaction: transaction,
                        showBorder: index < 4,
                      );
                    }),
                    const SizedBox(height: 12),
                    if (transactions.length > 5)
                      ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) =>
                                TransactionsModalSheet(
                                  heading: "Recent Bets",
                                  transactions: transactions,
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
