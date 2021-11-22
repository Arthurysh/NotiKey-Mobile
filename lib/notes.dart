// ignore: file_names
// ignore_for_file: unnecessary_this, file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notikey/Actions/slidable_widget.dart';
import 'package:notikey/Entity/note.dart';
import 'package:notikey/Entity/note_status.dart';
import 'package:notikey/Entity/service.dart';
import 'package:notikey/Services/connect_controller.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';

class Notes extends StatefulWidget {
  late int userId;

  Notes(userId) {
    this.userId = userId;
  }

  @override
  _NotesState createState() => _NotesState(userId);
}

class _NotesState extends State<Notes> {
  late int userId;
  _NotesState(userId) {
    this.userId = userId;
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
                    'Записи',
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
                      margin: EdgeInsets.only(bottom: 10),
                      height: 450,
                      child: ListSidableWidget(userId),
                    ),
                    true,
                    false)
                // BottomNavigate(false, true),
              ],
            ),
          )
        ],
      ),
      // body: ListSidableWidget(userId),
    );
  }
}

class NoteBlock extends StatelessWidget {
  late String name;
  late String status;
  late String services;
  late String car;
  late String station;
  late String date;
  late String time;
  late Color noteColor;

  NoteBlock(name, status, List<Service> services, car, station, date, time,
      noteColor) {
    this.name = name;
    this.status = status;
    this.services = convertNoteServicesToString(services);
    this.car = car;
    this.station = station;
    this.date = date.toString().split('-').reversed.join('.');
    this.time = time;
    this.noteColor = noteColor;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: noteColor,
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
          padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  this.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Text(
                "Статус: $status",
                style: TextStyle(
                    color: Colors.grey[850], fontWeight: FontWeight.w600),
              ),
              Text(
                "Услуга: $services",
                style: TextStyle(
                    color: Colors.grey[850], fontWeight: FontWeight.w600),
              ),
              Text(
                "Машина: $car",
                style: TextStyle(
                    color: Colors.grey[850], fontWeight: FontWeight.w600),
              ),
              Text(
                "Станция: $station",
                style: TextStyle(
                    color: Colors.grey[850], fontWeight: FontWeight.w600),
              ),
              Text(
                "Дата: $date",
                style: TextStyle(
                    color: Colors.grey[850], fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "$time",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      onTap: () {
        print('Note');
      },
    );
  }

  String convertNoteServicesToString(List<Service> services) {
    String servicesString = '';

    print(services.length);
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

class ListSidableWidget extends StatefulWidget {
  late int userId;

  ListSidableWidget(int userId) {
    this.userId = userId;
  }

  @override
  _DismissibleListState createState() => _DismissibleListState(userId);
}

class _DismissibleListState extends State<ListSidableWidget> {
  late int userId;
  late List<Status> status = [];
  // bool reload = false;

  _DismissibleListState(int userId) {
    this.userId = userId;
  }

  @override
  Widget build(BuildContext context) {
    // the list of elements
    return FutureBuilder(
      future: getUserNotes(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // ignore: avoid_print
        if (snapshot.data == null) {
          return Container(
            child: Center(child: Text("Загрузка записей ...")),
          );
        } else {
          if (snapshot.data.length != 0) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Note item = snapshot.data[index];
                Color noteColor = Color.fromARGB(0, 0, 0, 0);
                for (var elem in this.status) {
                  if (item.status == elem.status) {
                    noteColor = hexToColor(elem.color);
                  }
                }
                return SlidableWidget(
                  child: NoteBlock(
                      item.name,
                      item.status,
                      item.services,
                      item.brand + " " + item.model,
                      item.stationName,
                      item.date,
                      item.time,
                      noteColor),
                  onDismissed: (action) {
                    setState(
                      () {
                        snapshot.data.removeAt(index);
                        deleteNote();
                      },
                    );
                  },
                );
              },
              padding:
                  (EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 30)),
            );
          } else {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    width: double.infinity,
                    height: 80,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.0,
                        style: BorderStyle.solid,
                        color: Color.fromRGBO(217, 218, 162, 1.0),
                      ),
                      color: Color.fromRGBO(254, 255, 214, 1.0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "У вас пока что нет записей",
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

  Future<List<Note>> getUserNotes() async {
    await getNoteStatus().then((value) => {this.status = value});
    ConnectController connect = ConnectController();
    List response = await connect.startGetMethod(
        'http://localhost:8000/api/notesInfo', {"userId": this.userId});

    List<Note> notesArr = [];
    int noteCount = 0;
    for (var note in response) {
      List<Service> services = [];
      List<Status> statusHistory = [];
      noteCount++;

      for (var service in note['services']) {
        services.add(
          Service(service['servicesId'], service['name'], service['price']),
        );
      }

      for (var status in note['statusHistory']) {
        statusHistory.add(Status(null, status['status'], null));
      }

      notesArr.add(
        Note(
            note['noteId'],
            'Запись $noteCount',
            note['date'],
            note['time'],
            note['additionServices'],
            note['brand'],
            note['model'],
            statusHistory,
            note['status'],
            note['stationName'],
            note['adress'],
            note['description'],
            services),
      );
    }

    return notesArr;
  }

  Future<List<Status>> getNoteStatus() async {
    ConnectController connect = ConnectController();
    List response =
        await connect.startGetMethod('http://localhost:8000/api/getStatus', {});

    List<Status> statusArr = [];

    for (var status in response) {
      statusArr.add(Status(status['id'], status['status'], status['color']));
    }

    return statusArr;
  }

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  deleteNote() {}
}
