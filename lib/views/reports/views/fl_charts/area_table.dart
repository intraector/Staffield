import 'package:Staffield/views/reports/views/fl_charts/chart_data.dart';
import 'package:flutter/material.dart';

class AreaTable extends StatelessWidget {
  AreaTable(this.data);
  final ChartData data;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).canvasColor;
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  dividerThickness: 0.0,
                  columnSpacing: 40.0,
                  headingRowHeight: 40.0,
                  dataRowHeight: data.maxPenaltiesCount * 30,
                  columns: data.tableTitles,
                  // horizontalMargin: 10.0,
                  rows: data.tableRows,
                ),
              ),
              IgnorePointer(
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: DataTable(
                      headingRowHeight: 40.0,
                      dividerThickness: 0.0,
                      dataRowHeight: data.maxPenaltiesCount * 30,
                      columnSpacing: 50.0,
                      horizontalMargin: 0.0,
                      columns: [
                        DataColumn(
                          label: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 15.0),
                            width: 70.0,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              colors: [color, color.withOpacity(0.5)],
                              stops: [0.9, 1.0],
                            )),
                            child: Text(''),
                          ),
                        ),
                      ],
                      rows: data.getEmptyTableRows(color)),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.chevron_right, size: 36.0, color: Colors.blueAccent),
        ),
      ],
    );
  }
}
