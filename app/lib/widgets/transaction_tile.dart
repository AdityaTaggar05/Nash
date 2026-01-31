import 'package:flutter/material.dart';

import '/config/theme.dart';
import '/extensions/datetime.dart';
import '/extensions/number.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.transaction,
    this.showBorder = true,
  });

  final Map<String, dynamic> transaction;
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
        title: Text(transaction["user_id"] ?? transaction["bet_id"]),
        subtitle: (transaction["amount"] as num).nashFormat(),
        trailing: Text(
          ((transaction["placed_at"] ?? transaction["created_at"]) as DateTime)
              .toReadableFormat(),
        ),
      ),
    );
  }
}
