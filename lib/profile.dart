// ignore_for_file: use_key_in_widget_constructors, no_logic_in_create_state

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notikey/Services/connect_controller.dart';
import 'package:notikey/UI/my_dialog_box.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';
import 'package:notikey/Entity/user.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  late User user;
  Profile(this.user, {Key? key});
  @override
  _ProfileState createState() => _ProfileState(user);
}

class _ProfileState extends State<Profile> {
  late User user;

  late Map updateUser = {
    'userId': user.userID,
    'name': user.name,
    'surname': user.surname,
    'email': user.email,
    'phone': user.phone,
    'birthday': user.birthday,
    'password': '12345678',
  };

  bool isActiveSaveBtn = false;
  final DialogBox dialogBox = DialogBox();

  _ProfileState(this.user) {
    fillUserFieldInfo();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();

  void fillUserFieldInfo() {
    nameController.text = updateUser['name'];
    surnameController.text = updateUser['surname'];
    emailController.text = updateUser['email'];
    phoneController.text = updateUser['phone'];
    birthdayController.text =
        updateUser['birthday'].split('-').reversed.join('-');
  }

  void checkChangeEventField() {
    int countChangedField = 0;
    if (nameController.text != user.name) {
      updateUser['name'] = nameController.text;
      countChangedField++;
    }
    if (surnameController.text != user.surname) {
      updateUser['surname'] = surnameController.text;
      countChangedField++;
    }
    if (emailController.text != user.email) {
      updateUser['email'] = emailController.text;
      countChangedField++;
    }
    if (phoneController.text != user.phone) {
      updateUser['phone'] = phoneController.text;
      countChangedField++;
    }
    if (birthdayController.text !=
        user.birthday.split('-').reversed.join('-')) {
      updateUser['birthday'] =
          birthdayController.text.split('-').reversed.join('-');
      countChangedField++;
    }
    if (countChangedField > 0) {
      changeSaveButtonStatus(true);
    } else {
      changeSaveButtonStatus(false);
    }
  }

  void changeSaveButtonStatus(status) {
    setState(() {
      isActiveSaveBtn = status;
    });
  }

  void outFromAccount() {
    Navigator.pop(context);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(15, 18, 63, 100),
      body: Stack(
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30, bottom: 20),
                child: Text(
                  'Профиль',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SwipeBottomBlock(
                Column(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(right: 20, left: 20, top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromRGBO(0, 0, 0, 100),
                                    width: 4),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Image(
                                image: AssetImage(
                                    "assets/images/userTestImage.png"),
                                height: 80,
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    user.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Text(
                                  user.surname,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          right: 20, left: 20, top: 20, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(12),
                                topLeft: Radius.circular(12),
                              ),
                            ),
                            child: TextField(
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(0),
                              ),
                              onChanged: (String value) {
                                checkChangeEventField();
                              },
                              controller: nameController,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextField(
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(0),
                              ),
                              onChanged: (String value) {
                                checkChangeEventField();
                              },
                              controller: surnameController,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                            ),
                            child: TextField(
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(0),
                              ),
                              onChanged: (String value) {
                                checkChangeEventField();
                              },
                              controller: emailController,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            width: double.infinity,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: TextField(
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(0),
                              ),
                              onChanged: (String value) {
                                checkChangeEventField();
                              },
                              controller: phoneController,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                            ),
                            child: TextField(
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(0),
                              ),
                              onChanged: (String value) {
                                checkChangeEventField();
                              },
                              controller: birthdayController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  isActiveSaveBtn
                                      ? Colors.blue[600]
                                      : Colors.grey[600]),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(140, 48)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              ConnectController connect = ConnectController();

                              Map response = await connect.startMethod(
                                  'http://localhost:8000/api/updateUserMobile',
                                  updateUser);

                              if (response.keys.isEmpty) {
                                changeSaveButtonStatus(false);
                              } else {
                                dialogBox.showCupertinoDialog(context,
                                    "Ошибка обновления", "Произошла ошибка");
                              }
                            },
                            child: const Text('Сохранить'),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red[400]),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(140, 48)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              showCupertinoDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: const Text("Выход из аккаунта"),
                                    content: const Text(
                                        "Вы уверен что хотите выйти?"),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: const Text("Да"),
                                        onPressed: () {
                                          outFromAccount();
                                        },
                                      ),
                                      CupertinoDialogAction(
                                        child: const Text("Нет"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text('Выйти'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                true,
                false,
                'Profile',
                user.userID,
              )
            ],
          )
        ],
      ),
    );
  }
}
