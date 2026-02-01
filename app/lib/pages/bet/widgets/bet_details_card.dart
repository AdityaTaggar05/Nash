import 'package:app/pages/bet/widgets/bet_placement_section.dart';
import 'package:app/providers/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/theme.dart';
import '/extensions/number.dart';
import '/models/bet.dart';

class BetDetailsCard extends ConsumerStatefulWidget {
  final String groupID;
  final String betID;

  const BetDetailsCard({super.key, required this.groupID, required this.betID});

  @override
  ConsumerState<BetDetailsCard> createState() => _BetDetailsCardState();
}

class _BetDetailsCardState extends ConsumerState<BetDetailsCard> {
  Future<Bet> getBetDetails(WidgetRef ref) async {
    final dio = ref.read(dioProvider);
    final res = await dio.get("/group/${widget.groupID}/bet/${widget.betID}");

    return Bet.fromJSON(res.data);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: FutureBuilder(
          future: getBetDetails(ref),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (asyncSnapshot.hasError) {
              return Center(
                child: Text(
                  "Something went wrong",
                  style: TextStyle(
                    color: context.colorScheme.onSurface,
                    fontSize: 18,
                  ),
                ),
              );
            }

            final Bet bet = asyncSnapshot.data!;

            return DetailsSection(bet: bet);
          },
        ),
      ),
    );
  }
}

class DetailsSection extends StatefulWidget {
  const DetailsSection({super.key, required this.bet});

  final Bet bet;

  @override
  State<DetailsSection> createState() => _DetailsSectionState();
}

class _DetailsSectionState extends State<DetailsSection> {
  bool isBetPlaced = false;

  @override
  void initState() {
    super.initState();
    isBetPlaced = widget.bet.myBet != null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.bet.title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        widget.bet.totalPot.nashFormat(
          iconSize: 52,
          style: TextStyle(
            fontSize: 52,
            color: context.colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        isBetPlaced
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.bet.myBet!.expectedPayout.nashFormat(
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
                  widget.bet.myBet!.amount.nashFormat(
                    style: TextStyle(
                      fontSize: 18,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    leading: Text(
                      "BET PLACED: ",
                      style: TextStyle(
                        fontSize: 18,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              )
            : BetPlacementSection(
                bet: widget.bet,
                onBetConfirmed: () => setState(() {
                  isBetPlaced = true;
                }),
              ),
      ],
    );
  }
}
