import 'package:flutter/material.dart';
import 'package:notikey/UI/logo_block.dart';

class Authorization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/AuthorizationBg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LogoBlock(),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      hintText: "Ваш логін",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
