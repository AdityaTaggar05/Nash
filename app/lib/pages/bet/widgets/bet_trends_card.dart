import 'package:app/models/bet.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/theme.dart';
import '/controllers/bet.dart';
import '/models/bet_transaction.dart';
import '/widgets/transaction_tile.dart';
import '/widgets/transactions_modal.dart';

class BetTrendsCard extends ConsumerWidget {
  final String betID;
  final String groupID;

  const BetTrendsCard({super.key, required this.betID, required this.groupID});

  List<LineChartBarData> getGraphData(BuildContext context, Bet bet) {
    List<FlSpot> forData = [FlSpot(0, 0)];
    List<FlSpot> againstData = [FlSpot(0, 0)];

    double count = 1;
    double poolFor = 0;
    double poolAgainst = 0;

    for (var transaction in bet.transactions) {
      if (transaction.option == "for") {
        poolFor += transaction.amount;
      } else {
        poolAgainst += transaction.amount;
      }

      againstData.add(FlSpot(count, poolAgainst));
      forData.add(FlSpot(count, poolFor));
      count++;
    }

    return [
      LineChartBarData(
        isCurved: true,
        preventCurveOverShooting: true,
        spots: forData,
        color: context.colorScheme.primary,
        shadow: Shadow(color: context.colorScheme.primary, blurRadius: 2),
        belowBarData: BarAreaData(
          show: true,
          color: context.colorScheme.primary.withAlpha(64),
        ),
      ),
      LineChartBarData(
        isCurved: true,
        preventCurveOverShooting: true,
        spots: againstData,
        color: context.colorScheme.error,
        barWidth: 2,
        shadow: Shadow(color: context.colorScheme.error, blurRadius: 2),
        belowBarData: BarAreaData(
          show: true,
          color: context.colorScheme.error.withAlpha(64),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      betControllerProvider(BetParams(groupID: groupID, betID: betID)),
    );

    return state.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text(
          "Something went wrong",
          style: TextStyle(
            color: context.colorScheme.onSurfaceVariant,
            fontSize: 18,
          ),
        ),
      ),
      data: (bet) => Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bet Trends",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: EdgeInsets.fromLTRB(4, 20, 20, 4),
                height: 250,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: context.colorScheme.onSurfaceVariant.withAlpha(128),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: LineChart(
                  LineChartData(
                    lineBarsData: getGraphData(context, bet),
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        bottom: BorderSide(
                          color: context.colorScheme.surface,
                          width: 2,
                        ),
                        left: BorderSide(
                          color: context.colorScheme.surface,
                          width: 2,
                        ),
                        right: BorderSide.none,
                        top: BorderSide.none,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 32,
                          interval: 1,
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      // leftTitles: AxisTitles(sideTitles: leftTitles()),
                    ),
                    lineTouchData: LineTouchData(
                      touchSpotThreshold: 20,
                      handleBuiltInTouches: true,
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipColor: (touchedSpot) =>
                            context.colorScheme.surface.withAlpha(128),
                      ),
                    ),
                    minX: 0,
                    maxX: bet.transactions.length * 1.0,
                    maxY: 300.0,
                    minY: 0,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                "Recent Bets",
                style: TextStyle(
                  fontSize: 20,
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              bet.transactions.isEmpty
                  ? Center(
                      child: Text(
                        "No user has placed any bet yet!",
                        style: TextStyle(
                          color: context.colorScheme.onSurfaceVariant,
                          fontSize: 18,
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        ...List.generate(bet.transactions.length.clamp(0, 5), (
                          index,
                        ) {
                          final BetTransaction transaction =
                              bet.transactions[index];

                          return TransactionTile(
                            transaction: transaction,
                            showBorder: index < 4,
                          );
                        }),
                        const SizedBox(height: 12),
                        if (bet.transactions.length > 5)
                          ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) =>
                                    TransactionsModalSheet(
                                      heading: "Recent Bets",
                                      transactions: bet.transactions,
                                    ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50.0),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              backgroundColor: context.colorScheme.primary,
                              foregroundColor: context.colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: Text("See More >"),
                          ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
