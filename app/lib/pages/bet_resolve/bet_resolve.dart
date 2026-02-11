import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/config/theme.dart';
import '/controllers/bet.dart';
import '/extensions/number.dart';
import '/models/bet.dart';
import '/providers/dio_provider.dart';

class BetResolve extends ConsumerWidget {
  final Bet bet;

  const BetResolve({super.key, required this.bet});

  Future<void> resolveBet(String option, WidgetRef ref) async {
    final dio = ref.read(dioProvider);
    try {
      await dio.post(
        "/group/${bet.groupID}/bet/${bet.id}/decide",
        data: {"option": option},
      );
    } on DioException {}
    ref
        .read(
          betControllerProvider(
            BetParams(groupID: bet.groupID, betID: bet.id),
          ).notifier,
        )
        .resolveBet(Status.resolved, option);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NASH",
          style: TextStyle(
            color: context.colorScheme.secondary,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      bet.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Current Pot :",
                      style: TextStyle(
                        color: context.colorScheme.onSurface,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
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
                    const SizedBox(height: 8),
                    Text(
                      "Select winning result :",
                      style: TextStyle(
                        color: context.colorScheme.onSurface,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              await resolveBet("for", ref);
                              context.pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(24),
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
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              await resolveBet("against", ref);
                              context.pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[600],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(24),
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
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
