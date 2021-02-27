import 'package:ForLingo/db/interact_with_db.dart';
import 'package:ForLingo/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:ForLingo/home/components/data/week.dart';
import 'package:ForLingo/home/components/data/month.dart';
import 'package:ForLingo/home/components/data/year.dart';
import 'package:ForLingo/db/database_creator.dart';
import 'package:ForLingo/notification/notify.dart' as notify;
import 'package:ForLingo/home/components/bottom_nav_bar/bookmark/bookmark.dart';
import 'package:ForLingo/models/vocabs_interface.dart' as vs;
import 'package:ForLingo/db/statistic_database_creator.dart';

String initRoute = '/';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StatDBCreator().initDB();
  await DatabaseCreator().initDB();
  bool goThroughNotification =
      await notify.notifyCenter.appLaunchNotification();
  if (goThroughNotification) {
    initRoute = FlashCardFuture.routeName;
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  clicking() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => FlashCardFuture(),
      ),
    ).then((_) {
      setState(() {
        vs.future = DBInteract.getAllVocabs();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    notify.notifyCenter.actionWhenUserClickNotification = clicking;
    notify.notifyCenter.initializing();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      initialRoute: initRoute,
      routes: {
        '/': (context) => HomeScreen(),
        '/week': (context) => WeekData(),
        '/month': (context) => MonthData(),
        '/year': (context) => YearData(),
        '/bookmark': (_) => FlashCardFuture(),
      },
    );
  }
}
