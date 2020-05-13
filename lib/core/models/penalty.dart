import 'package:Staffield/services/sqlite/sqlite_fields.dart';
import 'package:flutter/foundation.dart';
import 'package:Staffield/core/models/penalty_mode.dart';
import 'package:uuid_type/uuid_type.dart';
import 'package:Staffield/utils/string_utils.dart';

class Penalty {
  Penalty({@required this.parentUid, @required this.typeUid});

  //-----------------------------------------
  Penalty.fromOther(Penalty penalty) {
    uid = penalty.uid;
    parentUid = penalty.parentUid;
    mode = penalty.mode;
    typeUid = penalty.typeUid;
    timestamp = penalty.timestamp;
    total = penalty.total;
    if (penalty.mode == PenaltyMode.calc) {
      unit = penalty.unit;
      cost = penalty.cost;
    }
  }

  //-----------------------------------------
  Penalty.fromSqlite(Map<String, dynamic> json) {
    uid = json[SqliteFieldsPenalties.uid];
    parentUid = json[SqliteFieldsPenalties.parentUid];
    mode = json[SqliteFieldsPenalties.mode];
    typeUid = json[SqliteFieldsPenalties.typeId];
    timestamp = json[SqliteFieldsPenalties.timestamp];
    total = json[SqliteFieldsPenalties.total];
    if (mode == PenaltyMode.calc) {
      unit = json[SqliteFieldsPenalties.unit];
      cost = json[SqliteFieldsPenalties.cost];
    }
  }

  double cost;
  String mode;
  String parentUid = '';
  int timestamp;
  double total;
  String typeUid;
  String uid = TimeBasedUuidGenerator().generate().toString();
  double unit;

  //-----------------------------------------
  @override
  String toString() {
    return '$total mode: $mode typeUid: $typeUid parentUid: $parentUid ';
  }

  //-----------------------------------------
  Map<String, dynamic> toSqlite() {
    var result = {
      SqliteFieldsPenalties.uid: uid,
      SqliteFieldsPenalties.parentUid: parentUid,
      SqliteFieldsPenalties.mode: mode,
      SqliteFieldsPenalties.typeId: typeUid,
      SqliteFieldsPenalties.timestamp: timestamp ?? DateTime.now().millisecondsSinceEpoch,
      SqliteFieldsPenalties.total: total,
    };
    if (this.mode == PenaltyMode.calc) {
      result[SqliteFieldsPenalties.unit] = unit;
      result[SqliteFieldsPenalties.cost] = cost;
    }
    return result;
  }

  //-----------------------------------------
  PenaltyReport get report => PenaltyReport.from(this);
}

class PenaltyReport {
  PenaltyReport.from(Penalty penalty) {
    total = penalty.total.toString().formatInt;
    if (penalty.unit != 0) {
      time = penalty.unit.toString().formatInt;
    } else
      time = '';
    cost = penalty.cost?.toString()?.formatInt ?? '';
  }

  String cost;
  String time;
  String total;
}
