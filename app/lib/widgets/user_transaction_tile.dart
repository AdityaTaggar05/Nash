import 'package:flutter/material.dart';

import '/config/theme.dart';
import '/extensions/number.dart';
import '/models/user_transaction.dart';

class UserTransactionTile extends StatelessWidget {
  const UserTransactionTile({
    super.key,
    required this.transaction,
    this.showBorder = true,
  });

  final UserTransaction transaction;
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
        title: Text(transaction.description, style: TextStyle(fontSize: 12)),
        trailing: transaction.amount.nashFormat(
          style: TextStyle(
            color: transaction.amount < 0
                ? context.colorScheme.error
                : context.colorScheme.primary,
          ),
        ),
        // trailing: Text(transaction.placedAt.toReadableFormat()),
      ),
    );
  }
}
