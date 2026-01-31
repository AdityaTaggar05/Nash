import 'package:flutter/material.dart';
import 'widgets/bet_placement_card.dart';
import 'widgets/bet_trends_card.dart';

class BetDetailsPage extends StatelessWidget {
  const BetDetailsPage({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BetPlacementCard(data: data),
            const SizedBox(height: 16),
            BetTrendsCard(data: data),
          ],
        ),
      ),
    );
  }
}
