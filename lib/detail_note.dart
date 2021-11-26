// ignore_for_file: unused_element

import 'package:flutter/cupertino.dart';
import 'package:notikey/Entity/note.dart';
import 'package:notikey/Entity/service.dart';
import 'package:notikey/UI/my_switch.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';
import 'package:flutter/material.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
// import 'package:pay/pay.dart';

// ignore: must_be_immutable
class DetailNote extends StatefulWidget {
  late Note viewNoteObj;

  // ignore: use_key_in_widget_constructors
  DetailNote(this.viewNoteObj, {Key? key});

  @override
  // ignore: no_logic_in_create_state
  _DetailNoteState createState() => _DetailNoteState(viewNoteObj);
}

class _DetailNoteState extends State<DetailNote> {
  List<String> noteDetails = ['A', 'B', 'C', 'D'];
  late Note viewNoteObj;
  bool isActivePayBtn = false;
  int resultPrice = 0;
  final List<bool> _isOpen = [false, false];
  List<Map> additionalLocalServices = [];
  bool isReload = false;

  _DetailNoteState(this.viewNoteObj) {
    isActivePayBtn = checkPayStatus();
    copyAdditionalService();
    calculateServiceTotalCost();
  }
  // final _paymentItems = [
  //   PaymentItem(
  //     label: 'Total',
  //     amount: '99.99',
  //     status: PaymentItemStatus.final_price,
  //   )
  // ];
  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  bool checkPayStatus() {
    if (viewNoteObj.status == 'Готово к оплате') {
      return true;
    }
    return false;
  }

  calculateServiceTotalCost() {
    resultPrice = 0;
    for (var element in viewNoteObj.services) {
      resultPrice += element.price;
    }
    additionalLocalServices.forEach((element) {
      if (element['include']) {
        int addServPrice = element['price'];
        resultPrice += addServPrice;
      }
    });
  }

  copyAdditionalService() {
    for (var element in viewNoteObj.additionServices) {
      Map additionalServiceObj = {
        'id': element.id,
        'name': element.name,
        'price': element.price,
        'include': false
      };

      additionalLocalServices.add(additionalServiceObj);
    }
  }

  activateAdditionalService(elementId) {
    additionalLocalServices.forEach((element) {
      if (element['id'] == elementId) {
        element['include'] = !element['include'];
      }
    });
    calculateServiceTotalCost();
    setState(() {
      isReload = !isReload;
    });
  }

  List<Widget> getServicesListWidget() {
    List<Widget> servicesList = [];

    for (var element in viewNoteObj.services) {
      servicesList.add(Container(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(top: 6, bottom: 6),
          child: Text(
            '${element.name} - ${element.price}грн',
            textAlign: TextAlign.left,
            style: TextStyle(),
          ),
        ),
      ));
    }

    return servicesList;
  }

  List<Widget> getAdditionalServicesListWidget() {
    List<Widget> additionalServicesList = [];

    for (var element in additionalLocalServices) {
      additionalServicesList.add(Container(
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${element['name']} - ${element['price']}грн',
              textAlign: TextAlign.left,
              style: TextStyle(),
            ),
            CupertinoSwitchWidget(
                () => {activateAdditionalService(element['id'])}),
          ],
        ),
      ));
    }

    return additionalServicesList;
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
                  'Ваша запись',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SwipeBottomBlock(
                  SizedBox(
                    height: 450,
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              right: 20, left: 20, bottom: 15),
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
                                padding: const EdgeInsets.all(8),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    topLeft: Radius.circular(12),
                                  ),
                                ),
                                child: Text(viewNoteObj.stationName,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Text(viewNoteObj.adress,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                ),
                                child: Text(
                                    viewNoteObj.brand + " " + viewNoteObj.model,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                width: double.infinity,
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: Text(
                                    viewNoteObj.date
                                        .toString()
                                        .split('-')
                                        .reversed
                                        .join('.'),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                ),
                                child: Text(viewNoteObj.time,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Text(viewNoteObj.status,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: Text(
                                    convertNoteServicesToString(
                                        viewNoteObj.services),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 10),
                          width: double.infinity,
                          // color: Colors.green,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ConfigurableExpansionTile(
                                animatedWidgetFollowingHeader: const Icon(
                                  Icons.expand_more,
                                  color: Color(0xFF707070),
                                ),
                                headerExpanded: Flexible(
                                    child: Container(
                                        alignment: Alignment.topLeft,
                                        child: const Text("Детали записи",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            )))),
                                header: Flexible(
                                    child: Container(
                                        alignment: Alignment.topLeft,
                                        color: Colors.transparent,
                                        child: const Text("Детали записи",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            )))),
                                headerBackgroundColorStart: Colors.white,
                                expandedBackgroundColor: Colors.white,
                                headerBackgroundColorEnd: Colors.white,
                                topBorderOn: false,
                                bottomBorderOn: false,
                                children: getServicesListWidget(),
                              ),
                              ConfigurableExpansionTile(
                                animatedWidgetFollowingHeader: const Icon(
                                  Icons.expand_more,
                                  color: Color(0xFF707070),
                                ),
                                headerExpanded: Flexible(
                                    child: Container(
                                        alignment: Alignment.topLeft,
                                        child:
                                            const Text("Рекомендованные услуги",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                )))),
                                header: Flexible(
                                    child: Container(
                                        alignment: Alignment.topLeft,
                                        color: Colors.transparent,
                                        child:
                                            const Text("Рекомендованные услуги",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                )))),
                                headerBackgroundColorStart: Colors.white,
                                expandedBackgroundColor: Colors.white,
                                headerBackgroundColorEnd: Colors.white,
                                topBorderOn: false,
                                bottomBorderOn: false,
                                children: getAdditionalServicesListWidget(),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Text(
                                  "Общая сумма: $resultPriceгрн",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // GooglePayButton(
                        //   paymentConfigurationAsset: 'gpay.json',
                        //   paymentItems: _paymentItems,
                        //   style: GooglePayButtonStyle.black,
                        //   type: GooglePayButtonType.pay,
                        //   margin: const EdgeInsets.only(top: 15.0),
                        //   onPaymentResult: onGooglePayResult,
                        //   loadingIndicator: const Center(
                        //     child: CircularProgressIndicator(),
                        //   ),
                        // )
                        Padding(
                          padding: const EdgeInsets.only(left: 28, right: 28),
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
                                backgroundColor: isActivePayBtn
                                    ? MaterialStateProperty.all(
                                        Colors.blue[600])
                                    : MaterialStateProperty.all(
                                        Colors.grey[600])),
                            child: const Text("Оплатить",
                                style: TextStyle(fontSize: 16)),
                            onPressed: () {
                              // ignore: avoid_print
                              if (isActivePayBtn) {
                                print("Clicked");
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  true,
                  false)
              // BottomNavigate(false, true),
            ],
          )
        ],
      ),
    );
  }

  String convertNoteServicesToString(List<Service> services) {
    String servicesString = '';

    int count = 0;
    for (var item in services) {
      count++;
      if (count < services.length) {
        servicesString += item.name + ", ";
      } else {
        servicesString += item.name;
        count++;
      }
    }
    return servicesString;
  }
}
