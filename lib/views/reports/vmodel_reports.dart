import 'dart:async';

import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entities/employee.dart';
import 'package:Staffield/core/penalty_types_repository.dart';
import 'package:Staffield/core/reports_repository.dart';
import 'package:Staffield/views/reports/report_type.dart';
import 'package:Staffield/views/reports/views/fl_charts/area_fl_charts.dart';
import 'package:Staffield/views/reports/views/fl_charts/components/chart_data.dart';
import 'package:Staffield/views/reports/views/fl_charts/components/report_criteria.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
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

  ReportType _reportType = ReportType.fl_charts;
  Units period = Units.MONTH;
  var selectedEmployees = <Employee>[];
  Widget view = Center(child: CircularProgressIndicator());

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

  // //-----------------------------------------
  // ReportType get reportType => _reportType;

  // set reportType(ReportType type) {
  //   _reportType = type;
  //   fetchReportData();
  // }

  //-----------------------------------------
  DateTime _startDate = DateTime.now();
  String get startDate => Jiffy(_startDate).yMMMd;

  //-----------------------------------------
  String penaltyTypeCurrentUid = '111';

  Map<String, String> _auxMenuItems = {
    '111': 'сумма',
    '222': 'количество',
  };

  Map<String, String> get penaltiesMenuItems => _auxMenuItems;

  //-----------------------------------------
  void generatePenaltiesMenuItems(Set<String> list) {
    _auxMenuItems.clear();
    _auxMenuItems = {
      '111': 'сумма',
      '222': 'количество',
    };
    PenaltyTypesRepository penaltyTypesRepo = Get.find();
    for (var uid in list) {
      _auxMenuItems[uid] = penaltyTypesRepo.getType(uid).title;
    }
  }

  //-----------------------------------------
  void generateWageMenuItems(Set<String> list) {
    _auxMenuItems.clear();
    _auxMenuItems = {
      '111': 'сумма',
      '222': 'количество',
    };
    PenaltyTypesRepository penaltyTypesRepo = Get.find();
    for (var uid in list) {
      _auxMenuItems[uid] = penaltyTypesRepo.getType(uid).title;
    }
  }

  //-----------------------------------------
  set penaltyTypeUid(String value) {
    penaltyTypeCurrentUid = value;
    fetchReportData();
  }

  //-----------------------------------------
  Future<void> pickStartDate(BuildContext context) async {
    DateTime date = await showPlatformDialog<DateTime>(
        context: context,
        useRootNavigator: true,
        builder: (context) {
          DateTime date;
          return PlatformAlertDialog(
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    width: double.maxFinite,
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle:
                              TextStyle(fontSize: Theme.of(context).textTheme.bodyText2.fontSize),
                        ),
                      ),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: _startDate,
                        maximumDate: DateTime.now(),
                        minimumDate: DateTime(DateTime.now().year - 2),
                        onDateTimeChanged: (value) => date = value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              PlatformDialogAction(
                child: PlatformText('Отмена'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              PlatformDialogAction(
                  child: Text('OK'), onPressed: () => Navigator.of(context).pop(date)),
            ],
          );
        });
    // DateTime date = await showDatePicker(
    //   context: context,
    //   firstDate: DateTime(DateTime.now().year - 5),
    //   lastDate: DateTime(DateTime.now().year + 5),
    //   initialDate: _startDate,
    // );
    if (date != null) {
      _startDate = date;
      fetchReportData();
    }
    print(date);
  }

  //-----------------------------------------
  Future<void> fetchReportData() async {
    view = Center(child: CircularProgressIndicator());
    update();

    switch (_reportType) {
      case ReportType.fl_charts:
        {
          var reports = _reportsRepo.fetch(
            periodsAmount: _periodsAmount,
            period: period,
            employees: selectedEmployees,
            startDate: _startDate,
          );
          reports.then((reports) {
            view = AreaFlCharts(ChartData(reports, criterion, penaltyTypeCurrentUid));
            update();
          });
        }
        break;

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
