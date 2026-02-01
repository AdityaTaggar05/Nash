import '/config/theme.dart';
import '/widgets/creation_button.dart';
import '/widgets/normal_text_field.dart';
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
                      maxLength: 32,
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
