import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'statistic_database_helper.dart';

/*
 *  This file create a database called `lingoStat`
 *  In this db, there is a table called `statistics`
 *  Having the following schema is a must:
 *  id            | type        | key       | remember        | vocabs
 *  INTEGER       | INTEGER     | INTEGER   | INTEGER         | INTEGER
 *  PRIMARY KEY   | NOT NULL    | NOT NULL  | NOT NULL        | NOT NULL
 * This table always have 24 rows and allow querying and updating only
 *  time unit   | type       | key
 *  day             0           1-7(Mon to Sun)
 *  week            1           1-5(week1 to 5)
 *  month           2           1-12 (Jan to Dec)
 *  year            3           1(current year)
 */
Database db1;

class StatDBCreator {
  static const tableName = 'stats';
  static const id = 'id';
  static const type = 'type';
  static const key = 'key';
  static const remember = 'remember';
  static const vocabs = 'vocabs';
  static const temp = 'temp';
  static void databaseLog(String functionName, String sql,
      [List<Map<String, dynamic>> selectQueryResult,
      int insertAndUpdateResult,
      List<dynamic> params]) {
    print(functionName);
    print(sql);
    if (params != null) {
      print(params);
    }

    if (selectQueryResult != null) {
      print(selectQueryResult);
    } else if (insertAndUpdateResult != null) {
      print(insertAndUpdateResult);
    }
  }

  Future<void> createStatTable(Database db) async {
    final sql = '''
    CREATE TABLE IF NOT EXISTS $tableName (
      $id INTEGER PRIMARY KEY,
      $type INT,
      $key INT,
      $remember INT,
      $vocabs INT
    )
      ''';
    await db.execute(sql);
  }

  Future<String> getDBPath(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    bool checkDir = await Directory(dirname(path)).exists();
    if (!checkDir) {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDB() async {
    final path = await getDBPath('lingoStat');
    bool checkExist = await databaseFactory.databaseExists(path);
    db1 = await openDatabase(path, version: 1, onCreate: onCreate);
    //if the database has just been created, initializes it with 25 rows.
    if (checkExist == false) {
      int cnt = 0;
      //Monday to Sunday
      for (int i = 1; i <= 7; i++) {
        StatDBInteract.insertToDB(cnt, 0, i, 0, 0);
        cnt++;
      }
      //Week1 to Week5
      for (int i = 1; i <= 5; i++) {
        StatDBInteract.insertToDB(cnt, 1, i, 0, 0);
        cnt++;
      }
      //Jan to Dec
      for (int i = 1; i <= 12; i++) {
        StatDBInteract.insertToDB(cnt, 2, i, 0, 0);
        cnt++;
      }
      //this year
      StatDBInteract.insertToDB(cnt, 3, 1, 0, 0);
//      DateTime currentTime = DateTime.now();
//      StatDBInteract.insertToDB(25, 4,currentTime.weekday, currentTime.day, currentTime.month,
//          currentTime.year);
    }
    print(db1);
    //StatDBInteract.printDB();
    return;
  }

  Future<void> onCreate(Database db, int version) async {
    await createStatTable(db);
  }
}
