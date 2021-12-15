import 'package:flutter/material.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';

class AddVehicle extends StatefulWidget {
  late int userId;
  AddVehicle(this.userId, {Key? key}) : super(key: key);

  @override
  _AddVehicleState createState() => _AddVehicleState(userId);
}

class _AddVehicleState extends State<AddVehicle> {
  late int userId;
  _AddVehicleState(this.userId);
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
                  'Добавление транспорта',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SwipeBottomBlock(const Text('Добавление транспорта'), false, true,
                  'AddVehicle', userId)
              // BottomNavigate(false, true),
            ],
          )
        ],
      ),
    );
  }
}
