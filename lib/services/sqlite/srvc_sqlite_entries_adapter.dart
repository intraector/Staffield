import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entries_repository_interface.dart';
import 'package:Staffield/core/entities/entry.dart';
import 'package:Staffield/services/sqlite/sqlite_convert.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_entries.dart';
import 'package:get/get.dart';

class SqliteEntriesAdapater implements EntriesRepositoryInterface {
  var _srvcSqliteEntries = SrvcSqliteEntries();
  var _employeesRepo = Get.find<EmployeesRepository>();

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
    var result = entriesMaps.map((entryMap) => SqliteConvert.mapToEntry(entryMap)).toList();
    var penalties =
        (await penaltiesFuture).map((penaltyMap) => SqliteConvert.mapToPenalty(penaltyMap));
    for (var entry in result) {
      var foundPenalties = penalties.where((penalty) => penalty.parentUid == entry.uid).toList();
      entry.penalties = foundPenalties;
      entry.employeeName = _employeesRepo.getEmployee(entry.employeeUid).name;
    }
    return result;
  }

  //-----------------------------------------
  Future<bool> addOrUpdate(List<Entry> entries) {
    var entriesMaps = <Map<String, dynamic>>[];
    var penaltiesMaps = <Map<String, dynamic>>[];
    for (var entry in entries) {
      entriesMaps.add(SqliteConvert.entryToMap(entry));
      penaltiesMaps.addAll(entry.penalties.map((penalty) => SqliteConvert.penaltyToMap(penalty)));
    }
    return _srvcSqliteEntries.addOrUpdate(entries: entriesMaps, penalties: penaltiesMaps);
  }

  //-----------------------------------------
  Future<void> remove(String uid) => _srvcSqliteEntries.remove(uid);
}
