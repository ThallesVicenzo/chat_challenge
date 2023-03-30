import 'package:chat_challenge/services/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../services/firebase_service.dart';

class PopUpAlert extends StatefulWidget {
  const PopUpAlert({
    super.key,
    required this.routes,
  });

  final String routes;

  @override
  State<PopUpAlert> createState() => _PopUpAlertState();
}

class _PopUpAlertState extends State<PopUpAlert> {
  final _text = TextEditingController();
  String nickname = '';
  String? error;

  DocumentReference<Map<String, dynamic>> get getNicknameDoc =>
      FirebaseService.getDocumentSnapshot('nickname', nickname);

  Future<String?> _errorText() async {
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
    final queryNickname = getNicknameDoc;
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
          onPressed: () {
            _errorText().then((text) {
              setState(() {
                error = text;
              });

              if (text == null) {
                DataService.saveData(nickname);
                getNicknameDoc.set({
                  'nickname': nickname,
                });
                Navigator.pushNamed(context, widget.routes);
              } else {
                setState(() {});
              }
            });
          },
          child: const Text('Confirmar'),
        )
      ],
    );
  }
}
