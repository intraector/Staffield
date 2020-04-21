import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:Staffield/constants/sqlite_tables.dart';
import 'package:Staffield/core/entries_repository_interface.dart';
import 'package:Staffield/core/exceptions/e_insert_entry.dart';
import 'package:Staffield/models/entry.dart';
import 'package:Staffield/models/penalty.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_init.dart';

final getIt = GetIt.instance;

class SrvcSqliteEntries implements EntriesRepositoryInterface {
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
  Future<bool> addOrUpdate(Entry entry) async {
    await initComplete;
    if (entry.timestamp == null) entry.timestamp = DateTime.now().millisecondsSinceEpoch;
    var result = await dbEntries.insert(SqliteTable.entries, entry.toSqlite(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    if (result <= 0)
      throw EInsertEntry('Can\'t insert SrvcSqliteEntries');
    else
      return true;
  }

  //-----------------------------------------
  @override
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
