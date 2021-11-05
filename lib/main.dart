import 'package:flutter/material.dart';
import 'package:notikey/main_authorization.dart';

void main() => runApp(const NotiKey());

class NotiKey extends StatelessWidget {
  const NotiKey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NotiKey',
      home: MainAuthorization(),
    );
  }
}
