import 'package:Staffield/core/models/penalty.dart';
import 'package:Staffield/core/models/penalty_mode.dart';
import 'package:Staffield/core/models/penalty_report.dart';
import 'package:Staffield/core/utils/calc_total_mixin.dart';
import 'package:Staffield/core/models/entry.dart';
import 'package:Staffield/views/reports/adapted_entry_report.dart';
import 'package:jiffy/jiffy.dart';

class EntryReport extends Entry with CalcTotal {
  EntryReport();
  EntryReport.dateLabel(int timestamp) {
    isDateLabel = true;
    dateLabel = Jiffy(DateTime.fromMillisecondsSinceEpoch(timestamp)).MMMMd;
    // dateLabel = timeAndDifference(timestamp1: timestamp, showDate: true, showYear: true);
  }

  bool isDateLabel = false;
  String dateLabel = '';
  EntryReport.fromEntry(Entry entry) {
    uid = entry.uid;
    employeeName = entry.employeeName;
    employeeUid = entry.employeeUid;
    revenue = entry.revenue;
    interest = entry.interest;
    bonus = revenue * interest / 100;
    wage = entry.wage;
    penalties = entry.penalties;
    penaltyUnit = 0;
    timestamp = entry.timestamp;

    var calcTotalResult =
        calcTotalAndBonus(revenue: revenue, interest: interest, wage: wage, penalties: penalties);

    penaltiesTotal = calcTotalResult.penaltiesTotal;
    total = calcTotalResult.total;
    bonus = calcTotalResult.bonus;

    for (var penalty in penalties) {
      addToPenaltiesReports(penalty);
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
                (penaltiesTotalByType[penalty.typeUid] ?? 0.0) + (penalty.units * penalty.cost);
            penaltyUnit += penalty.units;
          }
          break;
      }
      penaltiesCount++;
    }

    _strings = EntryReportStrings.from(this);
  }

  var penaltiesReports = <PenaltyReport>[];
  int penaltiesCount = 0;
  double bonus;
  double penaltyUnit = 0;
  Map<String, double> penaltiesTotalByType = {};
  double penaltiesTotal = 0.0;
  EntryReportStrings _strings;

  EntryReportStrings get strings {
    _strings ??= EntryReportStrings.from(this);
    return _strings;
  }

  @override
  String toString() {
    return super.toString() +
        ' penaltiesCount: $penaltiesCount, penaltiesTotalByType: $penaltiesTotalByType';
  }

  void addToPenaltiesReports(Penalty penalty) {
    var index = penaltiesReports.indexWhere((element) => element.typeUid == penalty.typeUid);
    if (index >= 0) {
      penaltiesReports[index] += PenaltyReport.from(penalty);
    } else {
      penaltiesReports.add(PenaltyReport.from(penalty));
    }
  }
}
