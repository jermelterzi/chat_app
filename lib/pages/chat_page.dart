import 'package:chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Chat Page'),
            TextButton(
                onPressed: () => AuthService().logout(),
                child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
