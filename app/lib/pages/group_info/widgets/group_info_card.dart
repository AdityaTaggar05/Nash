import 'package:app/config/theme.dart';
import 'package:flutter/material.dart';

class GroupInfoCard extends StatelessWidget {
  const GroupInfoCard({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: context.colorScheme.surface,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/pfp.png'),
                radius: 80,
              ),
              SizedBox(height: 16.0),
              Text(
                data['title'].toString(),
                style: TextStyle(
                  color: context.colorScheme.onSurface,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                data['description'].toString(),
                style: TextStyle(
                  color: context.colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
