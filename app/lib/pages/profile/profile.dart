import 'dart:math';

import '/config/theme.dart';
import '/pages/profile/widgets/balance_card.dart';
import 'package:flutter/material.dart';

import 'widgets/header.dart';
import 'widgets/transaction_history.dart';

const String currentUser = "123";

class ProfilePage extends StatefulWidget {
  final String userID;
  final List<String> heroTags;

  const ProfilePage({super.key, required this.userID, required this.heroTags});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey headerKey = GlobalKey();
  late AnimationController _controller;
  late Animation<double> animation;

  double columnHeight = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureColumnHeight();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _measureColumnHeight() {
    final renderBox =
        headerKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        columnHeight = renderBox.size.height;

        animation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
        );

        Future.delayed(
          Duration(milliseconds: 300),
          () => _controller.forward(),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = {
      "id": "id1",
      "username": "Potata69",
      "email": "potata@example.com",
      "wallet_balance": 60342.50,
      "referral_code": "XiJ8l9",
      "last_month": 3840.9,
      "transactions": List.generate(
        20,
        (_) => <String, dynamic>{
          "amount": 1000,
          "bet_id": "some-random-id",
          "description": "Placed this much on that bet",
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                if (columnHeight > 0)
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (_, _) => Container(
                      height: animation.value * columnHeight,
                      decoration: BoxDecoration(
                        color: context.colorScheme.secondary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ProfileHeader(
                  data: data,
                  headerKey: headerKey,
                  heroTag: widget.heroTags[0],
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BalanceCard(data: data, heroTag: widget.heroTags[1]),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TransactionHistorySection(data: data),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
