import 'package:Staffield/core/entities/entry.dart';
import 'package:Staffield/core/entities/report.dart';
import 'package:Staffield/core/entities/penalty.dart';
import 'package:Staffield/core/entities/penalty_mode.dart';
import 'package:Staffield/core/entities/penalty_report.dart';
import 'package:Staffield/core/entities/period_report.dart';
import 'package:Staffield/core/utils/calc_total_mixin.dart';
import 'package:jiffy/jiffy.dart';

class EntityConvert {
  //-----------------------------------------
  static Report entryToReport(Entry entry) {
    var report = Report();
    report.uid = entry.uid;
    report.employee = entry.employee;
    report.revenue = entry.revenue;
    report.interest = entry.interest;
    report.bonus = entry.revenue * entry.interest / 100;
    report.wage = entry.wage;
    report.penalties = entry.penalties;
    report.penaltyUnit = 0;
    report.timestamp = entry.timestamp;

    var calcTotal = CalcTotal(
      revenue: entry.revenue,
      interest: entry.interest,
      wage: entry.wage,
      penalties: entry.penalties,
    );

    report.penaltiesTotal = calcTotal.penaltiesTotal;
    report.total = calcTotal.total;
    report.bonus = calcTotal.bonus;

    for (var penalty in entry.penalties) {
      _addPenaltyToReport(penalty, report);
      switch (penalty.mode) {
        case PenaltyMode.plain:
          {
            report.penaltiesTotalByType[penalty.typeUid] =
                (report.penaltiesTotalByType[penalty.typeUid] ?? 0.0) + penalty.total;
          }
          break;
        case PenaltyMode.calc:
          {
            report.penaltiesTotalByType[penalty.typeUid] =
                (report.penaltiesTotalByType[penalty.typeUid] ?? 0.0) +
                    (penalty.units * penalty.cost);
            report.penaltyUnit += penalty.units;
          }
          break;
      }
      report.penaltiesCount++;
    }

    // report.strings = ReportUiAdapted.from(report);
    return report;
  }

  //-----------------------------------------
  static PeriodReport reportsToPeriodReport(
    List<Report> list, {
    int periodTimestamp,
    Units period,
  }) {
    var report = PeriodReport.empty();
    for (var item in list) {
      report.employee = item.employee;
      report.revenue += item.revenue;
      report.interest += item.interest;
      report.wage += item.wage;
      report.bonus += item.bonus;
      report.penaltyUnit += item.penaltyUnit ?? 0.0;
      report.penaltiesTotal += item.penaltiesTotal ?? 0.0;
      report.total += item.total;
      _addPenaltyToPeriodReport(item.penaltiesReports, report);
      item.penaltiesTotalByType.forEach((type, value) {
        report.penaltiesTotalByType[type] ??= 0.0;
        return report.penaltiesTotalByType[type] += value;
      });
      report.penaltiesCount += item.penaltiesCount;
      report.reportsCount++;
    }
    report.revenueAverage = report.revenue / report.reportsCount;
    report.totalAverage = report.total / report.reportsCount;
    report.periodTimestamp = periodTimestamp;
    report.periodTitle = PeriodReport.labelOf(periodTimestamp, period);
    report.penalties.sort((a, b) => a.typeUid.compareTo(b.typeUid));
    return report;
  }

  //-----------------------------------------
  static void _addPenaltyToReport(Penalty penalty, Report entryReport) {
    var index =
        entryReport.penaltiesReports.indexWhere((element) => element.typeUid == penalty.typeUid);
    if (index >= 0) {
      entryReport.penaltiesReports[index] += PenaltyReport.from(penalty);
    } else {
      entryReport.penaltiesReports.add(PenaltyReport.from(penalty));
    }
  }

  //-----------------------------------------
  static void _addPenaltyToPeriodReport(List<PenaltyReport> list, PeriodReport report) {
    for (var otherItem in list) {
      var index = report.penalties.indexWhere((ownItem) => ownItem.typeUid == otherItem.typeUid);
      if (index >= 0) {
        report.penalties[index] += otherItem;
      } else {
        report.penalties.add(otherItem);
      }
    }
  }
}
