import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BubbleMessage extends StatelessWidget {
  const BubbleMessage({
    Key? key,
    required this.text,
    required this.sender,
    required this.timeStamp,
    required this.isMe,
  }) : super(key: key);

  final String text;
  final String sender;
  final Timestamp timeStamp;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    String hours = timeStamp.toDate().hour.toString();
    String minutes = timeStamp.toDate().minute.toString();
    String day = timeStamp.toDate().day.toString();
    String month = timeStamp.toDate().month.toString();
    String year = timeStamp.toDate().year.toString();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(sender, style: Theme.of(context).textTheme.bodySmall),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: isMe
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        )
                      : const BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: isMe ? Colors.lightGreenAccent : Colors.white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        text,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '$day/$month/$year às ${hours}h:${minutes}min',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
