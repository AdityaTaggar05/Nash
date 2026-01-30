import 'package:flutter/material.dart';

import '/config/theme.dart';
import '/extensions/number.dart';

class BetDetailsCard extends StatelessWidget {
  const BetDetailsCard({super.key, required this.data});

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
              "\$${(data["totalPot"] as num).formatWithCommas()}",
              style: TextStyle(
                fontSize: 52,
                color: context.colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "EXPECTED PAYOUT: \$120",
              style: TextStyle(
                fontSize: 18,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              "BET PLACED: \$100",
              style: TextStyle(
                fontSize: 18,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "Will Keshav bathe today?",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
