import 'package:app/config/theme.dart';
import 'package:flutter/material.dart';

class BetResolve extends StatefulWidget {
  final String groupID;
  final String betID;
  const BetResolve({super.key, required this.betID, required this.groupID});

  @override
  State<BetResolve> createState() => _BetResolveState();
}

class _BetResolveState extends State<BetResolve> {
  @override
  Widget build(BuildContext context) {
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
            child: Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(25.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                children: [],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
