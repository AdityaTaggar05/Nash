import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/controllers/bet.dart';
import 'widgets/bet_details_card.dart';
import 'widgets/bet_trends_card.dart';

class BetDetailsPage extends ConsumerWidget {
  const BetDetailsPage({super.key, required this.groupID, required this.betID});

  final String groupID;
  final String betID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      betControllerProvider(BetParams(groupID: groupID, betID: betID)),
    );

    return state.when(
      error: (error, stackTrace) => Text("ERROR"),
      loading: () => CircularProgressIndicator(),
      data: (bet) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BetDetailsCard(groupID: groupID, betID: betID),
              const SizedBox(height: 16),
              BetTrendsCard(groupID: groupID, betID: betID),
            ],
          ),
        ),
      ),
    );
  }
}
