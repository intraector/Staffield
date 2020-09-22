import 'package:Staffield/core/entities/penalty.dart';
import 'package:flutter/foundation.dart';

class CalcTotal {
  double total;
  double bonus;
  double penaltiesTotal;

  CalcTotal({
    @required double revenue,
    @required double interest,
    @required double wage,
    @required List<Penalty> penalties,
  }) {
    penaltiesTotal = penalties.fold<double>(0, (value, penalty) => value + penalty.total);

    bonus = revenue * interest / 100;
    total = (wage + bonus - penaltiesTotal).roundToDouble();
  }
}
