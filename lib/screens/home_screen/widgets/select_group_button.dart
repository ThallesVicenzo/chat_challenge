import 'package:chat_challenge/routes/named_routes.dart';
import 'package:chat_challenge/screens/home_screen/widgets/pop_up_alert.dart';
import 'package:flutter/material.dart';

class SelectGroupButton extends StatelessWidget {
  const SelectGroupButton(
      {super.key,
      required this.icon,
      required this.routes,
      required this.about});

  final IconData icon;
  final String routes;
  final String about;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return PopUpAlert(
                routes: routes,
              );
            });
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              about,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
