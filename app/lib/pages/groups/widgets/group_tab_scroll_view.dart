import 'package:app/pages/groups/widgets/group_tab_card.dart';
import 'package:flutter/material.dart';

class GroupTabScrollView extends StatelessWidget {
  const GroupTabScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: const GroupTabCard(
              groupName: "Random Ass Group",
              groupDescription: "This Group is made to bet on Keshav Ka Chudaap",
              memberNumber: 4,
            ),
          );
        },
      ),
    );
  }
}
