import 'package:Staffield/services/sqlite/prepare_query.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:print_color/print_color.dart';
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
  Future<List<Map<String, dynamic>>> fetchEntries({int start, int end, String employeeUid}) async {
    var preparedString = PrepareQuery.forEntries(start: start, end: end, employeeUid: employeeUid);
    await initComplete;
    return dbEntries.rawQuery(preparedString.string);
  }

  //-----------------------------------------
  Future<List<Map<String, dynamic>>> fetchPenalties({int start, int end, String parentUid}) async {
    var preparedString = PrepareQuery.forPenalties(start: start, end: end, parentUid: parentUid);
    await initComplete;
    return dbEntries.rawQuery(preparedString.string);
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
