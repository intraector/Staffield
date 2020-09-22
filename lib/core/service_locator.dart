import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entries_repository.dart';
import 'package:Staffield/core/penalty_types_repository.dart';
import 'package:Staffield/services/services_manager.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_employees.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_entries_adapter.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_init.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_penalty_types_adapter.dart';
import 'package:get/get.dart';

void serviceLocatorInit() {
  Get.put(SrvcSqliteInit());
  Get.put(ServicesManager());
  Get.put(PenaltyTypesRepository(SrvcSqlitePenaltyTypesAdapter()));
  Get.put(EmployeesRepository(SrvcSqliteEmployees()));
  Get.put(EntriesRepository(SqliteEntriesAdapater()));
}
