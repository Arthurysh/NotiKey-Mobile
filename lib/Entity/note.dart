import 'package:notikey/Entity/note_status.dart';
import 'package:notikey/Entity/service.dart';

class Note {
  late int id;
  late String name;
  late String date;
  late String time;
  late String additionServices;
  late String brand;
  late String model;
  late List<Status> statusHistory;
  late String status;
  late String stationName;
  late String adress;
  late String description;
  late List<Service> services;

  Note(
    id,
    name,
    date,
    time,
    additionServices,
    brand,
    model,
    statusHistory,
    status,
    stationName,
    adress,
    description,
    services,
  ) {
    this.id = id;
    this.name = name;
    this.date = date;
    this.time = time;
    this.additionServices = additionServices;
    this.brand = brand;
    this.model = model;
    this.statusHistory = statusHistory;
    this.stationName = stationName;
    this.status = status;
    this.adress = adress;
    this.description = description;
    this.services = services;
  }
}
