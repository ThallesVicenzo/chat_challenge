import 'package:chat_challenge/routes/named_routes.dart';
import 'package:chat_challenge/screens/home_screen/widgets/select_group_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text('Bem vindo!',
                style: Theme.of(context).textTheme.bodyMedium),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Por favor escolha algum grupo!',
                  style: Theme.of(context).textTheme.bodyMedium),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectGroupButton(
                    about: 'Negócios',
                    icon: Icons.business,
                    routes: NamedRoutes.business,
                  ),
                  SelectGroupButton(
                    about: 'Videogame',
                    icon: Icons.videogame_asset,
                    routes: NamedRoutes.videgame,
                  ),
                  SelectGroupButton(
                    about: 'Esportes',
                    icon: Icons.sports,
                    routes: NamedRoutes.sports,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
