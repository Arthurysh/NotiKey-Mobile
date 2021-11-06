import 'package:flutter/material.dart';
import 'package:notikey/UI/my_bottom_navigate.dart';

class SwipeBottomBlock extends StatelessWidget {
  late Widget content;
  late bool isActiveHomeItem;
  late bool isActiveNotificationItem;
  SwipeBottomBlock(
      Widget content, bool isActiveHomeItem, bool isActiveNotificationItem) {
    this.content = content;
    this.isActiveHomeItem = isActiveHomeItem;
    this.isActiveNotificationItem = isActiveNotificationItem;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 10),
            height: 4,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
          ),
          content,
          BottomNavigate(isActiveHomeItem, isActiveNotificationItem),
        ],
      ),
    ));
  }
}
