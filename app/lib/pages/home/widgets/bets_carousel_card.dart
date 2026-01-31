import 'package:app/config/theme.dart';
import 'package:app/extensions/number.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BetsCarouselCard extends StatelessWidget {
  final int totalPot;
  final int placedBet;
  final String title;
  final Color color;
  final DateTime endsAt;

  const BetsCarouselCard({
    super.key,
    required this.totalPot,
    required this.placedBet,
    required this.title,
    required this.endsAt,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  totalPot.formatWithCommas(),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onPrimary,
                    letterSpacing: 1.2
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "PLACED BET: $placedBet",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  "ENDS AT ${DateFormat('MMM d, yyyy').format(endsAt)}",
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
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
