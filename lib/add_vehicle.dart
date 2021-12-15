import 'package:flutter/material.dart';
import 'package:notikey/Services/connect_controller.dart';
import 'package:notikey/UI/my_dialog_box.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';

class AddVehicle extends StatefulWidget {
  late int userId;

  AddVehicle(this.userId, {Key? key}) : super(key: key);

  @override
  _AddVehicleState createState() => _AddVehicleState(userId);
}

class _AddVehicleState extends State<AddVehicle> {
  late int userId;
  bool isActiveAddBtn = false;
  ConnectController connect = ConnectController();
  final DialogBox dialogBox = DialogBox();

  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  _AddVehicleState(this.userId);

  checkChangeEventField() {
    int countValidatedField = 0;
    if (brandController.text.trim() == '') countValidatedField++;
    if (modelController.text.trim() == '') countValidatedField++;
    if (yearController.text.trim() == '' ||
        yearController.text.length < 4 ||
        yearController.text.length > 4) countValidatedField++;
    if (typeController.text.trim() == '') countValidatedField++;
    if (numberController.text.trim() == '') countValidatedField++;
    if (countValidatedField == 0) {
      setState(() {
        isActiveAddBtn = true;
      });
    } else {
      setState(() {
        isActiveAddBtn = false;
      });
    }
  }

  addUserVehicle() async {
    Map userVehicleObj = {
      'brand': brandController.text,
      'model': modelController.text,
      'userId': userId,
      'year': yearController.text,
      'type': typeController.text,
      'image': 'carPrototype.png',
      'nomera': numberController.text
    };

    var response = await connect.startMethod(
        'http://localhost:8000/api/addCars', userVehicleObj);

    if (response["error"] == null) {
      setState(() {
        isActiveAddBtn = false;
        brandController.text = '';
        modelController.text = '';
        yearController.text = '';
        typeController.text = '';
        numberController.text = '';
      });
      Navigator.of(context).pop(true);
    } else {
      dialogBox.showCupertinoDialog(
          context, "Ошибка добавления", "Проверьте поля и попробуйте снова");
    }
  }

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
              SwipeBottomBlock(
                Container(
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage("assets/images/carPrototype.png"),
                        width: 180,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            right: 20, left: 20, top: 20, bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  topLeft: Radius.circular(12),
                                ),
                              ),
                              child: TextField(
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(0),
                                  hintText: 'Бренд транспорта',
                                ),
                                onChanged: (String value) {
                                  checkChangeEventField();
                                },
                                controller: brandController,
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: TextField(
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(0),
                                  hintText: 'Модель транспорта',
                                ),
                                onChanged: (String value) {
                                  checkChangeEventField();
                                },
                                controller: modelController,
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                              ),
                              child: TextField(
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                keyboardType: TextInputType.datetime,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(0),
                                    hintText: 'Год выпуска'),
                                onChanged: (String value) {
                                  checkChangeEventField();
                                },
                                controller: yearController,
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              width: double.infinity,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: TextField(
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(0),
                                    hintText: 'Тип кузова'),
                                onChanged: (String value) {
                                  checkChangeEventField();
                                },
                                controller: typeController,
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                              ),
                              child: TextField(
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(0),
                                    hintText: 'Регистрационный номер'),
                                onChanged: (String value) {
                                  checkChangeEventField();
                                },
                                controller: numberController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.all(15),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              backgroundColor: isActiveAddBtn
                                  ? MaterialStateProperty.all(Colors.blue[600])
                                  : MaterialStateProperty.all(
                                      Colors.grey[600])),
                          child: const Text("Добавить",
                              style: TextStyle(fontSize: 16)),
                          onPressed: () {
                            // ignore: avoid_print
                            if (isActiveAddBtn) {
                              addUserVehicle();
                            }
                          },
                        ),
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
                true,
                false,
                'AddVehicle',
                userId,
              )
            ],
          )
        ],
      ),
    );
  }
}
