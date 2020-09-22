import 'package:flutter/foundation.dart';
import 'package:uuid_type/uuid_type.dart';
import 'package:Staffield/utils/string_utils.dart';

class Penalty {
  Penalty({@required this.parentUid, @required this.typeUid, this.mode});

  double cost;
  String mode;
  String parentUid = '';
  int timestamp;
  double total;
  String typeUid;
  String uid = TimeBasedUuidGenerator().generate().toString();
  double units;

  //-----------------------------------------
  Penalty.copy(Penalty penalty) {
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
  @override
  String toString() {
    return 'mode: $mode, total: $total, units: $units, cost: $cost';
  }

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
