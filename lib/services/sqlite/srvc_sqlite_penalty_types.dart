import 'package:Staffield/core/exceptions/e_insert_penalty_type.dart';
import 'package:Staffield/services/sqlite/sqlite_fields.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:Staffield/services/sqlite/sqlite_tables.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_init.dart';

class SrvcSqlitePenaltyTypes {
  SrvcSqlitePenaltyTypes() {
    final init = Get.find<SrvcSqliteInit>();
    initComplete = init.initComplete;
    initComplete.whenComplete(() {
      db = init.db;
    });
  }

  Future<void> initComplete;
  Database db;

  //-----------------------------------------
  Future<List<Map<String, dynamic>>> fetch() async {
    await initComplete;
    return db.query(SqliteTable.penaltyTypes);
  }

  //-----------------------------------------
  Future<bool> addOrUpdate(Map<String, dynamic> type) async {
    await initComplete;
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
    await initComplete;
    return db.update(
      SqliteTable.penaltyTypes,
      {SqliteFieldsPenaltyTypes.hide: hide ? 1 : 0},
      where: '${SqliteFieldsPenaltyTypes.id} = ?',
      whereArgs: [uid],
    );
  }
}
