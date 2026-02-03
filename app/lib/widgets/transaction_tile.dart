import 'package:flutter/material.dart';

import '/config/theme.dart';
import '/extensions/datetime.dart';
import '/extensions/number.dart';
import '/models/bet_transaction.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.transaction,
    this.showBorder = true,
  });

  final BetTransaction transaction;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        shape: showBorder
            ? Border(
                bottom: BorderSide(color: context.colorScheme.onSurfaceVariant),
              )
            : null,
        title: Text(transaction.username),
        subtitle: transaction.amount.nashFormat(
          iconColor: context.colorScheme.onSurfaceVariant,
          iconSize: 18,
        ),
        trailing: Text(transaction.placedAt.toReadableFormat()),
      ),
    );
  }
}
