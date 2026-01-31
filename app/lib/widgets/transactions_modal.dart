import 'package:app/config/theme.dart';
import 'package:app/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';

class TransactionsModalSheet extends StatelessWidget {
  final String heading;
  final List<Map<String, dynamic>> transactions;

  const TransactionsModalSheet({
    super.key,
    required this.transactions,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.25,
      maxChildSize: 0.95,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) =>
          Container(
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
                  heading,
                  style: TextStyle(
                    fontSize: 26,
                    color: context.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(height: 24),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: transactions.length,
                    itemBuilder: (BuildContext context, int index) =>
                        TransactionTile(
                          transaction: transactions[index],
                          showBorder: index != transactions.length - 1,
                        ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
