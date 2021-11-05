import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//Диалоговое окно
class DialogBox {
  void showCupertinoDialog(context, String titl, String cont) {
    showDialog(
      context: context,
      builder: (_) => new CupertinoAlertDialog(
        title: new Text(titl),
        content: new Text(cont),
        actions: <Widget>[
          TextButton(
            child: Text('Закрити'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
