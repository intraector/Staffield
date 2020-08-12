import 'package:Staffield/services/sqlite/sqlite_fields.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid_type/uuid_type.dart';
import 'package:Staffield/utils/string_utils.dart';

class Penalty {
  Penalty({@required this.parentUid, @required this.typeUid, this.mode});

  //-----------------------------------------
  Penalty.fromOther(Penalty penalty) {
    uid = penalty.uid;
    parentUid = penalty.parentUid;
    mode = penalty.mode;
    typeUid = penalty.typeUid;
    timestamp = penalty.timestamp;
    total = penalty.total;
    units = penalty.units;
    cost = penalty.cost;
  }

  //-----------------------------------------
  Penalty.fromSqlite(Map<String, dynamic> json) {
    uid = json[SqliteFieldsPenalties.uid];
    parentUid = json[SqliteFieldsPenalties.parentUid];
    mode = json[SqliteFieldsPenalties.mode];
    typeUid = json[SqliteFieldsPenalties.typeId];
    timestamp = json[SqliteFieldsPenalties.timestamp];
    total = json[SqliteFieldsPenalties.total];
    units = json[SqliteFieldsPenalties.unit];
    cost = json[SqliteFieldsPenalties.cost];
  }

  double cost;
  String mode;
  String parentUid = '';
  int timestamp;
  double total;
  String typeUid;
  String uid = TimeBasedUuidGenerator().generate().toString();
  double units;

  //-----------------------------------------
  @override //typeUid: $typeUid,
  String toString() {
    return 'mode: $mode, total: $total, units: $units, cost: $cost';
  }

  //-----------------------------------------
  Map<String, dynamic> toSqlite() => {
        SqliteFieldsPenalties.uid: uid,
        SqliteFieldsPenalties.parentUid: parentUid,
        SqliteFieldsPenalties.mode: mode,
        SqliteFieldsPenalties.typeId: typeUid,
        SqliteFieldsPenalties.timestamp: timestamp ?? DateTime.now().millisecondsSinceEpoch,
        SqliteFieldsPenalties.total: total,
        SqliteFieldsPenalties.unit: units,
        SqliteFieldsPenalties.cost: cost,
      };

  //-----------------------------------------
  PenaltyStrings get strings => PenaltyStrings.from(this);
}

class PenaltyStrings {
  PenaltyStrings.from(Penalty penalty) {
    typeUid = penalty.typeUid;
    units = penalty.units?.toString()?.formatDouble?.noDotZero ?? '';
    total = penalty.total.toString().formatDouble.noDotZero;
  }

  String typeUid;
  String units;
  String total;
  String typeTitle;
  String unitTitle;
}
