import 'dart:async';

import 'package:Staffield/core/reports_repository.dart';
import 'package:Staffield/views/reports/report_adapted.dart';
import 'package:Staffield/views/reports/report_type.dart';
import 'package:Staffield/views/reports/views/by_employee.dart';
import 'package:Staffield/views/reports/views/data_table.dart';
import 'package:Staffield/views/reports/views/table_with_still_employees_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Staffield/utils/time_and_difference.dart';

class ScreenReportsVModel extends ChangeNotifier {
  ScreenReportsVModel() {
    fetchReportData();
  }
  final _reportsRepo = ReportsRepository();
  DateTime _startDate = DateTime(2020, 4, 1);
  DateTime _endDate = currentDay;

  ReportType _reportType = ReportType.byEmployees;
  Future<List<ReportAdapted>> reportData;

  //-----------------------------------------
  ReportType get reportType => _reportType;
  set reportType(ReportType type) {
    _reportType = type;
    fetchReportData();
    notifyListeners();
  }

  //-----------------------------------------
  static DateTime get currentDay {
    var now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  //-----------------------------------------
  String get startDate => timeAndDifference(date1: _startDate, showDate: true);

  //-----------------------------------------
  String get endDate => timeAndDifference(date1: _endDate, showDate: true);

  //-----------------------------------------
  Future<void> pickStartDate(BuildContext context) async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: _startDate,
    );
    if (date != null) {
      _startDate = date;
      fetchReportData();
      notifyListeners();
    }
  }

  //-----------------------------------------
  Future<void> pickEndDate(BuildContext context) async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: _endDate,
    );
    if (date != null) {
      _endDate = date;
      fetchReportData();
      notifyListeners();
    }
  }

  //-----------------------------------------
  Future<void> fetchReportData() async {
    var _completer = Completer<List<ReportAdapted>>();
    reportData = _completer.future;
    var reports = await _reportsRepo.fetch(_startDate, _endDate);
    var result = reports.map((report) => ReportAdapted(report)).toList();
    _completer.complete(result);
  }

  //-----------------------------------------
  Widget getView(List<ReportAdapted> list) {
    Widget result;
    switch (_reportType) {
      case ReportType.byEmployees:
        result = ByEmployee(list);
        break;
      case ReportType.tableData:
        result = TableData(list);
        break;
      case ReportType.tableWithStillEmployeeNames:
        result = TableWithStillEmployeeNames(list);
        break;
    }
    return result;
  }
}
