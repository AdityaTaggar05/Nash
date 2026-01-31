import 'package:flutter/material.dart';
import 'widgets/bet_details_card.dart';
import 'widgets/bet_placement_card.dart';
import 'widgets/bet_trends_card.dart';

class BetDetailsPage extends StatefulWidget {
  const BetDetailsPage({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<BetDetailsPage> createState() => _BetDetailsPageState();
}

class _BetDetailsPageState extends State<BetDetailsPage> {
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showDetails)
              BetDetailsCard(data: widget.data)
            else
              BetPlacementCard(
                data: widget.data,
                onBetConfirmed: () {
                  setState(() {
                    _showDetails = true;
                  });
                },
              ),
            
            const SizedBox(height: 16),
            BetTrendsCard(data: widget.data),
          ],
        ),
      ),
    );
  }
}