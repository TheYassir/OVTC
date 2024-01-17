import 'package:flutter/material.dart';
import 'package:ovtc_app/models/detail_other_user.dart';
import 'package:ovtc_app/models/message_model.dart';
import 'package:ovtc_app/utils/triangle_painter_message.dart';
import 'dart:math' as math;

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
        padding: message.userId == authId
            ? const EdgeInsets.only(right: 20.0, left: 50, top: 5, bottom: 5)
            : const EdgeInsets.only(right: 50.0, left: 18.0, top: 5, bottom: 5),
        child: Row(
          children: [
            Flexible(
                child: Row(
              mainAxisAlignment: message.userId == authId
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (message.userId != authId)
                  Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: CustomPaint(
                          painter: TrianglePointerMessage(Colors.grey))),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color:
                          message.userId == authId ? Colors.teal : Colors.grey,
                      borderRadius: message.userId == authId
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(18),
                              bottomLeft: Radius.circular(18),
                              bottomRight: Radius.circular(18),
                            )
                          : const BorderRadius.only(
                              topRight: Radius.circular(18),
                              bottomLeft: Radius.circular(18),
                              bottomRight: Radius.circular(18),
                            ),
                    ),
                    child: Text(
                      message.content,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Monstserrat',
                          fontSize: 16),
                    ),
                  ),
                ),
                if (message.userId == authId)
                  CustomPaint(painter: TrianglePointerMessage(Colors.teal)),
                // Search best way for add date and time at messageBubble
                // Row(
                //   children: [
                //     Text(
                //       message.createdAt.toDateFormat(),
                //       style: const TextStyle(
                //           color: Color.fromARGB(255, 0, 0, 0), fontSize: 16.0),
                //     ),
                //     Text(
                //       message.createdAt.toHoursFormat(),
                //       style: const TextStyle(
                //           color: Color.fromARGB(255, 0, 0, 0), fontSize: 16.0),
                //     ),
                //   ],
                // )
              ],
            )),
          ],
        ));
  }
}
