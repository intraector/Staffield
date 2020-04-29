import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/core/models/employee.dart';
import 'package:Staffield/views/reports/report_by_employee.dart';
import 'package:Staffield/views/reports/screen_reports_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class TableOneEmployee extends StatelessWidget {
  TableOneEmployee(this.list);
  final Map<String, ReportByEmployee> list;

  @override
  Widget build(BuildContext context) {
    var vModel = Provider.of<ScreenReportsVModel>(context, listen: false);
    final columnWidth = MediaQuery.of(context).size.shortestSide / 4.5;
    final nameHeight = MediaQuery.of(context).size.shortestSide / 11;
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
                                    child: Text('З/П,\nвсего')),
                                Container(
                                    width: columnWidth,
                                    padding: EdgeInsets.all(cellPadding),
                                    child: Text('З/П,\nв среднем')),
                                Container(
                                    width: columnWidth,
                                    padding: EdgeInsets.all(cellPadding),
                                    child: Text('Выручка,\nвсего')),
                                Container(
                                    width: columnWidth,
                                    padding: EdgeInsets.all(cellPadding),
                                    child: Text('Выручка,\nв среднем')),
                                Container(
                                    width: columnWidth,
                                    padding: EdgeInsets.all(cellPadding),
                                    child: Text('Смены')),
                                Container(
                                    width: columnWidth,
                                    padding: EdgeInsets.all(cellPadding),
                                    child: Text('Штрафы')),
                              ],
                            ),
                          ),
                          ...list.values
                              .map(
                                (report) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[Container(height: nameHeight)],
                                    ),
                                    Container(
                                      height: nameHeight,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 1.0, color: AppColors.primaryBlend))),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                              width: columnWidth,
                                              padding: EdgeInsets.all(cellPadding),
                                              child: Text(report.total)),
                                          Container(
                                              width: columnWidth,
                                              padding: EdgeInsets.all(cellPadding),
                                              child: Text(report.totalAverage)),
                                          Container(
                                              width: columnWidth,
                                              padding: EdgeInsets.all(cellPadding),
                                              child: Text(report.revenue)),
                                          Container(
                                              width: columnWidth,
                                              padding: EdgeInsets.all(cellPadding),
                                              child: Text(report.revenueAverage)),
                                          Container(
                                              width: columnWidth,
                                              padding: EdgeInsets.all(cellPadding),
                                              child: Text(report.reportsCount)),
                                          Container(
                                              width: columnWidth,
                                              padding: EdgeInsets.all(cellPadding),
                                              child: Text(report.penaltiesCount)),
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
                    ...List.generate(
                      list.keys.length,
                      (index) => Positioned(
                        top: tableHeaderHeight + nameHeight * 2 * index,
                        child: Container(
                          height: nameHeight,
                          color: AppColors.primaryBlend,
                          padding: EdgeInsets.all(cellPadding),
                          child: Text(
                            list.keys.elementAt(index),
                          ),
                        ),
                      ),
                    )
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
