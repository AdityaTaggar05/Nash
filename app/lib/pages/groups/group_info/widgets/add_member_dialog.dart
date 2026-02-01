import 'package:app/config/theme.dart';
import 'package:app/widgets/normal_text_field.dart';
import 'package:flutter/material.dart';

void showAddMemberDialog(BuildContext context) {
  final memberController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Add New Member',
          style: TextStyle(color: context.colorScheme.onSurface, fontSize: 22),
        ),
        content: CustomTextField(
          hintText: 'Username',
          controller: memberController,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(onPressed: () {}, child: const Text('Add')),
              ),
            ],
          ),
        ],
      );
    },
  );
}
