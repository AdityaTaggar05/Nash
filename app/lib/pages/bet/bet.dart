import 'dart:math';

import 'package:app/config/theme.dart';
import 'package:app/pages/bet/bet_discussion.dart';
import 'package:flutter/material.dart';

import 'bet_details.dart';

class BetPage extends StatefulWidget {
  final String betID;

  const BetPage({super.key, required this.betID});

  @override
  State<BetPage> createState() => _BetPageState();
}

class _BetPageState extends State<BetPage> {
  late final PageController controller;
  int page = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = {
      "total_pot": 6587.79,
      "my_bet": {"amount": 100, "expected_payout": 120},
      "title": "Will Keshav bathe today?",
      "transactions": List.generate(
        20,
        (_) => <String, dynamic>{
          "user_id": "some-random-id",
          "amount": 1000,
          "placed_at": DateTime.now().subtract(
            Duration(
              days: Random().nextInt(10),
              minutes: Random().nextInt(10),
              hours: Random().nextInt(10),
              seconds: Random().nextInt(10),
            ),
          ),
        },
      ),
    };

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() {
                      page = 0;
                      controller.animateToPage(
                        page,
                        duration: Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                      );
                    }),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: page == 0
                            ? Border(
                                bottom: BorderSide(
                                  color: context.colorScheme.secondary,
                                  width: 4,
                                ),
                              )
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          "Details",
                          style: TextStyle(
                            color: context.colorScheme.onSurface,
                            fontSize: 18,
                            fontWeight: page == 0 ? FontWeight.bold : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() {
                      page = 1;
                      controller.animateToPage(
                        page,
                        duration: Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                      );
                    }),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: page == 1
                            ? Border(
                                bottom: BorderSide(
                                  color: context.colorScheme.secondary,
                                  width: 4,
                                ),
                              )
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          "Discussion",
                          style: TextStyle(
                            color: context.colorScheme.onSurface,
                            fontSize: 18,
                            fontWeight: page == 1 ? FontWeight.bold : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value) => setState(() => page = value),
                children: [
                  BetDetailsPage(data: data),
                  BetDiscussionPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
