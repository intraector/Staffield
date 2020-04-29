import 'dart:async';
import 'dart:io';

import 'package:Staffield/services/sqlite/sqlite_fields.dart';
import 'package:path/path.dart';
import 'package:print_color/print_color.dart';
import 'package:sqflite/sqflite.dart';
import 'package:Staffield/constants/app_settings.dart';
import 'package:Staffield/services/sqlite/sqlite_tables.dart';

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
              ${SqliteFieldsEntries.id} INTEGER PRIMARY KEY,
              ${SqliteFieldsEntries.uid} TEXT UNIQUE,
              ${SqliteFieldsEntries.timestamp} INTEGER,
              ${SqliteFieldsEntries.employeeUid} TEXT,
              ${SqliteFieldsEntries.total} REAL,
              ${SqliteFieldsEntries.revenue} REAL,
              ${SqliteFieldsEntries.wage} REAL,
              ${SqliteFieldsEntries.interest} REAL
            )''');

//-----------------------------------------
  Future<void> createPenaltiesTable(Database db) => db.execute('''
            CREATE TABLE IF NOT EXISTS ${SqliteTable.penalties} (
              ${SqliteFieldsPenalties.id} INTEGER PRIMARY KEY,
              ${SqliteFieldsPenalties.uid} TEXT,
              ${SqliteFieldsPenalties.parentUid} TEXT,
              ${SqliteFieldsPenalties.type} TEXT,
              ${SqliteFieldsPenalties.timestamp} INTEGER,
              ${SqliteFieldsPenalties.total} REAL,
              ${SqliteFieldsPenalties.time} REAL,
              ${SqliteFieldsPenalties.money} REAL
            )''');

//-----------------------------------------
  Future<void> createEmployeesTable(Database db) => db.execute('''
            CREATE TABLE IF NOT EXISTS ${SqliteTable.employees} (
              ${SqliteFieldsEmployees.id} INTEGER PRIMARY KEY,
              ${SqliteFieldsEmployees.uid} TEXT,
              ${SqliteFieldsEmployees.name} TEXT,
              ${SqliteFieldsEmployees.hide} INTEGER NOT NULL
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
