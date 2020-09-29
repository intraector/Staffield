import 'dart:async';

import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entities/employee.dart';
import 'package:Staffield/core/reports_repository.dart';
import 'package:Staffield/views/reports/report_type.dart';
import 'package:Staffield/views/reports/views/fl_charts/area_fl_charts.dart';
import 'package:Staffield/views/reports/views/fl_charts/chart_data.dart';
import 'package:Staffield/views/reports/views/fl_charts/components/report_criteria.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class VModelReports extends GetxController {
  @override
  void onInit() {
    if (employees.isNotEmpty) _employee = employees.first;
    selectedEmployees = employees;
    fetchReportData();
    super.onInit();
  }

  final _reportsRepo = ReportsRepository();
  final _employeesRepo = Get.find<EmployeesRepository>();

  DateTime _endDate = DateTime(2020, 2, 1);
  DateTime _startDate = DateTime.now();

  ReportType _reportType = ReportType.fl_charts;
  Units period = Units.MONTH;
  var selectedEmployees = <Employee>[];
  Widget view = Center(child: CircularProgressIndicator());
  // var _dummy = Employee(name: 'Нет сотрудников', uid: '111');

  //-----------------------------------------
  List<Employee> get employees => _employeesRepo.repoWhereHidden(false);

  //-----------------------------------------
  Employee _employee;

  Employee get employee => _employee;
  set employee(Employee employee) {
    _employee = employee;
    fetchReportData();
  }

  //-----------------------------------------
  var _criterion = ReportCriterion.total;

  ReportCriterion get criterion => _criterion;
  set criterion(ReportCriterion value) {
    _criterion = value;
    fetchReportData();
  }

  //-----------------------------------------
  int _periodsAmount = 6;

  int get periodsAmount => _periodsAmount;
  set periodsAmount(int amount) {
    _periodsAmount = amount;
    fetchReportData();
  }

  //-----------------------------------------
  ReportType get reportType => _reportType;

  set reportType(ReportType type) {
    _reportType = type;
    fetchReportData();
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
      update();
    }
  }

  //-----------------------------------------
  Future<void> fetchReportData([List<Employee> employees]) async {
    view = Center(child: CircularProgressIndicator());
    update();

    switch (_reportType) {
      case ReportType.fl_charts:
        {
          var reports = _reportsRepo.fetch(
            periodsAmount: _periodsAmount,
            period: period,
            employees: employees,
          );
          reports.then((reports) {
            view = AreaFlCharts(ChartData(reports, criterion));
            update();
          });
        }
      // case ReportType.listEmployees:
      //   {
      //     var entryReports = await _reportsRepo.fetchEntriesList(
      //         greaterThan: _endDate, lessThan: _startDate, employeeUid: null);
      //     var result =
      //         entryReports.map((entryReport) => ReportUiAdapted.from(entryReport)).toList();
      //     view = ListEmployees(result);
      //   }
      //   break;
      // case ReportType.allEmployees:
      //   {
      //     var reports = await _reportsRepo.fetchAllEmployees(
      //       period: period,
      //       periodsAmount: 1,
      //       lessThan: chartLessThan,
      //     );
      //     var tableData = await Future<TableData>.value(TableData(reports));
      //     view = TableEmployees(tableData);
      //     chartLessThan = reports.last.periodTimestamp - 1;
      //   }
      //   break;
      // case ReportType.singleEmployeeOverPeriod:
      //   {
      //     var reports = await _reportsRepo.fetchSingleEmployeeOverPeriod(
      //       greaterThan: _endDate,
      //       lessThan: _startDate,
      //       employeeUid: _employee.uid,
      //       period: period,
      //     );
      //     var result = reports.map((report) => PeriodReportUiAdapted(report)).toList();

      //     view = TableSingleEmployee(result);
      //   }
      //   break;
      // case ReportType.tableEntries:
      //   {
      //     var entryReports = await _reportsRepo.fetchEntriesList(
      //         greaterThan: _endDate, lessThan: _startDate, employeeUid: null);
      //     var result =
      //         entryReports.map((entryReport) => ReportUiAdapted.from(entryReport)).toList();
      //     view = TableEntries(result);
      //   }
      //   break;
    }
  }
}
