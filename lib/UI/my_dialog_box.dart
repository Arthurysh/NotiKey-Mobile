import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//Диалоговое окно
class DialogBox {
  void showCupertinoDialog(context, String titl, String cont) {
    showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(titl),
        content: Text(cont),
        actions: <Widget>[
          TextButton(
            child: const Text('Закрити'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
