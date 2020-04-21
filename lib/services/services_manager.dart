import 'package:Staffield/services/sqlite/srvc_sqlite_init.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class ServicesManager {
  ServicesManager() {
    var sqlite = Injector.get<SrvcSqliteInit>();
    sqlite.init();
  }
}
