import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/config/theme.dart';
import '/controllers/bet.dart';
import '/controllers/user.dart';
import '/models/bet.dart';
import '/pages/bet/bet_discussion.dart';
import 'bet_details.dart';

class BetPage extends ConsumerStatefulWidget {
  final String groupID;
  final String betID;

  const BetPage({super.key, required this.betID, required this.groupID});

  @override
  ConsumerState<BetPage> createState() => _BetPageState();
}

class _BetPageState extends ConsumerState<BetPage> {
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
    final betState = ref.watch(
      betControllerProvider(
        BetParams(groupID: widget.groupID, betID: widget.betID),
      ),
    );

    return betState.when(
      error: (error, stackTrace) {
        print("LOG ERROR: $error");
        return Text("ERROR");
      },
      loading: () => ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 20, maxWidth: 20),
        child: CircularProgressIndicator(),
      ),
      data: (bet) => Scaffold(
        appBar: AppBar(
          title: Text(
            "NASH",
            style: TextStyle(
              color: context.colorScheme.secondary,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ),
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
                    BetDetailsPage(
                      groupID: widget.groupID,
                      betID: widget.betID,
                    ),
                    BetDiscussionPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton:
            page == 0 &&
                bet.createdBy == ref.read(userControllerProvider).value!.id &&
                bet.status != Status.resolved
            ? FloatingActionButton.extended(
                onPressed: () {
                  context.push(
                    '/groups/:group_id/bets/:bet_id/resolve',
                    extra: bet,
                  );
                },
                backgroundColor: context.colorScheme.secondary,
                label: Row(
                  children: [
                    Icon(
                      Icons.flaky_rounded,
                      color: context.colorScheme.onSecondary,
                      size: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('Resolve'),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}
