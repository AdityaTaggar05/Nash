import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/theme.dart';
import '/controllers/bet.dart';
import '/controllers/user.dart';
import '/extensions/number.dart';
import '/models/bet.dart';
import '/pages/bet/widgets/bet_placement_section.dart';
import '/providers/dio_provider.dart';

class BetDetailsCard extends ConsumerWidget {
  final String groupID;
  final String betID;

  const BetDetailsCard({super.key, required this.groupID, required this.betID});

  Future<Bet> getBetDetails(WidgetRef ref) async {
    final dio = ref.read(dioProvider);
    final res = await dio.get("/group/$groupID/bet/$betID");

    return Bet.fromJSON(res.data);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      betControllerProvider(BetParams(groupID: groupID, betID: betID)),
    );

    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: state.when(
          data: (bet) => DetailsSection(
            bet: bet,
            userID: ref.read(userControllerProvider).value!.id,
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              "Something went wrong",
              style: TextStyle(
                color: context.colorScheme.onSurface,
                fontSize: 18,
              ),
            ),
          ),
          loading: () => Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class DetailsSection extends StatelessWidget {
  final Bet bet;
  final String userID;

  const DetailsSection({super.key, required this.bet, required this.userID});

  @override
  Widget build(BuildContext context) {
    final bool isBetPlaced = bet.myBet != null;
    final bool isCreator = bet.createdBy == userID;
    final bool isResolved = bet.status == Status.resolved;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bet.title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        bet.totalPot.nashFormat(
          iconSize: 52,
          iconColor: context.colorScheme.secondary,
          style: TextStyle(
            fontSize: 52,
            color: context.colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        if (!isCreator)
          isBetPlaced
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    bet.myBet!.expectedPayout.nashFormat(
                      iconColor: context.colorScheme.onSurfaceVariant,
                      style: TextStyle(
                        fontSize: 18,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      leading: Text(
                        "EXPECTED PAYOUT: ",
                        style: TextStyle(
                          fontSize: 18,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    bet.myBet!.amount.nashFormat(
                      iconColor: context.colorScheme.onSurfaceVariant,
                      style: TextStyle(
                        fontSize: 18,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      leading: Text(
                        "BET PLACED ON ${bet.myBet!.option.toUpperCase()}: ",
                        style: TextStyle(
                          fontSize: 18,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                )
              : BetPlacementSection(bet: bet, onBetConfirmed: () {}),
        if (isCreator) ...[
          Text(
            "YOU CREATED THIS BET",
            style: TextStyle(color: context.colorScheme.onSurfaceVariant),
          ),
          if (isResolved)
            Row(
              children: [
                Text(
                  "THE WINNING OPTION: ",
                  style: TextStyle(color: context.colorScheme.onSurfaceVariant),
                ),
                const SizedBox(width: 12),
                Chip(
                  labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                  label: Text(
                    bet.winningOption!.toUpperCase(),
                    style: TextStyle(
                      color: bet.winningOption! == "for"
                          ? context.colorScheme.onPrimary
                          : context.colorScheme.onError,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  backgroundColor: bet.winningOption! == "for"
                      ? context.colorScheme.primary
                      : context.colorScheme.error,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ],
            ),
        ],
      ],
    );
  }
}
