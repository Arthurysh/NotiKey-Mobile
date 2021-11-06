import 'package:flutter/material.dart';
import 'package:notikey/UI/my_bottom_navigate.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
                    'Уведомления',
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
                      child: Text('Notification'),
                    ),
                    false,
                    true)
                // BottomNavigate(false, true),
              ],
            ),
          )
        ],
      ),
    );
  }
}
