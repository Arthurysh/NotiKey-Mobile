import 'package:flutter/cupertino.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class DetailNote extends StatefulWidget {
  const DetailNote({Key? key}) : super(key: key);

  @override
  _DetailNoteState createState() => _DetailNoteState();
}

class _DetailNoteState extends State<DetailNote> {
  List<String> noteDetails = ['A', 'B', 'C', 'D'];
  int resultPrice = 0;
  final _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];
  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(15, 18, 63, 100),
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Padding(
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
                    Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
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
                                  padding: EdgeInsets.all(15),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      topLeft: Radius.circular(12),
                                    ),
                                  ),
                                  child: Text('dsadsadad',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                Container(
                                  padding: EdgeInsets.all(15),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Text('dsadsadad',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                Container(
                                  padding: EdgeInsets.all(15),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                  ),
                                  child: Text('dsadsadad',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                Container(
                                  padding: EdgeInsets.all(15),
                                  width: double.infinity,
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  child: Text('dsadsadad',
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
                            padding: EdgeInsets.only(left: 20, right: 15),
                            width: double.infinity,
                            //color: Colors.green,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    "Детали записи",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    "Рекомендованные услуги",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  child: Text(
                                    "Общая сумма: $resultPrice",
                                    style: TextStyle(
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
                                    EdgeInsets.all(15))),
                            child: Text("Оплатить",
                                style: TextStyle(fontSize: 22)),
                            onPressed: () {
                              print("Clicked");
                            },
                          )
                        ],
                      ),
                    ),
                    true,
                    false)
                // BottomNavigate(false, true),
              ],
            ),
          )
        ],
      ),
    );
  }
}
