// ignore_for_file: unnecessary_new

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:notikey/Entity/service.dart';
import 'package:notikey/Services/connect_controller.dart';
import 'package:notikey/UI/my_dialog_box.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:notikey/add_services.dart';

class AddNote extends StatefulWidget {
  late int userId;
  AddNote(this.userId, {Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState(userId);
}

class _AddNoteState extends State<AddNote> {
  late int userId;
  _AddNoteState(this.userId) {
    startGetSelectData();
  }
  DateTime selectedDate = DateTime.now();
  // ignore: unused_field
  String? _selectedTime;
  bool isActiveAddBtn = false;

  ConnectController connect = ConnectController();
  final DialogBox dialogBox = DialogBox();

  List<Map> stationsDataSource = [];
  List<Map> vehicleDataSource = [];
  List<Map> timeDataSource = [];
  List<Service> serviceDataSource = [];
  List<Service> selectedService = [];

  var selectStation;
  var selectVehicle;
  var selectTime;
  var selectService;

  final TextEditingController dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        dateController.text =
            picked.toString().substring(0, 10).split("-").reversed.join('-');
        checkCreateNoteField();
      });
    }
  }

  getSelectDataSource() async {
    List stationsResponse = await connect
        .startGetMethod('http://localhost:8000/api/getListStation', {});
    for (var station in stationsResponse) {
      stationsDataSource.add(station);
    }

    List vehiclesResponse = await connect.startGetMethod(
        'http://localhost:8000/api/getListNameCars', {"userId": userId});
    for (var vehicle in vehiclesResponse) {
      vehicleDataSource.add(vehicle);
    }

    List timeResponse = await connect
        .startGetMethod('http://localhost:8000/api/getTimeList', {});
    for (var time in timeResponse) {
      timeDataSource.add(time);
    }

    List servicesResponse = await connect
        .startGetMethod('http://localhost:8000/api/getServicesList', {});

    for (var service in servicesResponse) {
      serviceDataSource.add(Service(
          service['servicesId'], service['name'], int.parse(service['price'])));
    }
  }

  startGetSelectData() async {
    await getSelectDataSource();
    setState(() {});
  }

  List<String> getSourceArrayForSelect(arrType) {
    List<String> sourceArr = [];

    switch (arrType) {
      case 'Stations':
        for (var item in stationsDataSource) {
          sourceArr.add(item["stationName"]);
        }
        break;
      case 'Vehicles':
        for (var item in vehicleDataSource) {
          sourceArr.add(item["brand"] + " " + item["model"]);
        }
        break;
      case 'Time':
        for (var item in timeDataSource) {
          sourceArr.add(item["time"]);
        }
        break;
      case 'Services':
        for (var item in selectedService) {
          sourceArr.add(item.name);
        }
        break;
    }

    return sourceArr;
  }

  createNoteObj() async {
    Map noteObj = {
      'userId': this.userId,
      'cars': 0,
      'statusId': 1,
      'station': 0,
      'date':
          dateController.text.substring(0, 10).split("-").reversed.join('-'),
      'time': 0,
      'services': [],
    };

    late int stationId;
    late int timeId;
    late int carsId = 0;
    List<Map> serviceObjList = [];

    timeDataSource.forEach((element) {
      if (element["time"] == selectTime) {
        timeId = element["timeId"];
      }
    });

    stationsDataSource.forEach((element) {
      if (element["stationName"] == selectStation) {
        stationId = element["stationId"];
      }
    });

    vehicleDataSource.forEach((element) {
      if (element["brand"] + " " + element["model"] == selectVehicle) {
        carsId = element["carId"];
      }
    });

    for (var service in selectedService) {
      Map serv = {
        'servicesId': service.id,
        'name': service.name,
        'price': service.price
      };
      serviceObjList.add(serv);
    }

    noteObj["services"] = serviceObjList;
    noteObj["time"] = timeId;
    noteObj["station"] = stationId;
    noteObj["cars"] = carsId;

    var response = await connect.startMethod(
        'http://localhost:8000/api/insertNotes', noteObj);

    if (response["error"] == null) {
      Navigator.of(context).pop(true);
    } else {
      dialogBox.showCupertinoDialog(
          context, "Ошибка добавления", "Проверьте поля и попробуйте снова");
    }
  }

  checkCreateNoteField() {
    int countValidatedField = 0;
    print(selectStation);
    if (selectStation == null) countValidatedField++;
    if (selectVehicle == null) countValidatedField++;
    if (dateController.text == '') countValidatedField++;
    if (selectTime == null) countValidatedField++;
    if (selectedService.length == 0) countValidatedField++;
    if (countValidatedField == 0) {
      setState(() {
        isActiveAddBtn = true;
      });
    } else {
      setState(() {
        isActiveAddBtn = false;
      });
    }
    print(countValidatedField);
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
                  'Добавление записи',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SwipeBottomBlock(
                Column(
                  children: [
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
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(12),
                                topLeft: Radius.circular(12),
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: selectStation,
                              isDense: true,
                              underline: Container(
                                height: 0,
                              ),
                              hint: const Text("Станция обсуживания"),
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(55, 55, 55, 1)),
                              isExpanded: true,
                              dropdownColor: Colors.white,
                              items: getSourceArrayForSelect('Stations')
                                  .map((String valueItem) {
                                return new DropdownMenuItem<String>(
                                  value: valueItem,
                                  child: new Text(valueItem),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectStation = newValue.toString();
                                  checkCreateNoteField();
                                });
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 10),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: DropdownButton<String>(
                              value: selectVehicle,
                              isDense: true,
                              underline: Container(
                                height: 0,
                              ),
                              hint: const Text("Транспорт"),
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(55, 55, 55, 1)),
                              isExpanded: true,
                              dropdownColor: Colors.white,
                              items: getSourceArrayForSelect('Vehicles')
                                  .map((String valueItem) {
                                return new DropdownMenuItem<String>(
                                  value: valueItem,
                                  child: new Text(valueItem),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectVehicle = newValue.toString();
                                  checkCreateNoteField();
                                });
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                            ),
                            child: TextField(
                              readOnly: true,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(0),
                                hintText: 'Дата',
                                suffixIcon: Icon(
                                  Icons.date_range,
                                  color: Color.fromRGBO(66, 66, 66, 1),
                                ),
                                suffixIconConstraints: BoxConstraints(
                                  maxWidth: 30,
                                  maxHeight: 24,
                                ),
                              ),
                              onTap: () => _selectDate(context),
                              controller: dateController,
                              onChanged: (value) {
                                checkCreateNoteField();
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 10),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: selectTime,
                              isDense: true,
                              underline: Container(
                                height: 0,
                              ),
                              hint: const Text("Время"),
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(55, 55, 55, 1)),
                              isExpanded: true,
                              dropdownColor: Colors.white,
                              items: getSourceArrayForSelect('Time')
                                  .map((String valueItem) {
                                return new DropdownMenuItem<String>(
                                  value: valueItem,
                                  child: new Text(valueItem),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectTime = newValue.toString();
                                  checkCreateNoteField();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 7,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 10, bottom: 10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey[400],
                              ),
                              child: DropdownButton<String>(
                                isDense: true,
                                underline: Container(
                                  height: 0,
                                ),
                                hint: const Text("Услуги"),
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(55, 55, 55, 1)),
                                isExpanded: true,
                                dropdownColor: Colors.white,
                                items: getSourceArrayForSelect('Services')
                                    .map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    checkCreateNoteField();
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            flex: 3,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12)),
                              child: IconButton(
                                icon: const Icon(Icons.add_outlined),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddServices(
                                                  userId,
                                                  serviceDataSource,
                                                  selectedService)))
                                      .then((value) => {
                                            if (value != null)
                                              {
                                                setState(() {
                                                  selectedService = value;
                                                  checkCreateNoteField();
                                                })
                                              }
                                          });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
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
                                : MaterialStateProperty.all(Colors.grey[600])),
                        child: const Text("Добавить",
                            style: TextStyle(fontSize: 16)),
                        onPressed: () {
                          // ignore: avoid_print
                          if (isActiveAddBtn) {
                            createNoteObj();
                          }
                        },
                      ),
                      width: double.infinity,
                    ),
                  ],
                ),
                true,
                false,
                'AddNote',
                userId,
              )
            ],
          )
        ],
      ),
    );
  }
}
