import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entries_repository.dart';
import 'package:Staffield/core/penalty_types_repository.dart';
import 'package:Staffield/services/service_orchestrator.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_employees.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_entries.dart';
import 'package:Staffield/services/sqlite/entries_sqlite_adapter.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_init.dart';
import 'package:Staffield/services/sqlite/penalty_types_sqlite_srvc.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_penalty_types_adapter.dart';
import 'package:get/get.dart';

void serviceLocatorInit() {
  Get.put(SrvcSqliteInit());
  Get.put(PenaltyTypesSqliteSrvc());
  Get.put(PenaltyTypesAdapter());
  Get.put(PenaltyTypesRepository());
  Get.put(EmployeesSqliteSrvc());
  Get.put(EmployeesRepository());
  Get.put(EntriesSqliteSrvc());
  Get.put(EntriesSqliteAdapater());
  Get.put(EntriesRepository());
  Get.put(ServiceOrchestrator());
}
