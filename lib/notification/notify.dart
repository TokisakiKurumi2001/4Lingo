import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotifyCenter {
  //ANCHOR: data preparation
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  Function actionWhenUserClickNotification;

  // initialize value
  Future<void> initializing() async {
    androidInitializationSettings = AndroidInitializationSettings('app_icon');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  //NOTE: when user click on the notification alert
  Future onSelectNotification(String payload) async {
    print("Hello World");
    if (payload != null) {
      print(payload);
    }
    actionWhenUserClickNotification();
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  //NOTE: this rarely appear, but need it to make things work
  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            print('Hello');
          },
          child: Text('Okay'),
        )
      ],
    );
  }

  void showNotificationAfterTime() async {
    await notificationAfterTime(1, 15);
  }

  void showAllNotification() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    List<int> ids = [1, 2, 3, 4];
    List<int> pendingIds = List();
    for (var d in pendingNotificationRequests) {
      pendingIds.add(d.id);
    }

    for (int id in ids) {
      if (!pendingIds.contains(id)) {
        await notificationAfterTime(id, id);
      }
    }
  }

  Future<void> notificationAfterTime(int id, int delayTime) async {
    tz.initializeTimeZones();
    final hcm = tz.getLocation('Asia/Ho_Chi_Minh');
    tz.TZDateTime scheduledDate =
        tz.TZDateTime.now(hcm).add(Duration(minutes: delayTime));
    DateTime d = DateTime.now();
    print("$scheduledDate $d");
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      '$id',
      '4Lingo',
      'Learning',
      priority: Priority.high,
      importance: Importance.max,
      ticker: 'ticker',
    );

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'Learning',
        'Time to revise your flashcards with group $id',
        scheduledDate,
        notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: '$id $scheduledDate');
  }

  Future<bool> appLaunchNotification() async {
    final NotificationAppLaunchDetails notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      return true;
    } else {
      return false;
    }
  }

  void listAll() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    for (var d in pendingNotificationRequests) {
      print(d.payload);
    }
  }

  void scheduleAtThisTime(int id, DateTime nextDate, String condition) async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    bool duplicate = false;
    for (var d in pendingNotificationRequests) {
      if (d.id == id) {
        duplicate = true;
        break;
      }
    }
    if (!duplicate) {
      await scheduleNotification(id, nextDate, condition);
    }
  }

  Future<void> scheduleNotification(
      int id, DateTime nextDate, String condition) async {
    tz.initializeTimeZones();
    final hcm = tz.getLocation('Asia/Ho_Chi_Minh');
    tz.TZDateTime scheduledDate = tz.TZDateTime.from(nextDate, hcm);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      '$id',
      '4Lingo',
      'Learning',
      priority: Priority.high,
      importance: Importance.max,
      ticker: 'ticker',
    );

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    await flutterLocalNotificationsPlugin.zonedSchedule(id, 'Learning',
        'Time to revise your flashcards', scheduledDate, notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}

NotifyCenter notifyCenter = NotifyCenter();
