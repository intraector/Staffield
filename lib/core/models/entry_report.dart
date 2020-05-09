import 'package:Staffield/core/models/penalty_mode.dart';
import 'package:Staffield/core/utils/calc_total_mixin.dart';
import 'package:Staffield/core/models/entry.dart';

class EntryReport extends Entry with CalcTotal {
  EntryReport();
  EntryReport.fromEntry(Entry entry) {
    uid = entry.uid;
    employeeNameAux = entry.employeeNameAux;
    revenue = entry.revenue;
    interest = entry.interest;
    bonusAux = revenue * interest / 100;
    wage = entry.wage;
    penalties = entry.penalties;
    penaltyUnit = 0;
    timestamp = entry.timestamp;

    var calcTotalResult =
        calcTotalAndBonus(revenue: revenue, interest: interest, wage: wage, penalties: penalties);

    penaltiesTotalAux = calcTotalResult.penaltiesTotal;
    total = calcTotalResult.total;
    bonusAux = calcTotalResult.bonus;

    for (var penalty in penalties) {
      switch (penalty.mode) {
        case PenaltyMode.plain:
          {
            penaltiesTotalByType[penalty.typeUid] =
                (penaltiesTotalByType[penalty.typeUid] ?? 0.0) + penalty.total;
          }
          break;
        case PenaltyMode.calc:
          {
            penaltiesTotalByType[penalty.typeUid] =
                (penaltiesTotalByType[penalty.typeUid] ?? 0.0) + (penalty.unit * penalty.cost);
            penaltyUnit += penalty.unit;
          }
          break;
      }
      penaltiesCount++;
    }
  }

  int penaltiesCount = 0;
  double bonusAux;
  double penaltyUnit;
  Map<String, double> penaltiesTotalByType = {};

  @override
  String toString() {
    return super.toString() +
        ' penaltiesCount: $penaltiesCount, penaltiesTotalByType: $penaltiesTotalByType';
  }
}
