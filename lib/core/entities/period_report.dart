import 'package:Staffield/core/entities/employee.dart';
import 'package:Staffield/core/entities/entity_convert.dart';
import 'package:Staffield/core/entities/report.dart';
import 'package:Staffield/core/entities/penalty_report.dart';
import 'package:Staffield/core/entities/penalty_type.dart';
import 'package:flutter/foundation.dart';
import 'package:jiffy/jiffy.dart';

class PeriodReport {
  PeriodReport.empty();
  factory PeriodReport(
    List<Report> list, {
    List<PenaltyType> types,
    @required Units period,
    @required int periodTimestamp,
    bool empty = false,
  }) {
    if (empty) {
      return PeriodReport._dummy(periodTimestamp: periodTimestamp, period: period);
    } else {
      PeriodReport report = EntityConvert.reportsToPeriodReport(list,
          periodTimestamp: periodTimestamp, period: period);
      if (types != null) {
        for (var penaltyReport in report.penalties) {
          var typeFound = types.firstWhere(
            (element) => element.uid == penaltyReport.typeUid,
            orElse: () => PenaltyType(),
          );
          penaltyReport.typeTitle = typeFound.title;
          penaltyReport.unitTitle = typeFound.unitTitle;
        }
      }
      return report;
    }
  }

  PeriodReport._dummy({this.periodTimestamp, Units period}) {
    periodTitle = labelOf(periodTimestamp, period);
  }

  Employee employee;
  String periodTitle;
  int periodTimestamp;
  int reportsCount = 0;
  double revenueAvg = 0.0;
  double totalAverage = 0.0;
  double interest = 0.0;
  double wage = 0.0;
  double revenue = 0.0;
  double bonus = 0.0;
  double total = 0.0;
  double penaltyUnits = 0.0;
  double penaltiesTotal = 0.0;
  int penaltiesCount = 0;
  var penalties = <PenaltyReport>[];
  Map<String, double> penaltiesTotalByType = {};

  //-----------------------------------------
  static String labelOf(int timestamp, Units period) {
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
  String toString() =>
      'periodTitle : $periodTitle, total : $total, periodTimestamp : $periodTimestamp ';
}
