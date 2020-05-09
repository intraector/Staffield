import 'package:Staffield/services/sqlite/sqlite_fields.dart';
import 'package:uuid_type/uuid_type.dart';

class PenaltyType {
  PenaltyType();
  String uid = TimeBasedUuidGenerator().generate().toString();
  String mode;
  String title = '';
  String unitTitle = '';
  double unitDefaultValue = 0.0;
  double costDefaultValue = 0.0;
  bool hide = false;

  Map<String, dynamic> get toSqlite => {
        SqliteFieldsPenaltyTypes.uid: uid,
        SqliteFieldsPenaltyTypes.mode: mode,
        SqliteFieldsPenaltyTypes.title: title,
        SqliteFieldsPenaltyTypes.unitTitle: unitTitle,
        SqliteFieldsPenaltyTypes.unitDefaultValue: unitDefaultValue,
        SqliteFieldsPenaltyTypes.costDefaultValue: costDefaultValue,
        SqliteFieldsPenaltyTypes.hide: hide ? 1 : 0,
      };

  PenaltyType.fromSqlite(Map<String, dynamic> map) {
    uid = map[SqliteFieldsPenaltyTypes.uid];
    mode = map[SqliteFieldsPenaltyTypes.mode];
    title = map[SqliteFieldsPenaltyTypes.title];
    unitTitle = map[SqliteFieldsPenaltyTypes.unitTitle];
    unitDefaultValue = map[SqliteFieldsPenaltyTypes.unitDefaultValue];
    costDefaultValue = map[SqliteFieldsPenaltyTypes.costDefaultValue];
    hide = map[SqliteFieldsPenaltyTypes.hide] == 0 ? false : true;
  }

  PenaltyType get clone => PenaltyType()
    ..uid = uid
    ..mode = mode
    ..title = title
    ..unitTitle = unitTitle
    ..unitDefaultValue = unitDefaultValue
    ..costDefaultValue = costDefaultValue
    ..hide = hide;

  @override
  String toString() {
    return 'id: $uid, mode: $mode, title:$title, unitTitle: $unitTitle, hide: $hide';
  }
}
