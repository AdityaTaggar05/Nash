import 'package:app/config/theme.dart';
import 'package:app/extensions/number.dart';
import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final String heroTag;

  const BalanceCard({super.key, required this.data, required this.heroTag});

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
            Hero(
              tag: heroTag,
              child:200.nashFormat(
                iconSize: 36,
                style: TextStyle(
                  fontSize: 36,
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),) 
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  "LAST MONTH:   ",
                  style: TextStyle(color: context.colorScheme.onSurfaceVariant),
                ),
                (data["last_month"] as num).nashFormat(
                  iconSize: 18,
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
