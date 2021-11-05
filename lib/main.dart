import 'package:flutter/material.dart';
import 'package:notikey/MainAuthorization.dart';

void main() => runApp(Notikey());

class Notikey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NotiKey',
      home: MainAuthorization(),
    );
  }
}
