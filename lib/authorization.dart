// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:notikey/Services/connect_controller.dart';
import 'package:notikey/UI/logo_block.dart';
import 'package:notikey/UI/my_dialog_box.dart';
import 'package:notikey/main_menu.dart';
import 'package:notikey/Entity/user.dart';

class Authorization extends StatelessWidget {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final DialogBox dialogBox = DialogBox();

  getAuthUserObj(context) async {
    if (loginController.text.trim() != '' &&
        passwordController.text.trim() != '' &&
        passwordController.text.length >= 8) {
      if (checkEmailField(loginController.text)) {
        Map userAuthObj = {
          'email': loginController.text,
          'password': passwordController.text,
        };
        ConnectController connect = ConnectController();

        var response = await connect.startMethod(
            'http://localhost:8000/api/Login', userAuthObj);
        print(response);
        // print(response.keys);
        if (response["errors"] == null) {
          User user = User(
              response["userId"],
              response["user_role"],
              response["name"],
              response["surname"],
              response["phone"],
              response["email"],
              response["birthday"]);

          loginController.text = '';
          passwordController.text = '';
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MainMenu(user),
                  fullscreenDialog: true));
        } else {
          dialogBox.showCupertinoDialog(
              context, "Ошибка Авторизации", "Такого пользователя нет");
        }
      } else {
        dialogBox.showCupertinoDialog(
            context, "Ошибка Авторизации", "Не коректная почта");
      }
    } else {
      dialogBox.showCupertinoDialog(
          context, "Ошибка Авторизации", "Заполните все поля");
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
                image: AssetImage('assets/images/authorizationBg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 30, right: 30, top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const LogoBlock(),
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            hintText: "Ваша почта",
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          ),
                          controller: loginController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            hintText: "Ваш пароль",
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          ),
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: passwordController,
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue[600]),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          minimumSize: MaterialStateProperty.all(
                              const Size(double.infinity, 48)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          getAuthUserObj(context);
                        },
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
