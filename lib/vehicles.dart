// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:notikey/Actions/slidable_widget.dart';
import 'package:notikey/Entity/vehicle.dart';
import 'package:notikey/Services/connect_controller.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';
import 'package:notikey/detail_vehicle.dart';

class Vehicles extends StatefulWidget {
  late int userId;
  Vehicles(this.userId, {Key? key}) : super(key: key);

  @override
  _VehiclesState createState() => _VehiclesState(userId);
}

class _VehiclesState extends State<Vehicles> {
  late int userId;
  _VehiclesState(this.userId);

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
                  'Транспорт',
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
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 450,
                    child: ListSidableWidget(userId),
                  ),
                  true,
                  false,
                  'Vehicles',
                  userId)
              // BottomNavigate(false, true),
            ],
          )
        ],
      ),
    );
  }
}

class VehicleBlock extends StatelessWidget {
  late Vehicle vehicleObj;
  late int userId;

  VehicleBlock(this.vehicleObj, this.userId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(238, 239, 255, 1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 6,
            ),
          ],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    // flex: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Image(
                          image: AssetImage("assets/images/carPrototype.png"),
                          width: 150,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    // flex: 40,
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      alignment: Alignment.center,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Бренд:  ",
                                    style: TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Модель:  ",
                                    style: TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Год:  ",
                                    style: TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Тип:  ",
                                    style: TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    vehicleObj.brand,
                                    style: TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    vehicleObj.model,
                                    style: TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    vehicleObj.year,
                                    style: TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    vehicleObj.type,
                                    style: TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailVehicle(vehicleObj, userId)));
      },
    );
  }
}

class ListSidableWidget extends StatefulWidget {
  late int userId;

  // ignore: use_key_in_widget_constructors
  ListSidableWidget(this.userId, {Key? key});

  @override
  // ignore: no_logic_in_create_state
  _DismissibleListState createState() => _DismissibleListState(userId);
}

class _DismissibleListState extends State<ListSidableWidget> {
  late int userId;

  _DismissibleListState(this.userId);

  @override
  Widget build(BuildContext context) {
    // the list of elements
    return FutureBuilder(
      future: getUserVehicles(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // ignore: avoid_print
        if (snapshot.data == null) {
          return const Center(child: Text("Загрузка транспорта ..."));
        } else {
          if (snapshot.data.length != 0) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Vehicle item = snapshot.data[index];
                return SlidableWidget(
                  child: VehicleBlock(item, userId),
                  onDismissed: (action) {
                    setState(
                      () {
                        deleteVehicle(snapshot.data[index].vehicleId);
                      },
                    );
                  },
                );
              },
              padding: (const EdgeInsets.only(
                  top: 30, left: 15, right: 15, bottom: 30)),
            );
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    width: double.infinity,
                    height: 80,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.0,
                        style: BorderStyle.solid,
                        color: const Color.fromRGBO(217, 218, 162, 1.0),
                      ),
                      color: const Color.fromRGBO(254, 255, 214, 1.0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "У вас пока что нет транспорта",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        }
      },
    );
  }

  Future<List<Vehicle>> getUserVehicles() async {
    ConnectController connect = ConnectController();
    List response = await connect.startGetMethod(
        'http://localhost:8000/api/getUserCars', {"userId": userId});

    // print(response);

    List<Vehicle> vehicleArr = [];
    for (var vehicle in response) {
      vehicleArr.add(Vehicle(
          vehicle["carId"],
          vehicle["brand"],
          vehicle["model"],
          vehicle["image"],
          vehicle["type"],
          vehicle["year"],
          vehicle["nomera"]));
    }
    return vehicleArr;
  }

  deleteVehicle(vehicleId) async {
    ConnectController connect = ConnectController();
    Map vehicleIdObj = {
      'idCars': vehicleId,
    };
    await connect.startMethod(
        'http://localhost:8000/api/deleteCars', vehicleIdObj);
  }
}
