import 'package:flutter/material.dart';
import 'package:notikey/Entity/vehicle.dart';
import 'package:notikey/add_note.dart';
import 'package:notikey/add_vehicle.dart';
import 'package:notikey/notifications.dart';
import 'package:notikey/vehicles.dart';

// ignore: must_be_immutable
class BottomNavigate extends StatefulWidget {
  late bool ishome;
  late bool isNotification;
  late String screen = "MainMenu";
  late int userId;

  BottomNavigate(bool isHome, this.isNotification, this.screen, this.userId,
      {Key? key})
      : super(key: key) {
    ishome = isHome;
  }

  @override
  _BottomNavigateState createState() =>
      // ignore: no_logic_in_create_state
      _BottomNavigateState(ishome, isNotification, screen, userId);
}

class _BottomNavigateState extends State<BottomNavigate> {
  bool isActiveHomeItem = true;
  bool isActiveNotificationItem = false;
  late String screen;
  late int userId;

  _BottomNavigateState(this.isActiveHomeItem, this.isActiveNotificationItem,
      this.screen, this.userId);

  checkRouteAddScreen() {
    switch (screen) {
      case 'Notes':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddNote(userId)));
        break;
      case 'Vehicles':
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddVehicle(userId)))
            .then((value) => {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Vehicles(userId)))
                });
        break;
    }
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
              if (screen != 'MainMenu') {
                setState(() {
                  isActiveNotificationItem = false;
                  isActiveHomeItem = true;
                });

                Navigator.of(context).pop(true);
              }
            },
            child: Icon(
              Icons.home,
              size: 35,
              color: isActiveHomeItem ? Colors.black : Colors.grey[600],
            ),
          ),
          GestureDetector(
            onTap: () {
              this.checkRouteAddScreen();
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
                            builder: (context) => Notifications(userId)))
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
