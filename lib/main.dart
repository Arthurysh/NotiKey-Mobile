// @dart=2.9
import 'package:flutter/material.dart';
import 'package:notikey/main_authorization.dart';

void main() => runApp(NotiKey());

class NotiKey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NotiKey',
      home: MainAuthorization(),
    );
  }
}
