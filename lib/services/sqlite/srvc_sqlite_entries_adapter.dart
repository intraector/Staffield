import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entries_repository_interface.dart';
import 'package:Staffield/core/models/entry.dart';
import 'package:Staffield/core/models/penalty.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_entries.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class SqliteEntriesAdapater implements EntriesRepositoryInterface {
  var _srvcSqliteEntries = SrvcSqliteEntries();
  var _employeesRepo = getIt<EmployeesRepository>();

  //-----------------------------------------
  @override
  Future<List<Entry>> fetch({int greaterThan, int lessThan, String employeeUid, int limit}) async {
    var entriesMaps = await _srvcSqliteEntries.fetchEntries(
      greaterThan: greaterThan,
      lessThan: lessThan,
      employeeUid: employeeUid,
      limit: limit,
    );

    var penaltiesFuture = _srvcSqliteEntries.fetchPenalties(
      greaterThan: greaterThan,
      lessThan: lessThan,
      parentUid: null,
      limit: null,
    );
    var result = entriesMaps.map((entryMap) => Entry.fromSqlite(entryMap)).toList();
    var penalties = (await penaltiesFuture).map((penaltyMap) => Penalty.fromSqlite(penaltyMap));
    for (var entry in result) {
      var foundPenalties = penalties.where((penalty) => penalty.parentUid == entry.uid).toList();
      entry.penalties = foundPenalties;
      entry.employeeName = _employeesRepo.getEmployee(entry.employeeUid).name;
    }
    // Print.yellow('||| result : $result');
    return result;
  }

  //-----------------------------------------
  Future<bool> addOrUpdate(List<Entry> entries) {
    var entriesMaps = <Map<String, dynamic>>[];
    var penaltiesMaps = <Map<String, dynamic>>[];
    for (var entry in entries) {
      entriesMaps.add(entry.toSqlite());
      penaltiesMaps.addAll(entry.penalties.map((penalty) => penalty.toSqlite()));
    }
    return _srvcSqliteEntries.addOrUpdate(entries: entriesMaps, penalties: penaltiesMaps);
  }

  //-----------------------------------------
  Future<void> remove(String uid) => _srvcSqliteEntries.remove(uid);
}
