import 'package:app/controllers/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/theme.dart';
import '/controllers/bet.dart';
import '/models/bet.dart';
import '/providers/dio_provider.dart';
import '/widgets/creation_button.dart';
import '/widgets/normal_text_field.dart';
import '/widgets/snackbar.dart';

class BetPlacementSection extends ConsumerStatefulWidget {
  const BetPlacementSection({
    super.key,
    required this.bet,
    required this.onBetConfirmed,
  });

  final Bet bet;
  final VoidCallback onBetConfirmed;

  @override
  ConsumerState<BetPlacementSection> createState() => _BetPlacementCardState();
}

class _BetPlacementCardState extends ConsumerState<BetPlacementSection> {
  final TextEditingController priceController = TextEditingController();
  bool expanded = false;
  bool placing = false;

  Future<void> _placeBet(int amount, String option) async {
    try {
      await ref
          .read(dioProvider)
          .post(
            '/group/${widget.bet.groupID}/bet/${widget.bet.id}',
            data: {'amount': amount, 'option': option},
          );

      ref.read(userControllerProvider.notifier).updateBalance(-amount);

      ref.invalidate(
        betControllerProvider(
          BetParams(groupID: widget.bet.groupID, betID: widget.bet.id),
        ),
      );
    } on DioException catch (e) {
      if (mounted) {
        showSnackBar(context, e.response!.data["error"]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              CustomTextField(
                controller: priceController,
                hintText: "Bet Amount (e.g. 100)",
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: placing
                          ? null
                          : () async {
                              await _placeBet(
                                int.parse(priceController.text),
                                "for",
                              );
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
                      onPressed: placing
                          ? null
                          : () async {
                              await _placeBet(
                                int.parse(priceController.text),
                                "against",
                              );
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
    );
  }
}
