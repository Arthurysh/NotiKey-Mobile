import 'package:flutter/material.dart';
import 'package:notikey/Entity/user.dart';
import 'package:notikey/detail_note.dart';
import 'package:notikey/main_menu.dart';
import 'package:notikey/notifications.dart';

class BottomNavigate extends StatefulWidget {
  late bool ishome;
  late bool isNotification;

  BottomNavigate(bool isHome, bool isNotification) {
    this.ishome = isHome;
    this.isNotification = isNotification;
  }
  @override
  _BottomNavigateState createState() =>
      _BottomNavigateState(ishome, isNotification);
}

class _BottomNavigateState extends State<BottomNavigate> {
  bool isActiveHomeItem = true;
  bool isActiveNotificationItem = false;

  _BottomNavigateState(bool isHome, bool isNotification) {
    this.isActiveHomeItem = isHome;
    this.isActiveNotificationItem = isNotification;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10, bottom: 15),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                this.isActiveNotificationItem = false;
                this.isActiveHomeItem = true;
              });

              Navigator.of(context).pop(true);
            },
            child: Container(
              child: Icon(
                Icons.home,
                size: 35,
                color: isActiveHomeItem ? Colors.black : Colors.grey[600],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DetailNote()));
            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.add,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (!isActiveNotificationItem) {
                setState(() {
                  isActiveNotificationItem = true;
                  isActiveHomeItem = false;
                });

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Notifications())).then((value) {
                  setState(() {
                    isActiveHomeItem = true;
                    isActiveNotificationItem = false;
                  });
                });
              }
            },
            child: Container(
              child: Icon(
                Icons.notifications,
                size: 35,
                color:
                    isActiveNotificationItem ? Colors.black : Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
