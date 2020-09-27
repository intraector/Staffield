import 'package:Staffield/core/exceptions/e_insert_penalty_type.dart';
import 'package:Staffield/services/sqlite/sqlite_fields.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:Staffield/services/sqlite/sqlite_tables.dart';

class PenaltyTypesSqliteSrvc {
  Database db;

  //-----------------------------------------
  Future<List<Map<String, dynamic>>> fetch() async {
    return db.query(SqliteTable.penaltyTypes);
  }

  //-----------------------------------------
  Future<bool> addOrUpdate(Map<String, dynamic> type) async {
    var result = await db.insert(SqliteTable.penaltyTypes, type,
        conflictAlgorithm: ConflictAlgorithm.replace);
    if (result <= 0) throw EInsertPenaltyType('Can\'t insert SrvcSqlitePenaltyTypes');
    return true;
  }

  //-----------------------------------------
  // Future<int> remove(int id) async {
  //   await initComplete;
  //   return db.delete(
  //     SqliteTable.penaltyTypes,
  //     where: '${SqliteFieldsPenaltyTypes.id} = ?',
  //     whereArgs: [id],
  //   );
  // }

  //-----------------------------------------
  Future<int> hideUnhide({@required String uid, @required bool hide}) async {
    return db.update(
      SqliteTable.penaltyTypes,
      {SqliteFieldsPenaltyTypes.hide: hide ? 1 : 0},
      where: '${SqliteFieldsPenaltyTypes.id} = ?',
      whereArgs: [uid],
    );
  }
}
