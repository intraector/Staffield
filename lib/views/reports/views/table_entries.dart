import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/core/entities/employee.dart';
import 'package:Staffield/views/reports/report_ui_adapted.dart';
import 'package:Staffield/views/reports/vmodel_view_reports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class TableEntries extends StatelessWidget {
  TableEntries(this.list);
  final List<ReportUiAdapted> list;

  @override
  Widget build(BuildContext context) {
    var vModel = Provider.of<ScreenReportsVModel>(context, listen: false);
    final columnWidth = MediaQuery.of(context).size.shortestSide / 4.5;
    final rowHeight = MediaQuery.of(context).size.shortestSide / 11;
    final tableHeaderHeight = MediaQuery.of(context).size.shortestSide / 7.0;
    const cellPadding = 10.0;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: Card(
                    child: Container(
                      child: DropdownButton<Employee>(
                          items: vModel.employeesList
                              .map((employee) =>
                                  DropdownMenuItem(value: employee, child: Text(employee.name)))
                              .toList(),
                          value: vModel.employee,
                          onChanged: (uid) {
                            vModel.employee = uid;
                          }),
                    ),
                  ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: tableHeaderHeight,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 1.0, color: AppColors.primarySemiBlend),
                                bottom: BorderSide(width: 1.0, color: AppColors.primarySemiBlend),
                              ),
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                    width: columnWidth,
                                    padding: EdgeInsets.all(cellPadding),
                                    child: Text('Сотрудник')),
                                Container(
                                    width: columnWidth,
                                    padding: EdgeInsets.all(cellPadding),
                                    child: Text('З/П')),
                                Container(
                                    width: columnWidth,
                                    padding: EdgeInsets.all(cellPadding),
                                    child: Text('Выручка')),
                                Container(
                                    width: columnWidth,
                                    padding: EdgeInsets.all(cellPadding),
                                    child: Text('Процент')),
                                Container(
                                    width: columnWidth,
                                    padding: EdgeInsets.all(cellPadding),
                                    child: Text('Оклад')),
                              ],
                            ),
                          ),
                          ...list
                              .map(
                                (report) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: rowHeight,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 1.0, color: AppColors.primaryBlend))),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                              width: columnWidth,
                                              padding: EdgeInsets.all(cellPadding),
                                              child: Text(report.name)),
                                          Container(
                                              width: columnWidth,
                                              padding: EdgeInsets.all(cellPadding),
                                              child: Text(report.total)),
                                          Container(
                                              width: columnWidth,
                                              padding: EdgeInsets.all(cellPadding),
                                              child: Text(report.revenue)),
                                          Container(
                                              width: columnWidth,
                                              padding: EdgeInsets.all(cellPadding),
                                              child: Text(report.interest)),
                                          Container(
                                              width: columnWidth,
                                              padding: EdgeInsets.all(cellPadding),
                                              child: Text(report.wage)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
