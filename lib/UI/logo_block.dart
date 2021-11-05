import 'package:flutter/material.dart';

class LogoBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'NotiKey',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Image(
          image: AssetImage("assets/images/logoIcon.png"),
          height: 90,
        ),
      ],
    );
  }
}
