import 'package:notikey/Entity/note_status.dart';
import 'package:notikey/Entity/service.dart';

class Note {
  late int id;
  late String name;
  late String date;
  late String time;
  late List<Service> additionServices;
  late String brand;
  late String model;
  late List<Status> statusHistory;
  late String status;
  late String stationName;
  late String adress;
  late String description;
  late List<Service> services;

  Note(
    this.id,
    this.name,
    this.date,
    this.time,
    this.additionServices,
    this.brand,
    this.model,
    this.statusHistory,
    this.status,
    this.stationName,
    this.adress,
    this.description,
    this.services,
  );
}
