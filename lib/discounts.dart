import 'package:flutter/material.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';

class Discounts extends StatefulWidget {
  const Discounts({Key? key}) : super(key: key);

  @override
  _DiscountsState createState() => _DiscountsState();
}

class _DiscountsState extends State<Discounts> {
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
                  'Скидки',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SwipeBottomBlock(const Text('Скидки'), true, false)
              // BottomNavigate(false, true),
            ],
          )
        ],
      ),
    );
  }
}
