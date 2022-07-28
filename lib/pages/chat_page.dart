import 'package:chat/pages/notification_page.dart';
import 'package:chat/services/notification/chat_notification_service.dart';
import 'package:chat/widgets/messages.dart';
import 'package:chat/widgets/new_messages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        centerTitle: true,
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Row(
                    children: const [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black87,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Sair'),
                    ],
                  ),
                ),
              ],
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              onChanged: (value) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (ctx) => const NotificationPage()),
                    );
                  },
                  icon: const Icon(Icons.notifications),
                ),
                Provider.of<ChatNotificationService>(context).itemsCount > 0
                    ? Positioned(
                        top: 7,
                        right: 7,
                        child: CircleAvatar(
                          maxRadius: 8,
                          backgroundColor: Colors.red.shade700,
                          child: Text(
                            '${Provider.of<ChatNotificationService>(context).itemsCount}',
                            style: const TextStyle(fontSize: 8),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: const [
            Expanded(
              child: Messages(),
            ),
            NewMessages(),
          ],
        ),
      ),
    );
  }
}
