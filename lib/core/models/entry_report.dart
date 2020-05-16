import 'package:Staffield/core/models/penalty_mode.dart';
import 'package:Staffield/core/utils/calc_total_mixin.dart';
import 'package:Staffield/core/models/entry.dart';
import 'package:Staffield/utils/time_and_difference.dart';
import 'package:Staffield/views/reports/adapted_entry_report.dart';

class EntryReport extends Entry with CalcTotal {
  EntryReport();
  EntryReport.dateLabel(int timestamp) {
    isDateLabel = true;
    dateLabel = timeAndDifference(timestamp1: timestamp, showDate: true);
  }

  bool isDateLabel = false;
  String dateLabel = '';
  EntryReport.fromEntry(Entry entry) {
    uid = entry.uid;
    employeeName = entry.employeeName;
    revenue = entry.revenue;
    interest = entry.interest;
    bonus = revenue * interest / 100;
    wage = entry.wage;
    penalties = entry.penalties;
    penaltyUnit = 0;
    timestamp = entry.timestamp;

    var calcTotalResult =
        calcTotalAndBonus(revenue: revenue, interest: interest, wage: wage, penalties: penalties);

    penaltiesTotalAux = calcTotalResult.penaltiesTotal;
    total = calcTotalResult.total;
    bonus = calcTotalResult.bonus;

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

    _adapted = AdaptedEntryReport.from(this);
  }

  int penaltiesCount = 0;
  double bonus;
  double penaltyUnit = 0;
  Map<String, double> penaltiesTotalByType = {};
  double penaltiesTotalAux = 0.0;
  AdaptedEntryReport _adapted;

  AdaptedEntryReport get adapted {
    _adapted ??= AdaptedEntryReport.from(this);
    return _adapted;
  }

  @override
  String toString() {
    return super.toString() +
        ' penaltiesCount: $penaltiesCount, penaltiesTotalByType: $penaltiesTotalByType';
  }
}
