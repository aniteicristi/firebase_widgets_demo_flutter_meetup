import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:firebase_widgets_demo/models/message.dart';
import 'package:firebase_widgets_demo/widgets/message_widget.dart';
import 'package:firebase_widgets_demo/widgets/send_message_footer.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final query = FirebaseFirestore.instance
        .collection('chat')
        .orderBy('createdAt', descending: true)
        .withConverter<Message>(
          fromFirestore: (json, _) => Message.fromSnapshot(json),
          toFirestore: (obj, _) => obj.toJson(),
        );
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton.outlined(
            onPressed: () {
              Navigator.of(context).pushNamed('/profile');
            },
            icon: const Icon(Icons.account_box))
      ]),
      body: Column(
        children: [
          Expanded(
            child: FirestoreListView<Message>(
              reverse: true,
              query: query,
              itemBuilder: (context, item) => MessageWidget(item.data()),
            ),
          ),
          SendMessageFooter(),
        ],
      ),
    );
  }
}
