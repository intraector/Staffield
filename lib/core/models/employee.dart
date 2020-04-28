import 'package:Staffield/services/sqlite/sqlite_fields.dart';
import 'package:uuid_type/uuid_type.dart';

class Employee {
  Employee({uid, this.name = '', this.hide = false})
      : this.uid = uid ?? TimeBasedUuidGenerator().generate().toString();
  String uid;
  String name;
  bool hide;

  //-----------------------------------------
  Employee.fromSqlite(Map<String, dynamic> json) {
    uid = json[SqliteFieldsEmployees.uid];
    name = json[SqliteFieldsEmployees.name];
    hide = json[SqliteFieldsEmployees.hide] == 1 ? true : false;
  }

  //-----------------------------------------
  Map<String, dynamic> toSqlite() {
    return {
      SqliteFieldsEmployees.uid: uid,
      SqliteFieldsEmployees.name: name,
      SqliteFieldsEmployees.hide: hide ? 1 : 0,
    };
  }

  @override
  String toString() => '$uid $name $hide';
}
