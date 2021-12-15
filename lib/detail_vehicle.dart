import 'package:flutter/material.dart';
import 'package:notikey/Entity/vehicle.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';

class DetailVehicle extends StatefulWidget {
  late Vehicle vehicleObj;
  DetailVehicle(this.vehicleObj, {Key? key}) : super(key: key);

  @override
  _DetailVehicleState createState() => _DetailVehicleState(vehicleObj);
}

class _DetailVehicleState extends State<DetailVehicle> {
  late Vehicle vehicleObj;
  _DetailVehicleState(this.vehicleObj);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(15, 18, 63, 100),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 20),
                child: Text(
                  vehicleObj.brand + " " + vehicleObj.model,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(69, 153, 245, 1),
                      width: 5,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(250),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Image(
                      image: AssetImage("assets/images/carPrototype.png"),
                    ),
                  ),
                ),
              ),
              SwipeBottomBlock(
                  Container(
                    padding: const EdgeInsets.only(),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          alignment: Alignment.center,
                          child: const Text(
                            'Характеристики транспорта',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          color: Colors.grey[350],
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8, top: 8, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Бренд:',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  vehicleObj.brand,
                                  style: const TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8, top: 8, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Модель:',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                vehicleObj.model,
                                style: const TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.grey[350],
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8, top: 8, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Тип кузова:',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  vehicleObj.type,
                                  style: const TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8, top: 8, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Год выпуска:',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                vehicleObj.year,
                                style: const TextStyle(fontSize: 15),
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.grey[350],
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8, top: 8, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Номер в базе:',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  vehicleObj.vehicleNumber,
                                  style: const TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  true,
                  false)
            ],
          )
        ],
      ),
    );
  }
}
