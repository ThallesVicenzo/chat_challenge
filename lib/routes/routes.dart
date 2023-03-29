import 'package:chat_challenge/screens/chat_screens/sports_chat_screen.dart';
import 'package:chat_challenge/screens/chat_screens/videogame_chat_screen.dart';
import 'package:flutter/material.dart';

import '../screens/chat_screens/business_chat_sceen.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/splash_screen.dart';
import 'named_routes.dart';

class Routes {
  static Map<String, WidgetBuilder> all(BuildContext context) {
    return {
      NamedRoutes.splash: (context) => const SplashScreen(),
      NamedRoutes.home: (context) => const HomeScreen(),
      NamedRoutes.business: (context) => const BusinessChatScreen(),
      NamedRoutes.videgame: (context) => const VideoGameChatScreen(),
      NamedRoutes.sports: (context) => const SportsChatScreen(),
    };
  }
}
