import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:notikey/Services/connect_controller.dart';
import 'package:notikey/UI/logo_block.dart';
import 'package:notikey/UI/my_dialog_box.dart';
import 'package:notikey/main_menu.dart';
import 'package:notikey/Entity/user.dart';

class Authorization extends StatelessWidget {
  final TextEditingController loginController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final DialogBox dialogBox = new DialogBox();

  getAuthUserObj(context) async {
    if (this.loginController.text.trim() != '' &&
        this.passwordController.text.trim() != '' &&
        this.passwordController.text.length >= 8) {
      if (this.checkEmailField(this.loginController.text)) {
        Map userAuthObj = {
          'email': this.loginController.text,
          'password': this.passwordController.text,
        };
        ConnectController connect = new ConnectController();

        var response = await connect.startMethod(
            'http://localhost:8000/api/Login', userAuthObj);
        if (!response.keys.isEmpty) {
          print(response["id"]);
          User user = User(
              response["id"],
              response["user_role"],
              response["name"],
              response["surname"],
              response["phone"],
              response["email"],
              response["birthday"]);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainMenu(user)));
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
            margin: EdgeInsets.only(left: 30, right: 30, top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LogoBlock(),
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: TextField(
                          decoration: InputDecoration(
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
                              Size(double.infinity, 48)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
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
