import 'package:flutter/cupertino.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  DateTime selectedDate = DateTime.now();
  String? _selectedTime;

  Future<void> _show() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedTime = result.format(context);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
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
                    Container(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.black,
                                )),
                            padding: EdgeInsets.only(top: 10, left: 25),
                            height: 50,
                            width: 300,
                            child: DropdownButton<String>(
                              isDense: true,
                              underline: Container(
                                height: 0,
                              ),
                              hint: Text("Станция СТО"),
                              style: TextStyle(fontSize: 20),
                              isExpanded: true,
                              dropdownColor: Colors.green,
                              items: <String>['A', 'B', 'C', 'D']
                                  .map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.black,
                                )),
                            padding: EdgeInsets.only(top: 10, left: 25),
                            height: 50,
                            width: 300,
                            child: DropdownButton<String>(
                              isDense: true,
                              underline: Container(
                                height: 0,
                              ),
                              hint: Text("Машина"),
                              style: TextStyle(fontSize: 20),
                              isExpanded: true,
                              dropdownColor: Colors.green,
                              items: <String>['A', 'B', 'C', 'D']
                                  .map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.black,
                                )),
                            padding: EdgeInsets.only(top: 10, left: 25),
                            height: 50,
                            width: 300,
                            child: DropdownButton<String>(
                              isDense: true,
                              underline: Container(
                                height: 0,
                              ),
                              hint: Text("Дата"),
                              style: TextStyle(fontSize: 20),
                              isExpanded: true,
                              dropdownColor: Colors.green,
                              items: <String>['A'].map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (_) {},
                              onTap: () => _selectDate(context),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  width: 2.0,
                                  style: BorderStyle.solid,
                                  color: Colors.black,
                                )),
                            padding: EdgeInsets.only(top: 10, left: 25),
                            height: 50,
                            width: 300,
                            child: DropdownButton<String>(
                              isDense: true,
                              underline: Container(
                                height: 0,
                              ),
                              hint: Text("Время"),
                              style: TextStyle(fontSize: 20),
                              isExpanded: true,
                              dropdownColor: Colors.green,
                              items: <String>['A', 'B', 'C', 'D']
                                  .map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (_) {},
                              onTap: _show,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 55)),
                              Flexible(
                                flex: 7,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        width: 2.0,
                                        style: BorderStyle.solid,
                                        color: Colors.black,
                                      )),
                                  padding: EdgeInsets.only(top: 10, left: 25),
                                  height: 50,
                                  child: DropdownButton<String>(
                                    isDense: true,
                                    underline: Container(
                                      height: 0,
                                    ),
                                    hint: Text("Услуги"),
                                    style: TextStyle(fontSize: 20),
                                    isExpanded: true,
                                    dropdownColor: Colors.green,
                                    items: <String>['A', 'B', 'C', 'D']
                                        .map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (_) {},
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Flexible(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: IconButton(
                                    icon: const Icon(Icons.add_outlined),
                                    color: Colors.white,
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(15))),
                            child: Text("Добавить",
                                style: TextStyle(fontSize: 22)),
                            onPressed: () {
                              print("Clicked");
                            },
                          ),
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
