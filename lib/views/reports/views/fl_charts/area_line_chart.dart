import 'package:Staffield/views/reports/views/fl_charts/chart_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:Staffield/utils/string_utils.dart';

class AreaLineChart extends StatelessWidget {
  AreaLineChart(this.data);
  final ChartData data;
  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
      // extraLinesData: ExtraLinesData(horizontalLines: [
      //   HorizontalLine(
      //     y: data.maxCriterionValue,
      //     color: Colors.white,
      //     label: HorizontalLineLabel(show: true, style: TextStyle(color: Colors.white)),
      //   )
      // ]),
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
          checkToShowHorizontalLine: (val) {
            print(val.toString() + ' ' + data.interval.toString());
            // return true;
            if (data.maxCriterionValue < val) return true;
            // return false;
            return (val % data.interval == 0.0) ? true : false;
          }),
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
          getTitles: (value) => value.toString().formatInt,
          interval: data.interval,
          reservedSize: 80,
          margin: 4,
        ),
      ),
      borderData:
          FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      // minX: 0,
      // maxX: 11,
      minY: 0,
      maxY: data.maxCriterionValue + data.interval / 1.8,
      lineBarsData: data.lines,
    ));
  }
}
