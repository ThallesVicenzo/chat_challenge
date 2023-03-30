import 'package:chat_challenge/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'bubble_message.dart';

FirebaseFirestore messagesRef = FirebaseFirestore.instance;

class MessageStream extends StatelessWidget {
  const MessageStream(
      {super.key, required this.nickname, required this.collectionReference});

  final String? nickname;
  final String collectionReference;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseService.getCollectionStream(collectionReference,
            orderBy: 'position'),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text(
              'Error: ${snapshot.error}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black),
            );
          }
          if (!snapshot.hasData) {
            return Text(
              'Esse grupo ainda não possui nenhuma conversa',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black),
            );
          }

          final messages = snapshot.data!.docs.reversed.toList();

          return Expanded(
            child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
                itemBuilder: (context, index) {
                  final data = messages[index].data()! as Map;
                  final messageSender = data['nickname'];
                  return BubbleMessage(
                      text: data['text'],
                      sender: messageSender,
                      timeStamp: data['timestamp'],
                      isMe: messageSender! == nickname);
                }),
          );
        });
  }
}
