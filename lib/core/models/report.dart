import 'package:Staffield/core/models/entry_report.dart';
import 'package:Staffield/core/models/penalty_report.dart';
import 'package:Staffield/core/models/penalty_type.dart';
import 'package:Staffield/utils/string_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:jiffy/jiffy.dart';

class Report {
  factory Report(
    List<EntryReport> list, {
    List<PenaltyType> types,
    @required Units period,
    @required int periodTimestamp,
    bool empty = false,
  }) {
    if (empty) return Report._dummy(periodTimestamp: periodTimestamp, period: period);
    var result = Report._default(list, periodTimestamp: periodTimestamp, period: period);
    if (types != null) {
      for (var penaltyReport in result.penalties) {
        var typeFound = types.firstWhere(
          (element) => element.uid == penaltyReport.typeUid,
          orElse: () => PenaltyType(),
        );
        penaltyReport.typeTitle = typeFound.title;
        penaltyReport.unitTitle = typeFound.unitTitle;
      }
    }

    return result;
  }

  Report._dummy({this.periodTimestamp, Units period}) {
    periodTitle = labelOf(periodTimestamp, period);
  }

  Report._default(List<EntryReport> list, {this.periodTimestamp, Units period}) {
    for (var item in list) {
      employeeName = item.employeeName;
      employeeUid = item.employeeUid;
      revenue += item.revenue;
      interest += item.interest;
      wage += item.wage;
      bonus += item.bonus;
      penaltyUnit += item.penaltyUnit ?? 0.0;
      penaltiesTotal += item.penaltiesTotal ?? 0.0;
      total += item.total;
      addToPenaltiesReports(item.penaltiesReports);
      item.penaltiesTotalByType.forEach((type, value) {
        penaltiesTotalByType[type] ??= 0.0;
        return penaltiesTotalByType[type] += value;
      });
      penaltiesCount += item.penaltiesCount;
      reportsCount++;
    }
    revenueAverage = revenue / reportsCount;
    totalAverage = total / reportsCount;
    periodTitle = labelOf(periodTimestamp, period);
    penalties.sort((a, b) => a.typeUid.compareTo(b.typeUid));
  }
  String employeeUid;
  String employeeName;
  String periodTitle;
  int periodTimestamp;
  int reportsCount = 0;
  double revenueAverage = 0.0;
  double totalAverage = 0.0;
  double interest = 0.0;
  double wage = 0.0;
  double revenue = 0.0;
  double bonus = 0.0;
  double total = 0.0;
  double penaltyUnit = 0.0;
  double penaltiesTotal = 0.0;
  int penaltiesCount = 0;
  var penalties = <PenaltyReport>[];
  Map<String, double> penaltiesTotalByType = {};

  ReportStrings get strings => ReportStrings(this);

  //-----------------------------------------
  String labelOf(int timestamp, Units period) {
    switch (period) {
      case Units.MONTH:
        return Jiffy(DateTime.fromMillisecondsSinceEpoch(timestamp)).yMMMM;
        break;
      case Units.WEEK:
        return Jiffy(DateTime.fromMillisecondsSinceEpoch(timestamp)).week.toString() + ' неделя';
        break;
      default:
        return '';
    }
  }

  //-----------------------------------------
  @override
  String toString() => 'periodTitle : $periodTitle, penalties : $penalties';

  void addToPenaltiesReports(List<PenaltyReport> list) {
    for (var otherItem in list) {
      var index = penalties.indexWhere((ownItem) => ownItem.typeUid == otherItem.typeUid);
      if (index >= 0) {
        penalties[index] += otherItem;
      } else {
        penalties.add(otherItem);
      }
    }
  }
}

class ReportStrings {
  ReportStrings(Report report) {
    employeeName = report.employeeName;
    employeeUid = report.employeeUid;
    periodTitle = report.periodTitle;
    total = report.total.toString().formatInt;
    wage = report.wage.toString().formatInt;
    bonus = report.bonus.toString().formatInt;
    totalAverage = report.totalAverage.toString().formatInt;
    reportsCount = report.reportsCount.toString();
    revenue = report.revenue.toString().formatInt;
    revenueAverage = report.revenueAverage.toString().formatInt;
    penaltiesTotal = report.penaltiesTotal.toString().formatInt;
    penaltyUnit = report.penaltyUnit.toString().formatInt;
    penaltiesCount = report.penaltiesCount.toString().formatInt;
    periodTitle = report.periodTitle;
    penalties = report.penalties;
  }
  String employeeUid;
  String employeeName;
  String periodTitle;
  String total;
  String wage;
  String bonus;
  String reportsCount;
  String revenue;
  String revenueAverage;
  String totalAverage;
  String penaltiesTotal;
  String penaltiesCount;
  String penaltyUnit;
  var penalties = <PenaltyReport>[];
  @override
  String toString() => 'periodTitle : $periodTitle, penalties : $penalties';
}
