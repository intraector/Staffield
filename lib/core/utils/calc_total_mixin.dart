import 'package:Staffield/core/models/penalty.dart';
import 'package:flutter/foundation.dart';

class CalcTotal {
  CalcTotalResult calcTotalAndBonus({
    @required double revenue,
    @required double interest,
    @required double wage,
    @required List<Penalty> penalties,
  }) {
    var result = CalcTotalResult();
    result.penaltiesTotal = penalties.fold<double>(0, (value, penalty) => value + penalty.total);

    result.bonus = revenue * interest / 100;
    result.total = (wage + result.bonus - result.penaltiesTotal).roundToDouble();
    return result;
  }
}

class CalcTotalResult {
  double total;
  double bonus;
  double penaltiesTotal;
}
