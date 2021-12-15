import 'package:flutter/material.dart';
import 'package:notikey/Services/connect_controller.dart';
import 'package:notikey/UI/my_dialog_box.dart';
import 'package:notikey/discounts.dart';
import 'package:notikey/notes.dart';
import 'package:notikey/Entity/user.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';
import 'package:notikey/profile.dart';
import 'package:notikey/settings.dart';
import 'package:notikey/vehicle.dart';

// ignore: must_be_immutable
class MainMenu extends StatefulWidget {
  late User user;
  // ignore: use_key_in_widget_constructors
  MainMenu(this.user, {Key? key});
  @override
  // ignore: no_logic_in_create_state
  State<MainMenu> createState() => _MainMenu(user);
}

class _MainMenu extends State<MainMenu> {
  late User user;

  _MainMenu(this.user);
  final DialogBox dialogBox = DialogBox();
  bool isOutFromAccount = false;
  bool isUpdate = false;

  void updateUserData() async {
    ConnectController connect = ConnectController();

    List response = await connect.startGetMethod(
        'http://localhost:8000/api/getUserMobile/', {'userId': user.userID});

    if (response[0].keys.length != 0) {
      user.name = response[0]['name'];
      user.surname = response[0]['surname'];
      user.phone = response[0]['phone'];
      user.email = response[0]['email'];
      user.birthday = response[0]['birthday'];

      setState(() {
        isUpdate = !isUpdate;
      });
    } else {
      dialogBox.showCupertinoDialog(
          context, "Ошибка обновления", "Произошла ошибка");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(15, 18, 63, 100),
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              const Padding(
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
                              builder: (context) => Profile(user)))
                      .then((value) => {
                            if (value == true)
                              {Navigator.pop(context)}
                            else
                              {updateUserData()}
                          });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 20, left: 20, top: 30),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromRGBO(69, 153, 245, 100),
                        width: 3),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue[900],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Image(
                          image: AssetImage("assets/images/userTestImage.png"),
                          height: 80,
                        ),
                        Text(
                          "Здравствуйте, \n" + user.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.89,
                child: Container(
                  margin: const EdgeInsets.only(top: 25, bottom: 25),
                  height: 1,
                  width: 340,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              SwipeBottomBlock(
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, right: 5, bottom: 5),
                              // ignore: deprecated_member_use
                              child: GestureDetector(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: const Text(
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
                                          builder: (context) =>
                                              Notes(user.userID)));
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 30, left: 5, bottom: 5),
                              // ignore: deprecated_member_use
                              child: GestureDetector(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: const Text(
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
                                              const Vehicles()));
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
                              padding: const EdgeInsets.only(
                                  left: 30, right: 5, top: 5),
                              // ignore: deprecated_member_use
                              child: GestureDetector(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: const Text(
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
                                              Discounts(user.userID)));
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 30, left: 5, top: 5),
                              // ignore: deprecated_member_use
                              child: GestureDetector(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: const Text(
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
                                              const Settings()));
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  true,
                  false),
            ],
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
