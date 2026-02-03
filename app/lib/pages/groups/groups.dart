import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/theme.dart';
import '/pages/groups/widgets/group_tab_scroll_view.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/group_creation', extra: () => setState(() {}));
        },
        backgroundColor: context.colorScheme.secondary,
        child: Icon(Icons.add, color: context.colorScheme.onSecondary),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
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
              SizedBox(height: 16),
              Expanded(child: GroupTabScrollView()),
            ],
          ),
        ),
      ),
    );
  }
}
