import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Message {
  String? id;
  String name;
  String text;
  DateTime? createdAt;
  String? senderId;

  Message({
    required this.text,
    this.id,
    name,
    this.senderId,
    this.createdAt,
  }) : name = name ?? FirebaseAuth.instance.currentUser!.displayName;

  factory Message.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snap) =>
      Message(
        id: snap.id,
        name: snap["name"],
        text: snap["text"],
        createdAt: (snap['createdAt'] as Timestamp?)?.toDate(),
        senderId: snap['senderId'],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'name': name,
        'text': text,
        'createdAt': createdAt ?? FieldValue.serverTimestamp(),
        'senderId': senderId ?? FirebaseAuth.instance.currentUser!.uid,
      };
}
