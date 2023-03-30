import 'package:chat_challenge/services/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PopUpAlert extends StatefulWidget {
  const PopUpAlert({
    super.key,
    required this.routes,
  });

  final String routes;

  @override
  State<PopUpAlert> createState() => _PopUpAlertState();
}

final CollectionReference<Map<String, dynamic>> users =
    FirebaseFirestore.instance.collection('users');

class _PopUpAlertState extends State<PopUpAlert> {
  final _text = TextEditingController();
  String nickname = '';
  dynamic error;

  _errorText() async {
    final text = _text.value.text;
    if (text.isEmpty) {
      return 'Não pode ser vazio!';
    }
    if (text.length <= 2) {
      return 'Não pode ter menos que 3 caracteres.';
    }
    if (text.length > 10) {
      return 'Não pode ter mais que 10 caracteres.';
    }
    final queryNickname = users.doc(nickname);
    final result = await queryNickname.get();
    if (result.exists) {
      return 'Apelido já existe!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        'Por favor, digite seu nickname.',
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.black),
      ),
      content: TextField(
        controller: _text,
        onChanged: (value) {
          setState(() {
            nickname = value;
          });
        },
        decoration: InputDecoration(
            hintText: 'Escreva seu nickname aqui.', errorText: error),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            String? text = await _errorText();
            setState(() {
              error = text;
            });

            if (text == null) {
              DataService().saveData(nickname);
              users.doc(nickname).set({
                'nickname': nickname,
              });
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, widget.routes);
            } else {
              setState(() {});
            }
          },
          child: const Text('Confirmar'),
        )
      ],
    );
  }
}
