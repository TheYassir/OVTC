import 'package:flutter/material.dart';
import 'package:ovtc_app/models/detail_other_user.dart';
import 'package:ovtc_app/models/message_model.dart';

class MessageChatBubble extends StatelessWidget {
  final String authId;
  final DetailOtherUserModel user;
  final MessageModel message;
  const MessageChatBubble({
    super.key,
    required this.message,
    required this.user,
    required this.authId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: message.userId == authId
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (message.userId != authId)
            CircleAvatar(
              child: Text(user.lastName.substring(0, 2).toUpperCase()),
            ),
          const SizedBox(
            width: 2.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              color: message.userId == authId ? Colors.teal : Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message.content,
              style: const TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
