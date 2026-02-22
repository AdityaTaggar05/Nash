import 'package:app/controllers/bet.dart';
import 'package:app/controllers/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/theme.dart';
import '/widgets/normal_text_field.dart';
import 'widgets/message_card.dart';

class BetDiscussionPage extends ConsumerWidget {
  const BetDiscussionPage({
    super.key,
    required this.groupID,
    required this.betID,
  });

  final String groupID;
  final String betID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      chatControllerProvider(BetParams(groupID: groupID, betID: betID)),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          Expanded(
            child: state.when(
              data: (messages) => ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return MessageCard(
                    message: messages[index],
                    displayUsername:
                        index == messages.length - 1 ||
                        messages[index].senderID !=
                            messages[index + 1].senderID,
                    displayTime:
                        index == 0 ||
                        messages[index - 1].senderID !=
                            messages[index].senderID,
                  );
                },
              ),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
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
