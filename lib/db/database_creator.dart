/*
 *  This file create a database called `lingo`
 *  In this db, there is a table called `words`
 *  Having the following schema is a must:
 *  id             | word     | meaning  | sentence
 *  INTEGER        | TEXT     | TEXT     | TEXT
 *  PRIMARY KEY    | NOT NULL | NOT NULL | NOT NULL
 */

import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Database db;

class DatabaseCreator {
  static const tableName = 'words';
  static const id = 'id';
  static const word = 'word';
  static const meaning = 'meaning';
  static const sentence = 'sentence';
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';

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

  Future<void> createWordTable(Database db) async {
    final sql = '''
    CREATE TABLE IF NOT EXISTS $tableName (
      $id INTEGER PRIMARY KEY,
      $word TEXT NOT NULL,
      $meaning TEXT,
      $sentence TEXT
      $createdAt TEXT,
      $updatedAt TEXT,
    )
    ''';
    await db.execute(sql);
  }

  Future<String> getDBPath(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    if (await Directory(dirname(path)).exists()) {
      //await deleteDatabase(path);
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }

    return path;
  }

  Future<void> initDB() async {
    final path = await getDBPath('lingo');
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    print(db);
  }

  Future<void> onCreate(Database db, int version) async {
    await createWordTable(db);
  }
}
