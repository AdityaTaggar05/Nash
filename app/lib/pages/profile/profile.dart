import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/config/theme.dart';
import '/controllers/user.dart';
import '/models/user.dart';
import '/providers/dio_provider.dart';
import '../../widgets/rounded_icon_button.dart';
import 'widgets/balance_card.dart';
import 'widgets/header.dart';
import 'widgets/transaction_history.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final String userID;

  const ProfilePage({super.key, required this.userID});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage>
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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _measureColumnHeight() {
    if (columnHeight != 0) return;

    final renderBox =
        headerKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        columnHeight = renderBox.size.height;
        animation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
        );
      });

      Future.delayed(Duration(milliseconds: 300), () => _controller.forward());
    }
  }

  Future<User?> getUserData() async {
    if (ref.read(userControllerProvider).value!.id == widget.userID) {
      return ref.read(userControllerProvider).value!;
    }

    print("LOG: BEFORE HERE");
    final dio = ref.read(dioProvider);
    print("LOG: HERE");
    final response = await dio.get('/users/${widget.userID}');

    print("LOG: ${response.data}");

    return User.fromJson(response.data);
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
        child: FutureBuilder<User?>(
          future: getUserData(),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (asyncSnapshot.data == null) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RoundedIconButton(
                      icon: Icons.arrow_back_rounded,
                      onTap: context.pop,
                      color: context.colorScheme.surface,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "No user exists with the ID\n${widget.userID}",
                          style: TextStyle(
                            fontSize: 24,
                            color: context.colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            WidgetsBinding.instance.addPostFrameCallback((_) {
              _measureColumnHeight();
            });

            final User user = asyncSnapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    if (columnHeight > 0)
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (_, _) {
                          return Container(
                            height: animation.value * columnHeight,
                            decoration: BoxDecoration(
                              color: context.colorScheme.secondary,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                            ),
                          );
                        },
                      ),
                    ProfileHeader(user: user, headerKey: headerKey),
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
                        BalanceCard(user: user, lastMonth: 3840),
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
            );
          },
        ),
      ),
    );
  }
}
