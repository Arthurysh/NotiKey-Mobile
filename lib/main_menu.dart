import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:notikey/Services/connect_controller.dart';
import 'package:notikey/UI/my_dialog_box.dart';
import 'package:notikey/discounts.dart';
import 'package:notikey/notes.dart';
import 'package:notikey/UI/my_bottom_menu.dart';
import 'package:notikey/Entity/user.dart';
import 'package:notikey/UI/my_bottom_navigate.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';
import 'package:notikey/profile.dart';
import 'package:notikey/settings.dart';
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
  final DialogBox dialogBox = new DialogBox();
  bool isOutFromAccount = false;

  void updateUserData() async {
    ConnectController connect = new ConnectController();

    Map response = await connect.startGetMethod(
        'http://localhost:8000/api/getUserMobile/', {'userId': user.userID});

    if (response.keys.length != 0) {
      user.name = response['name'];
      user.surname = response['surname'];
      user.phone = response['phone'];
      user.email = response['email'];
      user.birthday = response['birthday'];
    } else {
      dialogBox.showCupertinoDialog(
          context, "Ошибка обновления", "Произошла ошибка");
    }
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profile(this.user)))
                        .then((value) => {
                              if (value == true)
                                {Navigator.pop(context)}
                              else
                                {updateUserData()}
                            });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 20, left: 20, top: 30),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromRGBO(69, 153, 245, 100), width: 3),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue[900],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image(
                            image:
                                AssetImage("assets/images/userTestImage.png"),
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
                ),
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
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 30, right: 5, bottom: 5),
                                  // ignore: deprecated_member_use
                                  child: GestureDetector(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Записи",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      width: 140,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: 2,
                                            blurRadius: 6,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Notes()));
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: 30, left: 5, bottom: 5),
                                  // ignore: deprecated_member_use
                                  child: GestureDetector(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Транспорт",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      width: 140,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: 2,
                                            blurRadius: 6,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Vehicles()));
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 30, right: 5, top: 5),
                                  // ignore: deprecated_member_use
                                  child: GestureDetector(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Скидки",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      width: 140,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: 2,
                                            blurRadius: 6,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Discounts()));
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: 30, left: 5, top: 5),
                                  // ignore: deprecated_member_use
                                  child: GestureDetector(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Нстройки",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      width: 140,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.4),
                                            spreadRadius: 2,
                                            blurRadius: 6,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Settings()));
                                    },
                                  ),
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

// class UserBlock extends StatelessWidget {
//   late User user;

//   UserBlock(User user) {
//     this.user = user;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => Profile(this.user)))
//             .then((value) => {MainMenu.of(context).updateUserData()});
//       },
//       child: Container(
//         margin: EdgeInsets.only(right: 20, left: 20, top: 30),
//         decoration: BoxDecoration(
//           border:
//               Border.all(color: Color.fromRGBO(69, 153, 245, 100), width: 3),
//           borderRadius: BorderRadius.circular(15),
//           color: Colors.blue[900],
//         ),
//         child: Padding(
//           padding: EdgeInsets.only(top: 20, bottom: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Image(
//                 image: AssetImage("assets/images/userTestImage.png"),
//                 height: 80,
//               ),
//               Container(
//                 child: Text(
//                   "Здравствуйте, \n" + user.name,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 17,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
