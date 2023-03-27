import 'dart:async';

import 'package:flutter/material.dart';

import '../../routes/named_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  double opacity = 1;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 2500), () {
      setState(() {
        opacity = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AnimatedOpacity(
        opacity: opacity,
        duration: kThemeAnimationDuration,
        onEnd: () {
          if (opacity == 0) {
            Navigator.pushNamed(context, NamedRoutes.home);
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.chat_bubble,
                size: 100,
                color: Colors.white,
              ),
              Text(
                'Chat Challenge',
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
