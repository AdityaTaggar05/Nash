import 'package:flutter/material.dart';

import '/config/theme.dart';
import '/extensions/number.dart';
import '/models/user.dart';

class BalanceCard extends StatelessWidget {
  final User user;
  final int lastMonth;

  const BalanceCard({super.key, required this.user, required this.lastMonth});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Balance",
              style: TextStyle(
                fontSize: 16,
                color: context.colorScheme.onSurface,
              ),
            ),
            user.balance!.nashFormat(
              iconSize: 36,
              iconColor: context.colorScheme.primary,
              style: TextStyle(
                fontSize: 36,
                color: context.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  "LAST MONTH:   ",
                  style: TextStyle(color: context.colorScheme.onSurfaceVariant),
                ),
                681.nashFormat(
                  iconSize: 18,
                  iconColor: context.colorScheme.onSurface,
                  style: TextStyle(
                    fontSize: 18,
                    color: context.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
