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

  void scheduleAtThisTime(int id, DateTime nextDate) async {
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
      await scheduleNotification(id, nextDate);
    }
  }

  Future<void> scheduleNotification(int id, DateTime nextDate) async {
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
