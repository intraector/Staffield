import 'package:Staffield/constants/app_gradients.dart';
import 'package:Staffield/views/reports/views/all_amployees/chart_data.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';

class ViewChartBezier extends StatelessWidget {
  ViewChartBezier(this.data);
  final ChartData data;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(gradient: AppGradients.blueBlueish),
            child: Icon(Icons.chevron_left, size: 36.0, color: Colors.white),
          ),
          Expanded(
            child: BezierChart(
              bezierChartScale: BezierChartScale.MONTHLY,
              fromDate: data.first,
              toDate: data.last,
              // bezierChartAggregation: BezierChartAggregation.AVERAGE,
              // selectedDate: data.dates.last,
              series: data.bezierLines,
              config: BezierChartConfig(
                xLinesColor: Colors.red,
                showDataPoints: true,
                pinchZoom: false,
                updatePositionOnTap: true,
                backgroundGradient: AppGradients.blueBlueish,
                displayLinesXAxis: true,
                verticalIndicatorColor: Colors.red,
                displayYAxis: true,
                stepsYAxis: 10000,
                startYAxisFromNonZeroValue: true,
                verticalIndicatorStrokeWidth: 20.0,
                showVerticalIndicator: true,
                backgroundColor: Colors.grey,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(gradient: AppGradients.blueBlueish),
            child: Icon(Icons.chevron_right, size: 36.0, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
