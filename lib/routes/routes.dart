import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/chat_sceen.dart';
import '../screens/splash_screen.dart';
import 'named_routes.dart';

class Routes {
  static Map<String, WidgetBuilder> all(BuildContext context) {
    return {
      NamedRoutes.splash: (context) => const SplashScreen(),
      NamedRoutes.home: (context) => const HomeScreen(),
      NamedRoutes.chat: (context) => const ChatScreen(),
    };
  }
}
