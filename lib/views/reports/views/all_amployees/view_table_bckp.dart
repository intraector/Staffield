import 'package:Staffield/constants/app_gradients.dart';
import 'package:Staffield/core/entities/period_report.dart';
import 'package:Staffield/views/reports/period_report_ui_adapted.dart';
import 'package:Staffield/views/reports/views/all_amployees/table_data.dart';
import 'package:flutter/material.dart';

class ViewTable extends StatelessWidget {
  ViewTable(this.data);
  final TableData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(gradient: AppGradients.blueBlueish),
          child: Icon(Icons.chevron_left, size: 36.0, color: Colors.white),
        ),
        Expanded(
          child: Table(
              border: TableBorder.all(width: 1.0, color: Colors.pink),
              children: [...generateRows(data.data)]),
        ),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(gradient: AppGradients.blueBlueish),
          child: Icon(Icons.chevron_right, size: 36.0, color: Colors.grey),
        ),
      ],
    );
  }

  List<TableRow> generateRows(Map<String, List<PeriodReport>> data) {
    var output = <TableRow>[];
    var reports = data.values.first;
    for (var report in reports) {
      var reportAdapted = PeriodReportUiAdapted(report);
      var row = TableRow(children: [Text(reportAdapted.employeeName), Text(reportAdapted.total)]);
      output.add(row);
    }
    return output;
  }
}
