import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notikey/UI/logo_block.dart';
import 'package:notikey/authorization.dart';
import 'package:notikey/registration.dart';

class MainAuthorization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/startFormScreenBg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LogoBlock(),
                AuthButtonBlock(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AuthButtonBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.black),
                minimumSize: MaterialStateProperty.all(Size(250, 48)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Authorization()));
              },
              child: const Text('Вход'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                minimumSize: MaterialStateProperty.all(Size(250, 48)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Registration()));
              },
              child: const Text('Регистрация'),
            ),
          ),
        ],
      ),
    );
  }
}
