import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_widgets_demo/models/message.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(this.message, {super.key});

  final Message message;

  @override
  Widget build(BuildContext context) {
    final me = FirebaseAuth.instance.currentUser!.uid;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: message.senderId == me
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(message.name),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            padding: const EdgeInsets.all(4),
            child: message.text.startsWith('https://')
                ? SizedBox(width: 500, child: Image.network(message.text))
                : Text(message.text),
          )
        ],
      ),
    );
  }
}
