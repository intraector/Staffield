import 'dart:async';

import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/models/employee.dart';
import 'package:Staffield/core/reports_repository.dart';
import 'package:Staffield/views/reports/report_by_employee.dart';
import 'package:Staffield/views/reports/report_type.dart';
import 'package:Staffield/views/reports/views/list_employees.dart';
import 'package:Staffield/views/reports/views/data_table.dart';
import 'package:Staffield/views/reports/views/table_employees.dart';
import 'package:Staffield/views/reports/views/table_one_employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Staffield/utils/time_and_difference.dart';
import 'package:print_color/print_color.dart';

class ScreenReportsVModel extends ChangeNotifier {
  ScreenReportsVModel() {
    _employee = employeesList.first;
    fetchReportData();
  }
  final _reportsRepo = ReportsRepository();
  final _employeesRepo = getIt<EmployeesRepository>();
  DateTime _startDate = DateTime(2019, 8, 1);

  DateTime _endDate = currentDay;

  ReportType _reportType = ReportType.listEmployees;
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
    view = Center(child: CircularProgressIndicator());
    notifyListeners();

    switch (_reportType) {
      case ReportType.listEmployees:
        {
          var reports = await _reportsRepo.fetchByEmployee(start: _startDate, end: _endDate);
          var result = reports.map((report) => ReportByEmployee(report)).toList();
          view = ListByEmployee(result);
        }
        break;
      case ReportType.tableData:
        {
          var reports = await _reportsRepo.fetchByEmployee(start: _startDate, end: _endDate);
          var result = reports.map((report) => ReportByEmployee(report)).toList();
          view = TableData(result);
        }
        break;
      case ReportType.tableEmployees:
        {
          var reports = await _reportsRepo.fetchByEmployee(start: _startDate, end: _endDate);
          var result = reports.map((report) => ReportByEmployee(report)).toList();
          view = TableEmployees(result);
        }
        break;
      case ReportType.tableOneEmployeeByMonth:
        {
          var reports = await _reportsRepo.fetchOneEmployeeByMonth(
            start: _startDate,
            end: _endDate,
            employeeUid: _employee.uid,
          );
          var result = reports.map((month, report) {
            Print.yellow('||| month : $month');
            return MapEntry(month, ReportByEmployee(report));
          });
          view = TableOneEmployee(result);
        }
        break;
    }
    notifyListeners();
  }
}
