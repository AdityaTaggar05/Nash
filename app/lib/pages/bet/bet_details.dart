import 'package:flutter/material.dart';

import 'widgets/bet_details_card.dart';
import 'widgets/bet_trends_card.dart';

class BetDetailsPage extends StatefulWidget {
  const BetDetailsPage({super.key, required this.groupID, required this.betID});

  final String groupID;
  final String betID;

  @override
  State<BetDetailsPage> createState() => _BetDetailsPageState();
}

class _BetDetailsPageState extends State<BetDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BetDetailsCard(groupID: widget.groupID, betID: widget.betID),
            const SizedBox(height: 16),
            BetTrendsCard(betID: widget.betID),
          ],
        ),
      ),
    );
  }
}
