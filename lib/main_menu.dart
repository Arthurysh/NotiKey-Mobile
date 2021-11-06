import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:notikey/discounts.dart';
import 'package:notikey/notes.dart';
import 'package:notikey/UI/my_bottom_menu.dart';
import 'package:notikey/Entity/user.dart';
import 'package:notikey/UI/my_bottom_navigate.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';
import 'package:notikey/profile.dart';
import 'package:notikey/vehicle.dart';

class MainMenu extends StatefulWidget {
  late User user;
  MainMenu(User user) {
    this.user = user;
  }
  @override
  State<MainMenu> createState() => _MainMenu(user);
}

class _MainMenu extends State<MainMenu> {
  late User user;

  _MainMenu(User user) {
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
                UserBlock(user),
                FractionallySizedBox(
                  widthFactor: 0.89,
                  child: Container(
                    margin: EdgeInsets.only(top: 25, bottom: 25),
                    height: 1,
                    width: 340,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ),
                SwipeBottomBlock(
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                                // ignore: deprecated_member_use
                                child: ElevatedButton(
                                  child: Text(
                                    "Записи",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    minimumSize: MaterialStateProperty.all(
                                        Size(140, 120)),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Notes()));
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                // ignore: deprecated_member_use
                                child: ElevatedButton(
                                  child: Text(
                                    "Транспорт",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    minimumSize: MaterialStateProperty.all(
                                        Size(140, 120)),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Vehicles()));
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                                // ignore: deprecated_member_use
                                child: ElevatedButton(
                                  child: Text(
                                    "Скидки",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    minimumSize: MaterialStateProperty.all(
                                        Size(140, 120)),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Discounts()));
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                // ignore: deprecated_member_use
                                child: ElevatedButton(
                                  child: Text(
                                    "Настройки",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    minimumSize: MaterialStateProperty.all(
                                        Size(140, 120)),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.black),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    true,
                    false),
              ],
            ),
          )
          // BottomMenu(),
        ],
      ),
    );
  }
}

class UserBlock extends StatelessWidget {
  late User user;

  UserBlock(User user) {
    this.user = user;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profile()));
      },
      child: Container(
        margin: EdgeInsets.only(right: 20, left: 20, top: 30),
        decoration: BoxDecoration(
          border:
              Border.all(color: Color.fromRGBO(69, 153, 245, 100), width: 3),
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue[900],
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image(
                image: AssetImage("assets/images/userTestImage.png"),
                height: 80,
              ),
              Container(
                child: Text(
                  "Здравствуйте, \n" + user.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DownMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 25),
            height: 4,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: GridView.count(
              crossAxisCount: 2,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    child: Text(
                      "Пристрої",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    child: Text(
                      "Підписка",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    child: Text(
                      "Профіль",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    child: Text(
                      "Сценарії",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          BottomNavigate(true, false),
        ],
      ),
    ));
  }
}
