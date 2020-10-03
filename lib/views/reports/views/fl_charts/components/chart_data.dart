import 'dart:math';

import 'package:Staffield/core/entities/employee.dart';
import 'package:Staffield/core/entities/penalty_report.dart';
import 'package:Staffield/core/entities/period_report.dart';
import 'package:Staffield/views/reports/views/fl_charts/components/menu_penalty_type/vmodel_penalty_type.dart';
import 'package:Staffield/views/reports/views/fl_charts/components/period_value.dart';
import 'package:Staffield/views/reports/views/fl_charts/components/report_criteria.dart';
import 'package:Staffield/views/reports/vmodel_reports.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:Staffield/utils/string_utils.dart';

class ChartData {
  ChartData(
    List<PeriodReport> periodReports,
    this.criterion, {
    String penaltyTypeUid,
    MenuWageItem auxMenuValue,
  }) {
    voidBuildData(
      periodReports,
      criterion,
      penaltyTypeUid: penaltyTypeUid,
      auxMenuValue: auxMenuValue,
    );
  }

  Map<Employee, List<FlSpot>> spots = {};
  var periodValues = <PeriodValue>[];
  bool textMode = true;
  double maxCriterionValue = 0.0;
  double interval = 0.0;
  ReportCriterion criterion;
  Set<Employee> employees = {};
  Set<String> _penaltiesMenuItems = {};

  //----------------------------------------
  double _maxPenaltiesCount = 1;
  double get maxPenaltiesCount =>
      criterion == ReportCriterion.penaltiesTotal ? _maxPenaltiesCount - 1 : 1.0;

  //----------------------------------------
  voidBuildData(List<PeriodReport> periodReports, ReportCriterion criterion,
      {String penaltyTypeUid, MenuWageItem auxMenuValue}) {
    if (periodReports.isEmpty) return;
    periodReports.sort((a, b) => a.periodTimestamp.compareTo(b.periodTimestamp));

    var firstDate = Jiffy(DateTime.fromMillisecondsSinceEpoch(periodReports.first.periodTimestamp));
    var lastDate = Jiffy(DateTime.fromMillisecondsSinceEpoch(periodReports.last.periodTimestamp));
    var difference = lastDate.diff(firstDate, Units.MONTH);

    int iteratorMonth = firstDate.month;
    int iteratorYear = firstDate.year;
    for (double i = 0; i <= difference; i++) {
      var periodValue = PeriodValue(value: i, month: iteratorMonth, year: iteratorYear);
      periodValues.add(periodValue);
      if (iteratorMonth < 12) {
        iteratorMonth++;
      } else {
        iteratorMonth = 1;
        iteratorYear++;
      }
    }

    for (var periodReport in periodReports) {
      var date = Jiffy(DateTime.fromMillisecondsSinceEpoch(periodReport.periodTimestamp));
      var periodValue = periodValues.firstWhere(
          (item) => (item.month == date.month && item.year == date.year),
          orElse: () => PeriodValue());
      var nextCriterionValue = ReportCriterionMapper.value(
        criterion,
        periodReport,
        penaltyTypeUid: penaltyTypeUid,
        auxMenuValue: auxMenuValue,
      );
      periodValue.periodReports[periodReport.employee] =
          FlSpot(periodValue.value, nextCriterionValue);
      periodValue.periodPenalties[periodReport.employee] = periodReport.penalties;
      if (periodReport.penalties.length > _maxPenaltiesCount) {
        _maxPenaltiesCount = periodReport.penalties.length.toDouble();
      }
      if (maxCriterionValue < nextCriterionValue) maxCriterionValue = nextCriterionValue;
      _penaltiesMenuItems.addAll(periodReport.penaltiesTotalByType.keys);
    }

    calcInterval();
    employees = periodReports.map<Employee>((item) => item.employee).toSet();

    employees.forEach((uid) {
      spots[uid] = [];
      for (var periodValue in periodValues) {
        if (periodValue.periodReports[uid] != null) {
          spots[uid].add(periodValue.periodReports[uid]);
        }
      }
    });
    if (periodValues.length > 8) textMode = false;
    if (criterion == ReportCriterion.penaltiesTotal) {
      generatePenaltiesMenuItems();
    }
  }

