import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/theme.dart';
import '/models/user_transaction.dart';
import '/providers/dio_provider.dart';
import '/widgets/user_transaction_tile.dart';
import '/widgets/user_transactions_modal.dart';

class TransactionHistorySection extends ConsumerWidget {
  const TransactionHistorySection({super.key});

  Future<List<UserTransaction>?> getTransactionData(WidgetRef ref) async {
    final dio = ref.read(dioProvider);
    final response = await dio.get("/transaction/user");

    print("LOG: ${response.data}");

    return response.data["transactions"]?.map<UserTransaction>(
      (transaction) => UserTransaction.fromJSON(transaction),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Transaction History",
          style: TextStyle(
            fontSize: 20,
            color: context.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: getTransactionData(ref),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (asyncSnapshot.hasError) {
                  print("LOG ERROR: ${asyncSnapshot.error}");
                  return const Center(child: Text("Something went wrong"));
                }

                if (asyncSnapshot.data == null) {
                  return Center(
                    child: Text(
                      "No transactions made till now!",
                      style: TextStyle(
                        color: context.colorScheme.onSurface,
                        fontSize: 18,
                      ),
                    ),
                  );
                }

                final List<UserTransaction> transactions = asyncSnapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(transactions.length.clamp(0, 5), (index) {
                      final UserTransaction transaction = transactions[index];

                      return UserTransactionTile(
                        transaction: transaction,
                        showBorder: index < 4,
                      );
                    }),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) =>
                                UserTransactionsModalSheet(
                                  heading: "Transaction History",
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
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
