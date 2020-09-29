import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entries_repository.dart';
import 'package:Staffield/core/penalty_types_repository.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_employees.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_entries.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_init.dart';
import 'package:Staffield/services/sqlite/penalty_types_sqlite_srvc.dart';
import 'package:get/get.dart';

class OrchestratorSrvc {
  OrchestratorSrvc() {
    initComplete = init();
  }
  Future initComplete;

  Future init() async {
    var sqlite = Get.find<SrvcSqliteInit>();
    await sqlite.init();
    Get.find<PenaltyTypesSqliteSrvc>().db = sqlite.db;
    await Get.find<PenaltyTypesRepository>().fetch();
    Get.find<EmployeesSqliteSrvc>().db = sqlite.db;
    await Get.find<EmployeesRepository>().fetch();
    Get.find<EntriesSqliteSrvc>().db = sqlite.db;
    Get.find<EntriesRepository>().fetchNextChunkToCache();
  }
}
