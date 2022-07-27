import 'dart:io';

import 'package:chat/models/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool belongsToCurrentUser;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.belongsToCurrentUser,
  }) : super(key: key);

  Widget _showUserImage(String imageUrl) {
    ImageProvider? provider;
    final uri = Uri.parse(imageUrl);

    if (uri.scheme.contains('http')) {
      provider = NetworkImage(uri.toString());
    } else if (uri.path.contains('assets/images/avatar.png')) {
      provider = const AssetImage('assets/images/avatar.png');
    } else {
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
      backgroundColor: Colors.pink,
      backgroundImage: provider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: belongsToCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                  color: belongsToCurrentUser
                      ? Colors.grey.shade300
                      : Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: belongsToCurrentUser
                        ? const Radius.circular(16)
                        : const Radius.circular(0),
                    bottomRight: belongsToCurrentUser
                        ? const Radius.circular(0)
                        : const Radius.circular(16),
                  ),
                ),
                width: MediaQuery.of(context).size.width * 0.45,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                margin: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                child: Column(
                  children: [
                    Text(
                      message.userName,
                      style: TextStyle(
                        color:
                            belongsToCurrentUser ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        message.text,
                        textAlign: belongsToCurrentUser
                            ? TextAlign.right
                            : TextAlign.left,
                        style: TextStyle(
                          color: belongsToCurrentUser
                              ? Colors.black
                              : Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Align(
            alignment:
                belongsToCurrentUser ? Alignment.topRight : Alignment.topLeft,
            child: _showUserImage(message.userImageUrl),
          ),
        ),
      ],
    );
  }
}
