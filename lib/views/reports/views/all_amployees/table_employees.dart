import 'package:Staffield/views/reports/views/all_amployees/table_data.dart';
import 'package:Staffield/views/reports/views/all_amployees/view_table.dart';
import 'package:flutter/material.dart';

class TableEmployees extends StatelessWidget {
  TableEmployees(this.data);
  final TableData data;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        ViewTable(data),
      ],
    );
  }
}
