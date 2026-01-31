import 'package:app/config/theme.dart';
import 'package:app/pages/group/widgets/group_tab_scroll_view.dart';
import 'package:flutter/material.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
        child: IntrinsicHeight(
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
