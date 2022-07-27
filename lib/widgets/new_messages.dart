import 'package:chat/services/auth/auth_service.dart';
import 'package:chat/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({Key? key}) : super(key: key);

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  late String _message = '';
  final _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;

    if (user != null) {
      await ChatService().save(_message, user);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 8.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              onChanged: (msg) => setState(() => _message = msg),
              decoration: const InputDecoration(
                labelText: 'Enviar Mensagem...',
                filled: true,
                fillColor: Colors.white,
              ),
              onSubmitted: (_) {
                if (_message.trim().isNotEmpty) {
                  _sendMessage();
                }
              },
            ),
          ),
          IconButton(
            onPressed: _message.trim().isEmpty ? null : _sendMessage,
            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
