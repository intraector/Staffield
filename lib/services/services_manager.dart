import 'package:Staffield/services/sqlite/srvc_sqlite_init.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ServicesManager {
  ServicesManager() {
    var sqlite = getIt<SrvcSqliteInit>();
    sqlite.init();
  }
}
