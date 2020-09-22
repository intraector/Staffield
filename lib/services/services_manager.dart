import 'package:Staffield/services/sqlite/srvc_sqlite_init.dart';
import 'package:get/get.dart';

class ServicesManager {
  ServicesManager() {
    var sqlite = Get.find<SrvcSqliteInit>();
    sqlite.init();
  }
}
