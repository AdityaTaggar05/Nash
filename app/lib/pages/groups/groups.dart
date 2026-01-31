import 'package:app/config/theme.dart';
import 'package:app/pages/groups/widgets/group_tab_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/group_creation');
        },
        backgroundColor: context.colorScheme.secondary,
        child: Icon(Icons.add, color: context.colorScheme.onSecondary),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Groups",
                style: TextStyle(
                  color: context.colorScheme.onSurface,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24.0),
              Expanded(child: GroupTabScrollView()),
            ],
          ),
        ),
      ),
    );
  }
}
