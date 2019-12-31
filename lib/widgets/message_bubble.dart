import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String messageText;
  final String sender;
  final bool isMe;

  MessageBubble(
      {@required this.sender, @required this.messageText, @required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          // Text(
          //   sender,
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 12,
          //   ),
          // ),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.only(
              topLeft: isMe ? Radius.circular(50) : Radius.zero,
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
              topRight: isMe ? Radius.zero : Radius.circular(50),
            ),
            color: isMe ? Colors.lightBlue : Colors.green,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: Text(
                '$messageText',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
