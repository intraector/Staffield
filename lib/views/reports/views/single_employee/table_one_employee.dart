import 'package:Staffield/core/entities/employee.dart';
import 'package:Staffield/views/reports/period_report_ui_adapted.dart';
import 'package:Staffield/views/reports/vmodel_reports.dart';
import 'package:Staffield/views/reports/views/single_employee/views/view_general.dart';
import 'package:Staffield/views/reports/views/single_employee/views/view_penalties.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class TableSingleEmployee extends StatelessWidget {
  TableSingleEmployee(this.list);
  final List<PeriodReportUiAdapted> list;

  @override
  Widget build(BuildContext context) {
    var vModel = Provider.of<VModelReports>(context, listen: false);
    return Column(
      children: <Widget>[
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              resizeToAvoidBottomPadding: true,
              appBar: AppBar(
                bottom: TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(text: 'Отчет'),
                    Tab(text: 'Штрафы'),
                  ],
                ),
                title: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 40.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ChoiceChip(
                            label: Text('Месяц'),
                            selected: vModel.period == Units.MONTH,
                            onSelected: (bool selected) {
                              vModel.period = Units.MONTH;
                              // vModel.reportType = ReportType.singleEmployeeOverPeriod;
                            }),
                        ChoiceChip(
                            label: Text('Неделя'),
                            selected: vModel.period == Units.WEEK,
                            onSelected: (bool selected) {
                              vModel.period = Units.WEEK;
                              // vModel.reportType = ReportType.singleEmployeeOverPeriod;
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Flexible(
                          child: DropdownButton<Employee>(
                            items: vModel.employees
                                .map((employee) =>
                                    DropdownMenuItem(value: employee, child: Text(employee.name)))
                                .toList(),
                            value: vModel.employee,
                            onChanged: (uid) => vModel.employee = uid,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              body: Scaffold(
                body: TabBarView(
                  children: [ViewGeneral(list), ViewPenalties(list)],
                ),
              ),
            ),
          ),
        ),
        // Expanded(child: ViewGeneral(list)),
        // Expanded(child: ViewPenalties(list)),
      ],
    );
  }
}
