import 'package:sqflite/sqflite.dart';
import 'package:staff_time/constants/sqlite_tables.dart';
import 'package:staff_time/core/exceptions/e_insert.dart';
import 'package:staff_time/core/interface_entries_repository.dart';
import 'package:staff_time/models/entry.dart';
import 'package:staff_time/models/penalty.dart';
import 'package:staff_time/services/sqlite/srvc_sqlite_init.dart';

class SrvcSqliteApi implements InterfaceEntriesRepository {
  SrvcSqliteApi() {
    var init = SrvcSqliteInit();
    init.init();
    initComplete = init.initComplete;
    initComplete.whenComplete(() {
      dbEntries = init.dbEntries;
    });
  }

  Future<void> initComplete;
  Database dbEntries;

  //-----------------------------------------
  @override
  Future<List<Entry>> fetch() async {
    await initComplete;
    var entriesMaps = await dbEntries.query(SqliteTable.entries);
    var penaltiesFuture = dbEntries.query(SqliteTable.penalties);
    var result = entriesMaps.map((entryMap) => Entry.fromSqlite(entryMap)).toList();
    var penalties = (await penaltiesFuture).map((penaltyMap) => Penalty.fromSqlite(penaltyMap));
    for (var entry in result) {
      var foundPenalties = penalties.where((penalty) => penalty.parentUid == entry.uid).toList();
      entry.penalties = foundPenalties;
    }
    return result;
  }

  //-----------------------------------------
  @override
  Future<bool> add(Entry entry) async {
    if (entry.timestamp == null) entry.timestamp = DateTime.now().millisecondsSinceEpoch;
    var result = await dbEntries.insert(SqliteTable.entries, entry.toSqlite(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    if (result <= 0)
      throw EInsert('Can\'t insert SrvcSqliteApi');
    else
      return true;
  }

  //-----------------------------------------
  @override
  void remove(String uid) {
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

  //-----------------------------------------
  @override
  void update() {
    // TODO: implement update
  }
  //-----------------------------------------
// Map<String, dynamic>
}
