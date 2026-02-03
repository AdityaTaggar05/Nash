import 'package:app/providers/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/config/theme.dart';
import '/widgets/normal_text_field.dart';

class AddMemberDialog extends ConsumerStatefulWidget {
  final String groupID;

  const AddMemberDialog({super.key, required this.groupID});

  @override
  ConsumerState<AddMemberDialog> createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends ConsumerState<AddMemberDialog> {
  final memberController = TextEditingController();
  bool status = false;

  @override
  Widget build(BuildContext context) {
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
              child: TextButton(
                onPressed: status
                    ? null
                    : () async {
                        if (memberController.text.trim() == "") return;

                        setState(() => status = true);
                        final dio = ref.read(dioProvider);
                        final res = await dio.post(
                          "/group/${widget.groupID}/members",
                          data: {'username': memberController.text.trim()},
                        );

                        if (res.statusCode == 404) {
                          setState(() => status = false);
                        } else {
                          context.pop();
                        }
                      },
                child: const Text('Add'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
