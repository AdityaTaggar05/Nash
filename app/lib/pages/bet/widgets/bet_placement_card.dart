import '/widgets/creation_button.dart';
import '/widgets/normal_text_field.dart';
import 'package:flutter/material.dart';

import '/config/theme.dart';
import '/extensions/number.dart';

class BetPlacementCard extends StatefulWidget {
  const BetPlacementCard({
    super.key,
    required this.data,
    required this.onBetConfirmed,
  });

  final Map<String, dynamic> data;
  final VoidCallback onBetConfirmed;

  @override
  State<BetPlacementCard> createState() => _BetPlacementCardState();
}

class _BetPlacementCardState extends State<BetPlacementCard> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.data['title'].toString(),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            (widget.data["total_pot"] as num).nashFormat(
              iconSize: 52,
              style: TextStyle(
                fontSize: 52,
                color: context.colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (!expanded)
              CreationButton(
                onPressed: () {
                  setState(() => expanded = true);
                  return null;
                },
                title: "Place Bet",
              )
            else
              Column(
                children: [
                  CustomTextField(hintText: "Bet Amount (e.g. 100)"),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            widget.onBetConfirmed();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              "For",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.onPrimary,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            widget.onBetConfirmed();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[600],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              "Against",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.onPrimary,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
