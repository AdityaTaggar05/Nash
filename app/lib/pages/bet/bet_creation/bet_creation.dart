import '/config/theme.dart';
import '/widgets/creation_button.dart';
import '/widgets/normal_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BetCreation extends StatefulWidget {
  final String groupID;
  const BetCreation({super.key, required this.groupID});

  @override
  State<BetCreation> createState() => _BetCreationState();
}

class _BetCreationState extends State<BetCreation> {
  final betTitleController = TextEditingController();

  @override
  void dispose() {
    betTitleController.dispose();
    super.dispose();
  }

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
            child: Padding(
              padding: const EdgeInsetsGeometry.all(16.0),
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
                    Text(
                      "Get Set Bet!",
                      style: TextStyle(
                        color: context.colorScheme.onSurface,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32.0),
                    CustomTextField(
                      hintText: "Bet Title",
                      controller: betTitleController,
                      maxLength: 32,
                    ),
                    SizedBox(height: 24.0),
                    CreationButton(
                      onPressed: () {
                        context.pop();
                        return null;
                      },
                      title: "Create Bet",
                    ),
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
