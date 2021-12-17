import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notikey/Actions/slidable_widget.dart';
import 'package:notikey/Entity/notification.dart';
import 'package:notikey/Services/connect_controller.dart';
import 'package:notikey/UI/swipe_bottom_block.dart';

class Notifications extends StatefulWidget {
  late int userId;
  Notifications(this.userId, {Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState(userId);
}

class _NotificationsState extends State<Notifications> {
  late int userId;

  FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    initializeNoticationSetting();
    super.initState();
  }

  void initializeNoticationSetting() async {
    var initializeIOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    var initializeSettings = InitializationSettings(iOS: initializeIOS);
    await notificationPlugin.initialize(initializeSettings);
  }

  Future<void> displayNotification() async {
    notificationPlugin.show(1, 'Test', 'Content First Notification',
        NotificationDetails(iOS: IOSNotificationDetails(subtitle: 'rrrr')));
  }

  _NotificationsState(this.userId);
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
                  'Уведомления',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       this.displayNotification();
              //     },
              //     child: Text('test')),
              SwipeBottomBlock(
                  Container(
                    height: 420,
                    child: ListSidableWidget(userId),
                  ),
                  false,
                  true,
                  'Notifications',
                  userId)
              // BottomNavigate(false, true),
            ],
          )
        ],
      ),
    );
  }
}

class NotificationBlock extends StatelessWidget {
  late Notifi notificationObj;
  late int userId;

  NotificationBlock(this.notificationObj, this.userId, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(238, 239, 255, 1),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  notificationObj.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.notifications,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    child: Expanded(
                      child: Text(
                        notificationObj.content,
                        style: TextStyle(),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    notificationObj.time,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
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
      future: getUserNotification(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // ignore: avoid_print
        if (snapshot.data == null) {
          return const Center(child: Text("Загрузка уведомлений ..."));
        } else {
          if (snapshot.data.length != 0) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Notifi item = snapshot.data[index];

                return SlidableWidget(
                  child: NotificationBlock(
                      Notifi(item.notificationId, item.title, item.content,
                          item.time),
                      userId),
                  onDismissed: (action) {
                    setState(
                      () {
                        deleteNotification(snapshot.data[index].notificationId);
                      },
                    );
                  },
                );
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
                          "У вас пока что нет уведомлений",
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

  Future<List<Notifi>> getUserNotification() async {
    ConnectController connect = ConnectController();
    List response = await connect.startGetMethod(
        'http://localhost:8000/api/getNotificationUser', {"userId": userId});

    print(response);
    List<Notifi> notificationArr = [];

    for (var notification in response) {
      notificationArr.add(Notifi(
        notification["notificationId"],
        notification["title"],
        notification["content"],
        notification["time"],
      ));
    }

    // notificationArr.add(Notifi(
    //     1,
    //     'Изменения статус',
    //     'Статус вашей записи № 17 был изменен с "выполнение услуг" на "Готово к оплате, пожалуйста просмотрите вашу запись и оплатите)."',
    //     '12:00'));
    // notificationArr.add(Notifi(
    //     2,
    //     'Изменения статуса',
    //     'Статус вашей записи № 17 был изменен с "выполнение услуг" на "Готово к оплате, пожалуйста просмотрите вашу запись и оплатите)."',
    //     '14:00'));

    // Map noti = {
    //   'notificationId': 1,
    //   'title': 'Изменения статуса',
    //    'content': 'Статус вашей записи № 17 был изменен с "выполнение услуг" на "Готово к оплате, пожалуйста просмотрите вашу запись).',
    //    'time': '12:00',
    // };

    return notificationArr;
  }

  deleteNotification(notificationId) async {
    ConnectController connect = ConnectController();

    Map notificationIdObj = {
      'notificationId': notificationId,
    };
    await connect.startMethod(
        'http://localhost:8000/api/deleteNotificationUser', notificationIdObj);
  }
}
