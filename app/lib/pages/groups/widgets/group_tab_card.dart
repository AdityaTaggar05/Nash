import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/config/theme.dart';

class GroupTabCard extends StatelessWidget {
  final String id;
  final String name;
  final String description;

  const GroupTabCard({
    super.key,
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: GestureDetector(
        onTap: () => context.push('/groups/$id/bets'),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundImage: AssetImage('assets/pfp.png'),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    description,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
