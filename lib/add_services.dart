import 'package:flutter/material.dart';
import 'package:notikey/Entity/service.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';

class AddServices extends StatefulWidget {
  late int userId;
  late List<Service> servicesList;
  late List<Service> addedServiceList;
  AddServices(this.userId, this.servicesList, this.addedServiceList,
      {Key? key});

  @override
  _AddServicesState createState() =>
      _AddServicesState(userId, servicesList, addedServiceList);
}

class _AddServicesState extends State<AddServices> {
  late int userId;

  List<TableRow> userSelectedList = [];
  List<Map> selectedServiceObjectArr = [];
  bool isActiveSaveServicesBtn = true;

  List<Service> servicesList = [];
  List<Service> addedServicesList = [];

  int servicesTotalCost = 0;

  _AddServicesState(this.userId, this.servicesList, this.addedServicesList) {
    fillServicesTable();
  }

  fillServicesTable() {
    Future.delayed(const Duration(milliseconds: 500), () {
      int count = 0;
      for (var item in addedServicesList) {
        addServiceRowToTable(item);
        selectedServiceObjectArr[count]["serviceName"] = item.name;
        selectedServiceObjectArr[count]["price"] = item.price;
        count++;
      }

      setState(() {
        selectedServiceObjectArr = selectedServiceObjectArr;
        countServicesTotalCost();
      });
    });
  }

  List<String> getStringArrServicesForSelect() {
    List<String> serviceStringNameArr = [];

    for (var item in servicesList) {
      serviceStringNameArr.add(item.name);
    }

    return serviceStringNameArr;
  }

  addServiceRowToTable(servObj) {
    setState(() {});
    var service;
    Map currentRow;
    if (servObj != null) {
      currentRow = {
        'rowId': userSelectedList.length,
        'serviceName': servObj.name,
        'price': servObj.price
      };
    } else {
      currentRow = {
        'rowId': userSelectedList.length,
        'serviceName': service,
        'price': 0
      };
    }

    selectedServiceObjectArr.add(currentRow);

    userSelectedList.add(TableRow(children: [
      TableCell(
          child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: ((userSelectedList.length + 1) % 2) != 0
                ? Colors.grey[400]
                : Colors.white,
            border: Border(
              right:
                  BorderSide(color: Color.fromRGBO(149, 149, 149, 1), width: 1),
              bottom:
                  BorderSide(color: Color.fromRGBO(149, 149, 149, 1), width: 1),
            )),
        padding: EdgeInsets.all(10),
        child: DropdownButton<String>(
          value: selectedServiceObjectArr[currentRow["rowId"]]["serviceName"],
          isDense: true,
          underline: Container(
            height: 0,
          ),
          hint: const Text("Услуги"),
          style: const TextStyle(
              fontSize: 15, color: Color.fromRGBO(55, 55, 55, 1)),
          isExpanded: true,
          dropdownColor: Colors.white,
          items: getStringArrServicesForSelect().map((String valueItem) {
            return DropdownMenuItem<String>(
              value: valueItem,
              child: Text(
                valueItem,
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            selectedServiceObjectArr[currentRow["rowId"]]["serviceName"] =
                newValue;

            for (var item in servicesList) {
              if (item.name == newValue) {
                selectedServiceObjectArr[currentRow["rowId"]]["price"] =
                    item.price;
              }
            }
            currentRow["serviceName"] = newValue;

            setState(() {
              service = newValue;
              selectedServiceObjectArr = selectedServiceObjectArr;
            });

            countServicesTotalCost();
          },
        ),
      )),
      TableCell(
          child: Container(
        decoration: BoxDecoration(
            color: ((userSelectedList.length + 1) % 2) != 0
                ? Colors.grey[400]
                : Colors.white,
            border: Border(
              bottom:
                  BorderSide(color: Color.fromRGBO(149, 149, 149, 1), width: 1),
            )),
        height: 40,
        padding: EdgeInsets.all(10),
        child: Text(
          currentRow["price"].toString() + 'грн',
          style: TextStyle(fontSize: 15),
          textAlign: TextAlign.center,
        ),
      ))
    ]));
    // });
  }

  updateServiceObj() {
    setState(() {
      userSelectedList = userSelectedList;
    });
  }

  deleteServiceRowFromTable() {
    if (userSelectedList.length > 0) {
      setState(() {
        userSelectedList.removeLast();
        selectedServiceObjectArr.removeLast();
        print(selectedServiceObjectArr);
        countServicesTotalCost();
      });
    }
  }

  countServicesTotalCost() {
    int totalCost = 0;
    for (var item in selectedServiceObjectArr) {
      int price = item["price"];
      totalCost += price;
    }
    setState(() {
      servicesTotalCost = totalCost;
    });
  }

  getServices() {
    List<Service> services = [];

    for (var item in selectedServiceObjectArr) {
      for (var service in servicesList) {
        if (item["serviceName"] == service.name) {
          services.add(service);
        }
      }
    }

    return services;
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
                  'Добавление услуг',
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
                      color: Colors.white,
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Table(
                                  border: null,
                                  children: [
                                    TableRow(children: [
                                      TableCell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Color.fromRGBO(
                                                          149, 149, 149, 1),
                                                      width: 1),
                                                  right: BorderSide(
                                                      color: Color.fromRGBO(
                                                          149, 149, 149, 1),
                                                      width: 1))),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text(
                                              "Услуга",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                            bottom: BorderSide(
                                                color: Color.fromRGBO(
                                                    149, 149, 149, 1),
                                                width: 1),
                                          )),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text(
                                              "Стоимость",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                                  ],
                                ),
                                Container(
                                  height: 220,
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                    children: [
                                      Table(
                                        border: null,
                                        children: userSelectedList,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      top: BorderSide(
                                          color:
                                              Color.fromRGBO(149, 149, 149, 1),
                                          width: 1),
                                    )),
                                    padding:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Общая сумма: ${servicesTotalCost}грн",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ],
                                    ))
                              ],
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                ),
                              ],
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 6,
                                  child: Container(
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size(160, 50)),
                                          padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(15),
                                          ),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          backgroundColor:
                                              isActiveSaveServicesBtn
                                                  ? MaterialStateProperty.all(
                                                      Colors.blue[600])
                                                  : MaterialStateProperty.all(
                                                      Colors.grey[600])),
                                      child: const Text("Сохранить",
                                          style: TextStyle(fontSize: 16)),
                                      onPressed: () {
                                        // ignore: avoid_print
                                        if (isActiveSaveServicesBtn) {
                                          List<Service> arrServ = getServices();
                                          print(arrServ);
                                          Navigator.of(context).pop(arrServ);
                                        }
                                      },
                                    ),
                                    // width: double.infinity,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  flex: 3,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: IconButton(
                                      icon: const Icon(Icons.add_outlined),
                                      color: Colors.white,
                                      onPressed: () {
                                        addServiceRowToTable(null);
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
                                        color: Colors.red[400],
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: IconButton(
                                      icon: const Icon(Icons.delete),
                                      color: Colors.white,
                                      onPressed: () {
                                        deleteServiceRowFromTable();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                  true,
                  false,
                  'AddServices',
                  userId)
              // BottomNavigate(false, true),
            ],
          )
        ],
      ),
    );
  }
}
