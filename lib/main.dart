import 'package:chat_challenge/routes/named_routes.dart';
import 'package:chat_challenge/shared/theme.dart';
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
      theme: AppTheme.lightTheme,
      initialRoute: NamedRoutes.splash,
      routes: Routes.all(context),
    );
  }
}
