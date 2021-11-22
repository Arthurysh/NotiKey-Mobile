import 'package:flutter/cupertino.dart';
import 'package:notikey/Entity/note.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';
import 'package:flutter/material.dart';
// import 'package:pay/pay.dart';

// ignore: must_be_immutable
class DetailNote extends StatefulWidget {
  late Note viewNoteObj;

  // ignore: use_key_in_widget_constructors
  DetailNote(this.viewNoteObj, {Key? key});

  @override
  _DetailNoteState createState() => _DetailNoteState();
}

class _DetailNoteState extends State<DetailNote> {
  List<String> noteDetails = ['A', 'B', 'C', 'D'];
  int resultPrice = 0;

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
                              padding: const EdgeInsets.all(15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  topLeft: Radius.circular(12),
                                ),
                              ),
                              child: const Text('dsadsadad',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: const Text('dsadsadad',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                              ),
                              child: const Text('dsadsadad',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              width: double.infinity,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: const Text('dsadsadad',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 15),
                        width: double.infinity,
                        //color: Colors.green,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Детали записи",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 8),
                              child: const Text(
                                "Рекомендованные услуги",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Text(
                                "Общая сумма: $resultPrice",
                                style: const TextStyle(
                                  fontSize: 20,
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
                      ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(15))),
                        child: const Text("Оплатить",
                            style: TextStyle(fontSize: 22)),
                        onPressed: () {
                          // ignore: avoid_print
                          print("Clicked");
                        },
                      )
                    ],
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
}
