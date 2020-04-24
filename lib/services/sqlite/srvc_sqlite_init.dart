import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:print_color/print_color.dart';
import 'package:sqflite/sqflite.dart';
import 'package:Staffield/constants/app_settings.dart';
import 'package:Staffield/constants/sqlite_tables.dart';

class SrvcSqliteInit {
  Future<void> init() async {
    var _completer = Completer();
    initComplete = _completer.future;
    path = await getDatabasesPath();
    path = join(path, 'drrb.db');
    // await deleteDb();
    db = await openDb(path);
    Print.magenta('||| db $db');

    _completer.complete();
  }

  Future<void> initComplete;
  Database db;
  String path;

  //-----------------------------------------
  Future<void> deleteDb() async {
    if (db != null) {
      await db.close();
      db = null;
    }
    Print.magenta('||| db $db');
    if (await File(path).exists()) {
      Print.magenta('||| db   $path exists');
      return File(path).delete();
    } else {
      Print.magenta('||| db   $path not exists');
      return Future.value(null);
    }
  }

  //-----------------------------------------
  Future<void> createEntriesTable(Database db) => db.execute('''
            CREATE TABLE IF NOT EXISTS ${SqliteTable.entries} (
              id INTEGER PRIMARY KEY,
              uid TEXT UNIQUE,
              timestamp INTEGER,
              employeeUid TEXT,
              total REAL,
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
  Future<void> createEmployeesTable(Database db) => db.execute('''
            CREATE TABLE IF NOT EXISTS ${SqliteTable.employees} (
              id INTEGER PRIMARY KEY,
              uid TEXT,
              name TEXT,
              hide INTEGER NOT NULL
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
    Print.blue('||| fired _onCreate');
    await createEntriesTable(db);
    await createPenaltiesTable(db);
    await createEmployeesTable(db);
    return null;
  }

//-----------------------------------------
  Future<void> _onUpgrade(Database db, int _oldVersion, int _newVersion) {
    return null;
  }
}
