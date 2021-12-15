import 'package:flutter/material.dart';
import 'package:notikey/UI/my_bottom_navigate.dart';

// ignore: must_be_immutable
class SwipeBottomBlock extends StatelessWidget {
  late Widget content;
  late bool isActiveHomeItem;
  late bool isActiveNotificationItem;
  late String screen;
  late int userId;
  // ignore: use_key_in_widget_constructors
  SwipeBottomBlock(this.content, this.isActiveHomeItem,
      this.isActiveNotificationItem, this.screen, this.userId,
      {Key? key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
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
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            height: 4,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: const BorderRadius.all(Radius.circular(2)),
            ),
          ),
          content,
          BottomNavigate(
              isActiveHomeItem, isActiveNotificationItem, screen, userId),
        ],
      ),
    ));
  }
}
