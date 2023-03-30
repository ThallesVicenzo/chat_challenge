import 'package:chat_challenge/routes/named_routes.dart';
import 'package:chat_challenge/screens/chat_screens/widgets/message_stream.dart';
import 'package:chat_challenge/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/shared_preferences.dart';
import '../../shared/constants.dart';

class SportsChatScreen extends StatefulWidget {
  const SportsChatScreen({super.key});

  @override
  State<SportsChatScreen> createState() => _SportsChatScreen();
}

class _SportsChatScreen extends State<SportsChatScreen> {
  final messageTextController = TextEditingController();
  String? messageText;
  String? nickname;
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    getNickname();
  }

  getNickname() async {
    nickname = await DataService.retrieveData('nickname');
    return nickname;
  }

  void addMessage() async {
    DateTime date =
        DateTime(now.year, now.month, now.day, now.hour, now.minute);

    final messagesRef = FirebaseService.getCollectionSnapshot('sports');

    QuerySnapshot<Map<String, dynamic>> documentSize = await messagesRef.get();
    int position = documentSize.size + 1;
    messagesRef.add(
      {
        'text': messageText,
        'nickname': nickname,
        'timestamp': date,
        'position': position,
      },
    );
    messageTextController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, NamedRoutes.home);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: Text(
            'Esportes⚽',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStream(
              nickname: nickname,
              collectionReference: 'sports',
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      style: Theme.of(context).textTheme.bodySmall,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (messageText != null) {
                          addMessage();
                        }
                      },
                      icon: Icon(
                        Icons.arrow_circle_right,
                        size: 35,
                        color: Theme.of(context).primaryColor,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
