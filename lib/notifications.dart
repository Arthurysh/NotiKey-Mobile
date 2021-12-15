import 'package:flutter/material.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';

class Notifications extends StatefulWidget {
  late int userId;
  Notifications(this.userId, {Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState(userId);
}

class _NotificationsState extends State<Notifications> {
  late int userId;
  _NotificationsState(this.userId);
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
                  'Уведомления',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SwipeBottomBlock(const Text('Notification'), false, true,
                  'Notifications', userId)
              // BottomNavigate(false, true),
            ],
          )
        ],
      ),
    );
  }
}
