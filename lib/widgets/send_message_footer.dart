import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_storage/firebase_ui_storage.dart';
import 'package:firebase_widgets_demo/models/message.dart';
import 'package:flutter/material.dart';

class SendMessageFooter extends StatelessWidget {
  SendMessageFooter({
    super.key,
  });
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            controller: controller,
          )),
          IconButton(
              onPressed: () {
                final msg = Message(text: controller.text);
                controller.clear();
                FirebaseFirestore.instance.collection('chat').add(
                      msg.toJson(),
                    );
              },
              icon: Icon(Icons.send)),
          UploadButton(
              onError: (_, __) {},
              onUploadComplete: (ref) async {
                final down = await ref.getDownloadURL();
                final msg = Message(text: down);
                FirebaseFirestore.instance.collection('chat').add(
                      msg.toJson(),
                    );
              }),
        ],
      ),
    );
  }
}
