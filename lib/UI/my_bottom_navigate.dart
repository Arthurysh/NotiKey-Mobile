import 'package:flutter/material.dart';
import 'package:notikey/add_note.dart';
import 'package:notikey/notifications.dart';

// ignore: must_be_immutable
class BottomNavigate extends StatefulWidget {
  late bool ishome;
  late bool isNotification;

  BottomNavigate(bool isHome, this.isNotification, {Key? key})
      : super(key: key) {
    ishome = isHome;
  }
  @override
  _BottomNavigateState createState() =>
      // ignore: no_logic_in_create_state
      _BottomNavigateState(ishome, isNotification);
}

class _BottomNavigateState extends State<BottomNavigate> {
  bool isActiveHomeItem = true;
  bool isActiveNotificationItem = false;

  _BottomNavigateState(bool isHome, bool isNotification) {
    isActiveHomeItem = isHome;
    isActiveNotificationItem = isNotification;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10, bottom: 15),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                isActiveNotificationItem = false;
                isActiveHomeItem = true;
              });

              Navigator.of(context).pop(true);
            },
            child: Icon(
              Icons.home,
              size: 35,
              color: isActiveHomeItem ? Colors.black : Colors.grey[600],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddNote()));
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
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
                            builder: (context) => const Notifications()))
                    .then((value) {
                  setState(() {
                    isActiveHomeItem = true;
                    isActiveNotificationItem = false;
                  });
                });
              }
            },
            child: Icon(
              Icons.notifications,
              size: 35,
              color: isActiveNotificationItem ? Colors.black : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
