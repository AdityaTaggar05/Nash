import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '/config/theme.dart';
import '/extensions/number.dart';
import '/models/bet.dart';

class BetsCarouselCard extends StatelessWidget {
  final Bet bet;
  final Color color;

  const BetsCarouselCard({super.key, required this.bet, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push("/bet/${bet.groupID}/${bet.id}"),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bet.totalPot.nashFormat(
                    iconSize: 36,
                    iconColor: context.colorScheme.onPrimary,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onPrimary,
                      letterSpacing: 1.2,
                    ),
                  ),
                  if (bet.myBet != null) ...[
                    const SizedBox(height: 4),
                    bet.myBet!.amount.nashFormat(
                      iconColor: Colors.black54,
                      iconSize: 12,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                      leading: Text(
                        "PLACED BET: ",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bet.title,
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
                    "ENDS AT ${DateFormat('MMM d, yyyy').format(bet.expiresAt)}",
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
      ),
    );
  }
}
