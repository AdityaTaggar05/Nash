import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/theme.dart';
import '/widgets/creation_button.dart';
import '/widgets/normal_text_field.dart';

class BetCreation extends StatefulWidget {
  final String groupID;
  const BetCreation({super.key, required this.groupID});

  @override
  State<BetCreation> createState() => _BetCreationState();
}

class _BetCreationState extends State<BetCreation> {
  final betTitleController = TextEditingController();
  DateTime? date;
  String bet_title = "";

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
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32.0),
                    CustomTextField(
                      hintText: "Bet Title",
                      controller: betTitleController,
                      maxLength: 32,
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Text(
                          "Choose the End Date: ",
                          style: TextStyle(
                            color: context.colorScheme.onSurfaceVariant,
                            fontSize: 18,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final DateTime minDate = DateTime.now().add(
                              const Duration(days: 1),
                            );

                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: date ?? minDate,
                              firstDate: minDate,
                              lastDate: minDate.add(const Duration(days: 180)),
                            );

                            if (picked != null) {
                              setState(() {
                                date = picked;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            child: Text(
                              date == null
                                  ? "Select Date"
                                  : "${date!.day}/${date!.month}/${date!.year}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    CreationButton(
                      onPressed: () {
                        setState(() {
                          bet_title = betTitleController.text;
                        });
                        print("Bet title = ${bet_title}");
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
