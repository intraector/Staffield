import 'package:Staffield/views/reports/report_by_employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TableData extends StatelessWidget {
  TableData(this.list);
  final List<ReportByEmployee> list;
  @override
  Widget build(BuildContext context) => Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Colors.grey[300],
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          DataTable(
                              horizontalMargin: 8.0,
                              headingRowHeight: 40.0,
                              columnSpacing: 10.0,
                              columns: <DataColumn>[
                                DataColumn(label: Text('Сотрудник')),
                              ],
                              rows: [
                                ...list
                                    .map(
                                      (report) => DataRow(
                                        cells: <DataCell>[
                                          DataCell(Text(report.name)),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ])
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:
                        DataTable(columnSpacing: 0.0, headingRowHeight: 40.0, columns: <DataColumn>[
                      DataColumn(numeric: true, label: Text('З/П,\nвсего')),
                      DataColumn(
                          numeric: true, label: Text('З/П,\nв среднем', textAlign: TextAlign.end)),
                      DataColumn(
                          numeric: true, label: Text('Выручка,\nвсего', textAlign: TextAlign.end)),
                      DataColumn(
                          numeric: true,
                          label: Text('Выручка,\nв среднем', textAlign: TextAlign.end)),
                      DataColumn(numeric: true, label: Text('Смены')),
                      DataColumn(numeric: true, label: Text('Штрафы')),
                    ], rows: [
                      ...list
                          .map(
                            (report) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(report.total)),
                                DataCell(Text(report.totalAverage)),
                                DataCell(Text(report.revenue)),
                                DataCell(Text(report.revenueAverage)),
                                DataCell(Text(report.reportsCount)),
                                DataCell(Text(report.penaltiesCount)),
                              ],
                            ),
                          )
                          .toList(),
                    ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
