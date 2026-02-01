import '/config/theme.dart';
import '/widgets/normal_text_field.dart';
import 'package:flutter/material.dart';

import 'widgets/message_card.dart';

class BetDiscussionPage extends StatelessWidget {
  const BetDiscussionPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> messages = [
      {
        "sender_id": "id1",
        "content": "My name is User 1",
        "created_at": DateTime.now(),
      },
      {
        "sender_id": "id1",
        "content": "Hello There",
        "created_at": DateTime.now().subtract(Duration(seconds: 20)),
      },
      {
        "sender_id": "id2",
        "content": "Hello There mate",
        "created_at": DateTime.now().subtract(Duration(minutes: 2)),
      },
      {
        "sender_id": "id1",
        "content": "So excited to be here",
        "created_at": DateTime.now().subtract(Duration(minutes: 5)),
      },
      {
        "sender_id": "id2",
        "content": "Lets welcome him",
        "created_at": DateTime.now().subtract(Duration(minutes: 7)),
      },
      {
        "sender_id": "id2",
        "content": "We have another member amongst us",
        "created_at": DateTime.now().subtract(Duration(minutes: 8)),
      },
      {
        "sender_id": "id2",
        "content": "We have another member amongst us",
        "created_at": DateTime.now().subtract(Duration(minutes: 8)),
      },
      {
        "sender_id": "id2",
        "content":
            "We have another member amongst us. And some pretty long text which I don't know why even it is there but it still is smaller than Lorem Ipsum",
        "created_at": DateTime.now().subtract(Duration(minutes: 8)),
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageCard(
                  message: messages[index],
                  displayUsername:
                      index == messages.length - 1 ||
                      messages[index]["sender_id"] !=
                          messages[index + 1]["sender_id"],
                  displayTime:
                      index == 0 ||
                      messages[index - 1]["sender_id"] !=
                          messages[index]["sender_id"],
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: CustomTextField(hintText: "Send a message...")),
              const SizedBox(width: 8),
              IconButton(
                padding: EdgeInsets.all(10),
                icon: Icon(Icons.send),
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: context.colorScheme.surface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
