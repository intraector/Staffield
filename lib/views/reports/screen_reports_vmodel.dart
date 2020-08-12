import 'dart:async';

import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/models/employee.dart';
import 'package:Staffield/core/reports_repository.dart';
import 'package:Staffield/views/reports/adapted_entry_report.dart';
import 'package:Staffield/views/reports/report_type.dart';
import 'package:Staffield/views/reports/views/all_amployees/table_data.dart';
import 'package:Staffield/views/reports/views/all_amployees/table_employees.dart';
import 'package:Staffield/views/reports/views/list_employees.dart';
import 'package:Staffield/views/reports/views/single_employee/table_one_employee.dart';
import 'package:Staffield/views/reports/views/table_entries.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:jiffy/jiffy.dart';
import 'package:print_color/print_color.dart';

final getIt = GetIt.instance;

class ScreenReportsVModel extends ChangeNotifier {
  ScreenReportsVModel() {
    _employee = employeesList.first;
    fetchReportData();
  }
  final _reportsRepo = ReportsRepository();
  final _employeesRepo = getIt<EmployeesRepository>();
  DateTime _endDate = DateTime(2020, 2, 1);
  int chartLessThan;

  DateTime _startDate = currentDay;

  ReportType _reportType = ReportType.allEmployees;
  Units period = Units.MONTH;
  Employee _employee;
  Widget view = Center(child: CircularProgressIndicator());
  var _dummy = Employee(name: 'Нет сотрудников', uid: '111');

  //-----------------------------------------
  List<Employee> get employeesList =>
      _employeesRepo.repo.isNotEmpty ? _employeesRepo.repo : [_dummy];

  //-----------------------------------------
  Employee get employee => _employee;
  set employee(Employee employee) {
    _employee = employee;
    fetchReportData();
  }

  //-----------------------------------------
  ReportType get reportType => _reportType;
  set reportType(ReportType type) {
    _reportType = type;
    fetchReportData();
  }

  //-----------------------------------------
  static DateTime get currentDay {
    var now = DateTime.now();
    // return DateTime(now.year, now.month, now.day);
    return now;
  }

  //-----------------------------------------
  String get endDate => Jiffy(_endDate).MMMMd;

  //-----------------------------------------
  String get startDate => Jiffy(_startDate).MMMMd;

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
    }
  }

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
    }
  }

  //-----------------------------------------
  Future<void> fetchReportData() async {
    view = Center(child: CircularProgressIndicator());
    notifyListeners();

    switch (_reportType) {
      case ReportType.listEmployees:
        {
          var entryReports = await _reportsRepo.fetchEntriesList(
              greaterThan: _endDate, lessThan: _startDate, employeeUid: null);
          var result =
              entryReports.map((entryReport) => EntryReportStrings.from(entryReport)).toList();
          view = ListEmployees(result);
        }
        break;
      case ReportType.allEmployees:
        {
          var reports = await _reportsRepo.fetchAllEmployees(
            period: period,
            periodsAmount: 1,
            lessThan: chartLessThan,
          );
          var tableData = await Future<TableData>.value(TableData(reports));
          view = TableEmployees(tableData);
          chartLessThan = reports.last.periodTimestamp - 1;
        }
        break;
      case ReportType.singleEmployeeOverPeriod:
        {
          var reports = await _reportsRepo.fetchSingleEmployeeOverPeriod(
            greaterThan: _endDate,
            lessThan: _startDate,
            employeeUid: _employee.uid,
            period: period,
          );
          var result = reports.map((report) => report.strings).toList();

          view = TableSingleEmployee(result);
        }
        break;
      case ReportType.tableEntries:
        {
          var entryReports = await _reportsRepo.fetchEntriesList(
              greaterThan: _endDate, lessThan: _startDate, employeeUid: null);
          var result =
              entryReports.map((entryReport) => EntryReportStrings.from(entryReport)).toList();
          view = TableEntries(result);
        }
        break;
    }
    notifyListeners();
  }
}
