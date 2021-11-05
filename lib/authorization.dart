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
                image: AssetImage('assets/images/authorizationBg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 30, right: 30, top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LogoBlock(),
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            hintText: "Ваш логін",
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 40),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            hintText: "Ваш пароль",
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue[600]),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          minimumSize: MaterialStateProperty.all(
                              Size(double.infinity, 48)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Вход'),
                      ),
                    ],
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
