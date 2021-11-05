import 'package:flutter/material.dart';
import 'package:notikey/UI/my_bottom_menu.dart';
import 'package:notikey/Entity/user.dart';

class MainMenu extends StatelessWidget {
  late User user;

  MainMenu(User user) {
    this.user = user;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(15, 18, 63, 100),
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text(
                    'NotiKey',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromRGBO(69, 153, 245, 100)),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue[900],
                  ),
                  child: Row(
                    children: [
                      Container(
                        child: Text(user.name + ", " + user.surname),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
          // BottomMenu(),
        ],
      ),
    );
  }
}
