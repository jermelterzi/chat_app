import 'package:chat/models/chat_message.dart';
import 'package:chat/services/auth/auth_service.dart';
import 'package:chat/services/chat/chat_service.dart';
import 'package:chat/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;
    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messagesStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/no_message.jpg',
                          ),
                          fit: BoxFit.fill)),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.25,
                    top: 16,
                  ),
                  child: const Text(
                    'Nenhuma conversa. Vamos conversar?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFFF4F5A),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          final msgs = snapshot.data!;
          return ListView.builder(
              reverse: true,
              itemCount: msgs.length,
              itemBuilder: (ctx, i) {
                return MessageBubble(
                    key: ValueKey(msgs[i].id),
                    message: msgs[i],
                    belongsToCurrentUser: currentUser?.id == msgs[i].userId);
              });
        }
      },
    );
  }
}
