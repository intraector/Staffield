import 'package:Staffield/constants/app_gradients.dart';
import 'package:Staffield/core/models/report.dart';
import 'package:Staffield/views/reports/views/all_amployees/table_data.dart';
import 'package:flutter/material.dart';
import 'package:print_color/print_color.dart';

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
        Flexible(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(columns: [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('total')),
            ], rows: [
              ...generateRows(data.data)
            ]),
          ),
        ),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(gradient: AppGradients.blueBlueish),
          child: Icon(Icons.chevron_right, size: 36.0, color: Colors.grey),
        ),
      ],
    );
  }

  List<DataRow> generateRows(Map<String, List<Report>> data) {
    var output = <DataRow>[];
    var reports = data.values.first;
    for (var report in reports) {
      var strings = report.strings;
      Print.yellow('||| {strings.employeeName} : ${strings.employeeName}');
      Print.yellow('||| {strings.total} : ${strings.total}');
      var row =
          DataRow(cells: [DataCell(Text(strings.employeeName)), DataCell(Text(strings.total))]);
      output.add(row);
    }
    return output;
  }
}
