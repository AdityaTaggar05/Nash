import 'package:app/pages/home/widgets/group_card.dart';
import 'package:flutter/material.dart';

class GroupCardScrollView extends StatelessWidget {
  const GroupCardScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemCount: 3,
        itemBuilder: (context, index) {
          return const GroupCard(
            groupName: "Chacha Choudhary ke 4 Chode",
            memberNumber: 4,
          );
        },
      ),
    );
  }
}