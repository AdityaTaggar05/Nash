import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/theme.dart';
import '/extensions/datetime.dart';
import '/extensions/number.dart';
import '/models/bet.dart';

class GroupBetDetailsCard extends StatelessWidget {
  final Bet bet;
  const GroupBetDetailsCard({super.key, required this.bet});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push("/bet/${bet.groupID}/${bet.id}"),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bet.totalPot.nashFormat(
                iconSize: 30,
                iconColor: context.colorScheme.secondary,
                style: TextStyle(
                  fontSize: 30,
                  color: context.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    "${bet.expiresAt.isBefore(DateTime.now()) ? 'ENDED AT' : 'ENDS AT'}: ${bet.expiresAt.toReadableFormat()}",
                    style: TextStyle(
                      fontSize: 14,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                bet.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
