import 'package:flutter/material.dart';

import '/config/theme.dart';
import '/extensions/datetime.dart';
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
        title: Text(transaction.description),
        subtitle: transaction.amount.nashFormat(),
        trailing: Text(transaction.placedAt.toReadableFormat()),
      ),
    );
  }
}
