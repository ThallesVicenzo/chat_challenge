import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'bubble_message.dart';

FirebaseFirestore messagesRef = FirebaseFirestore.instance;

class MessageStream extends StatefulWidget {
  const MessageStream(
      {super.key, required this.nickname, required this.collectionReference});

  final String? nickname;
  final String collectionReference;

  @override
  State<MessageStream> createState() => _MessageStreamState();
}

class _MessageStreamState extends State<MessageStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: messagesRef
            .collection(widget.collectionReference)
            .orderBy('position')
            .snapshots(),
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
          List<BubbleMessage> messageBubbles = [];

          final messages = snapshot.data?.docs.reversed;
          for (dynamic message in messages!) {
            var messageText = message.data()['text'];
            var messageSender = message.data()['nickname'];
            var messageTimeStamp = message.data()['timestamp'];

            final messageBubble = BubbleMessage(
              isMe: messageSender! == widget.nickname,
              text: messageText,
              sender: messageSender,
              timeStamp: messageTimeStamp,
            );

            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
                reverse: true,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
                children: messageBubbles),
          );
        });
  }
}
