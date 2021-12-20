import 'package:flutter/material.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';

class Settings extends StatefulWidget {
  late int userId;
  Settings(this.userId, {Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState(userId);
}

class _SettingsState extends State<Settings> {
  late int userId;
  _SettingsState(this.userId);
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
                  'Настройки',
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
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.settings,
                              size: 30,
                              color: Colors.grey,
                            ),
                            Text(
                              'Настройки',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                true,
                false,
                'Settings',
                userId,
              )
              // BottomNavigate(false, true),
            ],
          )
        ],
      ),
    );
  }
}
