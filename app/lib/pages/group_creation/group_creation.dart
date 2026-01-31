import 'package:app/config/theme.dart';
import 'package:app/widgets/creation_button.dart';
import 'package:app/widgets/normal_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroupCreation extends StatefulWidget {
  const GroupCreation({super.key});

  @override
  State<GroupCreation> createState() => _GroupCreationState();
}

class _GroupCreationState extends State<GroupCreation> {
  final groupNameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    groupNameController.dispose();
    descriptionController.dispose();
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsetsGeometry.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 8.0),
                    Text(
                      "Become Social!",
                      style: TextStyle(
                        color: context.colorScheme.onSurface,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32.0),
                    CustomTextField(
                      hintText: "Group Name",
                      controller: groupNameController,
                    ),
                    SizedBox(height: 16.0),
                    CustomTextField(
                      hintText: "Description",
                      minLines: 4,
                      maxLines: 8,
                      keyboardType: TextInputType.multiline,
                      controller: descriptionController,
                    ),
                    SizedBox(height: 32.0),
                    CreationButton(
                      onPressed: () {
                        context.go('/groups');
                        return null;
                      },
                      title: "Create Group",
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
