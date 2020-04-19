import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:staff_time/constants/app_settings.dart';
import 'package:staff_time/constants/sqlite_tables.dart';

class SrvcSqliteInit {
  Future<void> init() async {
    var _completer = Completer();
    initComplete = _completer.future;
    path = await getDatabasesPath();
    path = join(path, 'chats.db');
    // await deleteDb();
    dbEntries = await openDb(path);
    _completer.complete();
  }

  Future<void> initComplete;
  Database dbEntries;
  String path;

  //-----------------------------------------
  Future<void> deleteDb() async {
    if (dbEntries != null) {
      await dbEntries.close();
      dbEntries = null;
    }
    if (await File(path).exists())
      return File(path).delete();
    else
      return Future.value(null);
  }

  //-----------------------------------------
  Future<void> createEntriesTable(Database db) => db.execute('''
            CREATE TABLE IF NOT EXISTS ${SqliteTable.entries} (
              id INTEGER PRIMARY KEY,
              uid TEXT UNIQUE,
              timestamp INTEGER,
              name TEXT,
              revenue REAL,
              wage REAL,
              interest REAL
            )''');

//-----------------------------------------
  Future<void> createPenaltiesTable(Database db) => db.execute('''
            CREATE TABLE IF NOT EXISTS ${SqliteTable.penalties} (
              id INTEGER PRIMARY KEY,
              uid TEXT,
              parentUID TEXT,
              type TEXT,
              total REAL,
              minutes INTEGER,
              money INTEGER
            )''');

//-----------------------------------------
  Future<Database> openDb(String path) => openDatabase(
        path,
        version: AppSettings.appVersionInt,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        singleInstance: true,
      );

//-----------------------------------------
  Future<void> _onCreate(Database db, int version) async {
    await createEntriesTable(db);
    await createPenaltiesTable(db);
    return null;
  }

//-----------------------------------------
  Future<void> _onUpgrade(Database db, int _oldVersion, int _newVersion) {
    return null;
  }
}
