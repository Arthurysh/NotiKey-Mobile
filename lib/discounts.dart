// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:notikey/Entity/discount.dart';
import 'package:notikey/Services/connect_controller.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';

// ignore: must_be_immutable
class Discounts extends StatefulWidget {
  late int userId;
  Discounts(this.userId, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _DiscountsState createState() => _DiscountsState(userId);
}

class _DiscountsState extends State<Discounts> {
  late int userId;
  // ignore: unused_element
  _DiscountsState(this.userId, {Key? key});
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
              SwipeBottomBlock(
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 450,
                  child: ListSidableWidget(userId),
                ),
                true,
                false,
                'Vehicle',
                userId,
              )
            ],
          )
        ],
      ),
    );
  }
}

class DiscountBlock extends StatelessWidget {
  late Discount discountObj;

  DiscountBlock(this.discountObj, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 150,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 209, 90, 1),
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
              const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Станция - " + discountObj.stationName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    discountObj.percent.toString() + "%",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  Text(
                    "Действует до: " + discountObj.date,
                    style: TextStyle(
                        color: Colors.grey[850], fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      onTap: () {},
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
      future: getUserDiscounts(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // ignore: avoid_print
        if (snapshot.data == null) {
          return const Center(child: Text("Загрузка скидок ..."));
        } else {
          if (snapshot.data.length != 0) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Discount item = snapshot.data[index];
                return DiscountBlock(item);
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
                          "У вас пока что нет скидок",
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

  Future<List<Discount>> getUserDiscounts() async {
    ConnectController connect = ConnectController();
    List response = await connect
        .startGetMethod('http://localhost:8000/api/getDiscounts', {});

    List<Discount> discountsArr = [];
    for (var discount in response) {
      discountsArr.add(Discount(
        discount['discountsId'],
        int.parse(discount['percent']),
        discount['date'],
        discount['stationId'],
        discount['stationName'],
        discount['address'],
        discount['description'],
      ));
    }

    return discountsArr;
  }
}
