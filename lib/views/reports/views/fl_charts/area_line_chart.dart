import 'package:Staffield/views/reports/views/fl_charts/components/chart_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:Staffield/utils/string_utils.dart';

class AreaLineChart extends StatelessWidget {
  AreaLineChart(this.data);
  final ChartData data;
  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Color(0xff232d37),
          getTooltipItems: (list) => data.getTooltipItems(list),
        ),
      ),
      gridData: FlGridData(
          drawVerticalLine: true,
          show: true,
          drawHorizontalLine: true,
          horizontalInterval: data.interval,
          getDrawingVerticalLine: (_) => FlLine(
                color: Colors.blueGrey.shade800,
                strokeWidth: 1,
              ),
          getDrawingHorizontalLine: (_) => FlLine(color: Colors.blueGrey.shade800, strokeWidth: 1),
          checkToShowHorizontalLine: (val) => (val % data.interval == 0.0) ? true : false),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          interval: 1.0,
          showTitles: true,
          reservedSize: 22,
          textStyle:
              const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: data.getBottomTitle,
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) => value.toString().formatAsCurrency(),
          interval: data.interval,
          reservedSize: 80,
          margin: 4,
        ),
      ),
      borderData:
          FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minY: 0,
      maxY: data.maxCriterionValue + data.interval / 1.8,
      lineBarsData: data.lines,
    ));
  }
}
