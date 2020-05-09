import 'package:Staffield/core/models/entry.dart';
import 'package:Staffield/core/models/entry_report.dart';
import 'package:Staffield/core/models/penalty.dart';
import 'package:Staffield/utils/time_and_difference.dart';
import 'package:Staffield/utils/string_utils.dart';

class AdaptedEntryReport {
  AdaptedEntryReport.dateLabel(Entry entry) {
    isDateLabel = true;
    date = timeAndDifference(timestamp1: entry.timestamp, showDate: true);
  }
  AdaptedEntryReport.from(EntryReport report) {
    uid = report.uid;
    date = timeAndDifference(timestamp1: report.timestamp, showDate: true);
    report.timestamp.toString();
    name = report.employeeNameAux;
    total = report.total.toString().formatCurrencyDecimal();
    revenue = report.revenue.toString().formatCurrencyDecimal();
    interest = report.interest.toString().formatCurrency();
    bonus = report.bonusAux.toString().formatCurrency();
    wage = report.wage.toString().formatCurrency();
    penaltiesTotal = report.penaltiesTotalAux.toString().formatCurrency();
    penalties = report.penalties.map((penalty) => penalty.report).toList();
    penaltyUnit = report.penaltyUnit.toString().formatCurrencyDecimal();
    penaltiesCount = report.penaltiesCount.toString().formatCurrencyDecimal();
  }
  String uid;
  String name;
  String total;
  String revenue;
  String interest;
  String bonus;
  String wage;
  String penaltiesTotal;
  String penaltiesCount;
  String date;
  String penaltyUnit;
  var penalties = <PenaltyReport>[];
  bool isDateLabel = false;
}
