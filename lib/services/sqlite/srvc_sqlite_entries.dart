import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:Staffield/services/sqlite/sqlite_tables.dart';
import 'package:Staffield/core/exceptions/e_insert_entry.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_init.dart';

final getIt = GetIt.instance;

class SrvcSqliteEntries {
  SrvcSqliteEntries() {
    final init = getIt<SrvcSqliteInit>();
    initComplete = init.initComplete;
    initComplete.whenComplete(() {
      dbEntries = init.db;
    });
  }

  Future<void> initComplete;
  Database dbEntries;

  //-----------------------------------------
  Future<List<Map<String, dynamic>>> fetchEntries({int start, int end}) async {
    String whereClause;
    var whereArgs;
    String whereStart = ' timestamp > ?';
    String whereEnd = ' timestamp < ?';
    if (start != null && end != null) {
      whereClause = '$whereStart AND $whereEnd';
      whereArgs = [start, end];
    } else {
      if (start != null) {
        whereClause = whereStart;
        whereArgs = [start];
      }
      if (end != null) {
        whereClause = whereEnd;
        whereArgs = [end];
      }
    }
    await initComplete;
    return dbEntries.query(SqliteTable.entries,
        where: whereClause, whereArgs: whereArgs, orderBy: 'timestamp DESC');
  }

  //-----------------------------------------
  Future<List<Map<String, dynamic>>> fetchPenalties() async {
    await initComplete;
    return dbEntries.query(SqliteTable.penalties);
  }

  //-----------------------------------------
  Future<bool> addOrUpdate(
      {@required Map<String, dynamic> entry,
      @required Iterable<Map<String, dynamic>> penalties}) async {
    await initComplete;
    var batch = dbEntries.batch();
    batch.insert(SqliteTable.entries, entry, conflictAlgorithm: ConflictAlgorithm.replace);
    for (var penalty in penalties)
      batch.insert(SqliteTable.penalties, penalty, conflictAlgorithm: ConflictAlgorithm.replace);
    var results = await batch.commit();
    if (results.any((result) => result <= 0)) throw EInsertEntry('Can\'t insert SrvcSqliteEntries');
    return true;
  }

  //-----------------------------------------
  Future<void> remove(String uid) async {
    await initComplete;
    dbEntries.delete(
      SqliteTable.entries,
      where: 'uid = ?',
      whereArgs: [uid],
    );
    dbEntries.delete(
      SqliteTable.penalties,
      where: 'parentUid = ?',
      whereArgs: [uid],
    );
  }
}
