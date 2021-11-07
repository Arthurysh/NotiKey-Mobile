import 'package:flutter/material.dart';
import 'package:notikey/Services/connect_controller.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';
import 'package:notikey/Entity/user.dart';

class Profile extends StatefulWidget {
  late User user;
  Profile(User user) {
    this.user = user;
  }
  @override
  _ProfileState createState() => _ProfileState(this.user);
}

class _ProfileState extends State<Profile> {
  late User user;

  late Map updateUser = {
    'name': user.name,
    'surname': user.surname,
    'email': user.email,
    'phone': user.phone,
    'birthday': user.birthday,
    'password': '12345678',
  };

  bool isActiveSaveBtn = false;

  _ProfileState(User user) {
    this.user = user;
    this.fillUserFieldInfo();
  }

  TextEditingController nameController = new TextEditingController();
  TextEditingController surnameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController birthdayController = new TextEditingController();

  void fillUserFieldInfo() {
    this.nameController.text = updateUser['name'];
    this.surnameController.text = this.updateUser['surname'];
    this.emailController.text = this.updateUser['email'];
    this.phoneController.text = this.updateUser['phone'];
    this.birthdayController.text =
        this.updateUser['birthday'].split('-').reversed.join('-');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(15, 18, 63, 100),
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Padding(
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
                    Container(
                      child: Column(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(right: 20, left: 20, top: 10),
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
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color.fromRGBO(0, 0, 0, 100),
                                          width: 4),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/userTestImage.png"),
                                      height: 80,
                                    ),
                                  ),
                                  Container(
                                      child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          user.name,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Text(
                                        user.surname,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
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
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      topLeft: Radius.circular(12),
                                    ),
                                  ),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(0),
                                    ),
                                    onChanged: (String value) {
                                      this.checkChangeEventField();
                                    },
                                    controller: nameController,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(0),
                                    ),
                                    onChanged: (String value) {
                                      this.checkChangeEventField();
                                    },
                                    controller: surnameController,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                  ),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(0),
                                    ),
                                    onChanged: (String value) {
                                      this.checkChangeEventField();
                                    },
                                    controller: emailController,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  width: double.infinity,
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(0),
                                    ),
                                    onChanged: (String value) {
                                      this.checkChangeEventField();
                                    },
                                    controller: phoneController,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(12),
                                      bottomLeft: Radius.circular(12),
                                    ),
                                  ),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(0),
                                    ),
                                    onChanged: (String value) {
                                      this.checkChangeEventField();
                                    },
                                    controller: birthdayController,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 20, left: 20),
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
                                        Size(140, 48)),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    ConnectController connect =
                                        new ConnectController();
                                    print(updateUser);

                                    var response = await connect.startMethod(
                                        'http://localhost:8000/api/UpdateUser',
                                        updateUser);
                                  },
                                  child: const Text('Сохранить'),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.red[400]),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    minimumSize: MaterialStateProperty.all(
                                        Size(140, 48)),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text('Выйти'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    true,
                    false)
                // BottomNavigate(false, true),
              ],
            ),
          )
        ],
      ),
    );
  }
}
