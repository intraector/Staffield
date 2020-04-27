import 'package:Staffield/constants/penalty_type.dart';
import 'package:Staffield/core/utils/calc_total_mixin.dart';
import 'package:Staffield/core/models/entry.dart';
import 'package:Staffield/core/models/penalty_mixin_time_by_money.dart';

class EntryReport extends Entry with TimeByMoney, CalcTotal {
  EntryReport();
  EntryReport.fromEntry(Entry entry) {
    uid = entry.uid;
    employeeNameAux = entry.employeeNameAux;
    revenue = entry.revenue;
    interest = entry.interest;
    wage = entry.wage;
    penalties = entry.penalties;
    minutes = 0;

    var calcTotalResult =
        calcTotalAndBonus(revenue: revenue, interest: interest, wage: wage, penalties: penalties);
    penaltiesTotalAux = calcTotalResult.penaltiesTotal;
    total = calcTotalResult.total;

    for (var penalty in penalties) {
      if (penaltiesTotalByType[penalty.type] == null) penaltiesTotalByType[penalty.type] = 0.0;
      switch (penalty.type) {
        case PenaltyType.plain:
          {
            penaltiesTotalByType[penalty.type] += penalty.total;
          }
          break;
        case PenaltyType.minutesByMoney:
          {
            penaltiesTotalByType[penalty.type] += (penalty.minutes * penalty.money);
            minutes += penalty.minutes;
          }
          break;
      }
      penaltiesCount++;
    }
  }

  int penaltiesCount = 0;
  Map<PenaltyType, double> penaltiesTotalByType = {};
}
