import 'package:Staffield/core/models/penalty.dart';
import 'package:flutter/foundation.dart';

class CalcTotal {
  CalcTotalResult calcTotalAndBonus({
    @required double revenue,
    @required double interest,
    @required double wage,
    @required List<Penalty> penalties,
  }) {
    var totalPenalties = penalties.fold<double>(0, (value, penalty) => value + penalty.total);
    var result = CalcTotalResult();
    result.penaltiesTotal = revenue * interest / 100;
    result.total = (wage + result.penaltiesTotal - totalPenalties).roundToDouble();
    return result;
  }
}

class CalcTotalResult {
  double total;
  double penaltiesTotal;
}
