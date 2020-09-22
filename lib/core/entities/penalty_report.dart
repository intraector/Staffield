import 'package:Staffield/core/entities/penalty.dart';
import 'package:Staffield/core/entities/penalty_mode.dart';
import 'package:Staffield/utils/string_utils.dart';

class PenaltyReport {
  PenaltyReport.from(Penalty penalty) {
    typeUid = penalty.typeUid;
    units = penalty.units;
    switch (penalty.mode) {
      case PenaltyMode.plain:
        {
          total = penalty.total;
        }
        break;
      case PenaltyMode.calc:
        {
          total = (penalty.units * penalty.cost);
        }
        break;
    }
  }

  PenaltyReport operator +(PenaltyReport other) {
    this.total += other.total;
    if (this.units != null && other.units != null) this.units += other.units;
    return this;
  }

  String typeUid;
  double units;
  double total;
  String typeTitle;
  String unitTitle;
  String get unitString => units?.toString()?.formatDouble?.noDotZero ?? '';
  String get totalString => total?.toString()?.formatDouble?.noDotZero ?? '';

  @override
  String toString() =>
      'typeUid : $typeUid, units : $units, total : $total, typeTitle : $typeTitle, unitTitle : $unitTitle, unitString : $unitString, totalString : $totalString ';
}
