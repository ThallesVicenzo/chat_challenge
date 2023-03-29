import 'package:chat_challenge/routes/named_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const ChatChallenge());
}

class ChatChallenge extends StatelessWidget {
  const ChatChallenge({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 50),
          bodyMedium: TextStyle(color: Colors.white, fontSize: 25),
          bodySmall: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
      initialRoute: NamedRoutes.splash,
      routes: Routes.all(context),
    );
  }
}
