// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:notikey/Entity/user.dart';
import 'package:notikey/Services/connect_controller.dart';
import 'package:notikey/UI/logo_block.dart';
import 'package:notikey/UI/my_dialog_box.dart';
import 'package:notikey/main_menu.dart';

class Registration extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ConnectController connect = ConnectController();
  final DialogBox dialogBox = DialogBox();

  getRegisterUserObj(context) async {
    if (nameController.text.trim() != '' &&
        surnameController.text.trim() != '' &&
        phoneController.text.trim() != '' &&
        birthdayController.text != '' &&
        checkEmailField(emailController.text) &&
        passwordController.text.trim() != '' &&
        passwordController.text.length >= 8) {
      Map registerUserObj = {
        'name': nameController.text,
        'surname': surnameController.text,
        'phone': phoneController.text,
        'birthday': birthdayController.text.split(".").reversed.join("-"),
        'email': emailController.text,
        'password': passwordController.text,
        'password_confirmation': passwordController.text,
        'user_role': 'User',
      };

      var response = await connect.startMethod(
          "http://localhost:8000/api/Registration", registerUserObj);

      if (response["errors"]["email"][0] !=
          "The email has already been taken.") {
        Map userAuthObj = {
          'email': emailController.text,
          'password': passwordController.text,
        };

        response = await connect.startMethod(
            'http://localhost:8000/api/Login', userAuthObj);

        if (response.keys.isNotEmpty) {
          User user = User(
            response["userId"],
            response["user_role"],
            response["name"],
            response["surname"],
            response["phone"],
            response["email"],
            response["birthday"],
          );

          nameController.text = '';
          surnameController.text = '';
          phoneController.text = '';
          birthdayController.text = '';
          emailController.text = '';
          passwordController.text = '';
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MainMenu(user),
                  fullscreenDialog: true));
        }
      } else {
        dialogBox.showCupertinoDialog(
            context, "Ошибка Регистрации", "Такой почта уже занята");
      }
    } else {
      dialogBox.showCupertinoDialog(context, "Ошибка Регистрации",
          "Проверьте коректность введенных данных");
    }
  }

  bool checkEmailField(value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/registrationBg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 30, right: 30, top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const LogoBlock(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      hintText: "Имя",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    ),
                    controller: nameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      hintText: "Фамилия",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    ),
                    controller: surnameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      hintText: "Номер",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    ),
                    controller: phoneController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      hintText: "Почта",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    ),
                    controller: emailController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      hintText: "Дата рождения",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    ),
                    controller: birthdayController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      hintText: "Пароль",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    ),
                    controller: passwordController,
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blue[600]),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 48)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    getRegisterUserObj(context);
                  },
                  child: const Text('Регистрация'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
