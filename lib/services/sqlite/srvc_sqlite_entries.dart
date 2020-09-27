import 'package:Staffield/core/exceptions/e_insert_entry.dart';
import 'package:Staffield/services/sqlite/prepare_query.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:Staffield/services/sqlite/sqlite_tables.dart';

class EntriesSqliteSrvc {
  Database db;

  //-----------------------------------------
  Future<List<Map<String, dynamic>>> fetchEntries({
    @required int greaterThan,
    @required int lessThan,
    @required List<String> employeeUids,
    @required int limit,
  }) async {
    var preparedString = PrepareQuery.forEntries(
      greaterThan: greaterThan,
      lessThan: lessThan,
      employeeUids: employeeUids,
      limit: limit,
    );
    var result = db.rawQuery(preparedString.string);
    return result;
  }

  //-----------------------------------------
  Future<List<Map<String, dynamic>>> fetchPenalties({
    @required int greaterThan,
    @required int lessThan,
    @required String parentUid,
    @required int limit,
  }) async {
    var preparedString = PrepareQuery.forPenalties(
      greaterThan: greaterThan,
      lessThan: lessThan,
      parentUid: parentUid,
      limit: limit,
    );
    return db.rawQuery(preparedString.string);
  }

  //-----------------------------------------
  Future<bool> addOrUpdate(
      {@required Iterable<Map<String, dynamic>> entries,
      @required Iterable<Map<String, dynamic>> penalties}) async {
    var batch = db.batch();
    for (var entry in entries) {
      batch.insert(SqliteTable.entries, entry, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    for (var penalty in penalties) {
      batch.insert(SqliteTable.penalties, penalty, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    try {
      await batch.commit(noResult: true);
    } catch (e) {
      throw EInsertEntry('Can\'t insert SrvcSqliteEntries');
    }
    return true;
  }

  //-----------------------------------------
  Future<void> remove(String uid) async {
    db.delete(
      SqliteTable.entries,
      where: 'uid = ?',
      whereArgs: [uid],
    );
    db.delete(
      SqliteTable.penalties,
      where: 'parentUid = ?',
      whereArgs: [uid],
    );
  }
}