  //----------------------------------------
  void generatePenaltiesMenuItems() =>
      Get.find<VModelPenaltyType>().generatePenaltiesMenuItems(_penaltiesMenuItems);

  //----------------------------------------
  void calcInterval() {
    interval = maxCriterionValue / 5;
    var numberOfDigits = interval.round().toString().length - 1;
    double precision = pow(10, numberOfDigits).toDouble();
    interval = (interval / precision).round().toDouble() * precision;
  }

  //----------------------------------------
  String getBottomTitle(double value) {
    var foundItem =
        periodValues.firstWhere((element) => element.value == value, orElse: () => PeriodValue());
    if (foundItem.value != null)
      return textMode ? foundItem.title : foundItem.month.toString();
    else
      return null;
  }

  //----------------------------------------
  List<LineTooltipItem> getTooltipItems(list) => list.map<LineTooltipItem>((spot) {
        return LineTooltipItem(
          spots.keys.elementAt(spot.barIndex).name + ': ' + spot.y.toString().formatInt,
          TextStyle(
            color: spots.keys.elementAt(spot.barIndex).color,
          ),
        );
      }).toList();

  //----------------------------------------
  List<LineChartBarData> get lines {
    var list = <LineChartBarData>[];
    for (var key in spots.keys) {
      list.add(
        LineChartBarData(
          spots: spots[key],
          isCurved: true,
          curveSmoothness: 0.2,
          colors: [key.color],
          barWidth: 5,
          dotData: FlDotData(show: true),
        ),
      );
    }
    return list;
  }

  //----------------------------------------
  List<DataColumn> get tableTitles => employees
      .map<DataColumn>((item) =>
          DataColumn(label: Text(item.name), numeric: criterion != ReportCriterion.penaltiesTotal))
      .toList()
        ..insert(0, DataColumn(label: Text('')));

  //----------------------------------------
  List<DataRow> get tableRows {
    var output = <DataRow>[];
    bool isEven = false;
    for (int i = 0; i < periodValues.length; i++) {
      var cells = <DataCell>[DataCell(Container(width: 10.0, child: Text('')))];
      for (var employee in employees) {
        Widget cellContent;
        if (criterion == ReportCriterion.penaltiesTotal) {
          var rows = (periodValues[i].periodPenalties[employee] ?? <PenaltyReport>[])
              .map<Row>((penalty) => Row(
                    children: [
                      Text(
                        '${penalty.typeTitle}: ' +
                            '${(penalty.unitString.isEmpty ? '' : penalty.unitString + " " + penalty.unitTitle + " = ")}' +
                            '${penalty.totalString} р.',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ))
              .toList();
          cellContent = Column(children: rows);
        } else {
          cellContent =
              Text(periodValues[i].periodReports[employee]?.y?.toString()?.formatInt ?? '0');
        }
        cells.add(DataCell(cellContent));
      }
      output.add(DataRow(
        cells: cells,
        color: isEven ? MaterialStateProperty.resolveWith<Color>((_) => Colors.grey[200]) : null,
      ));
      isEven = !isEven;
    }
    return output;
  }

  //----------------------------------------
  List<DataRow> getEmptyTableRows(Color color) {
    var output = <DataRow>[];
    for (var bv in periodValues) {
      var cells = <DataCell>[
        DataCell(
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 15.0),
            width: 70.0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [color, color.withOpacity(0.5)],
              stops: [0.9, 1.0],
            )),
            child: Text(bv.title),
          ),
        ),
      ];

      output.add(DataRow(cells: cells));
    }
    return output;
  }
}
