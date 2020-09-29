import 'package:Staffield/views/reports/views/fl_charts/chart_data.dart';

// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class AreaChartsFlutter extends StatelessWidget {
  AreaChartsFlutter(this.data);
  final ChartData data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      width: 2000,
      height: 300,
      // child: charts.TimeSeriesChart(
      //   data.lines,
      //   animate: false,
      // ),
    ));
  }
}
