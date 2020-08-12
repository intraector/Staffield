import 'package:Staffield/core/models/report.dart';
import 'package:Staffield/views/reports/views/all_amployees/chart_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:print_color/print_color.dart';

class ViewChartLine extends StatelessWidget {
  ViewChartLine(this.data);
  final ChartData data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 500,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(0)),
          gradient: LinearGradient(
            colors: const [
              Color(0xff2c274c),
              Color(0xff46426c),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 6.0, top: 20.0),
          child: LineChart(
            sampleData1(),
            swapAnimationDuration: const Duration(milliseconds: 250),
          ),
        ),
      ),
    );
  }

  LineChartData sampleData1() {
    final dates = <DateTime>[
      DateTime(2019, 8),
      DateTime(2019, 9),
      DateTime(2019, 10),
      DateTime(2019, 11),
      DateTime(2019, 12),
      DateTime(2020, 1),
      DateTime(2020, 2),
      DateTime(2020, 3),
      DateTime(2020, 4),
      DateTime(2020, 5),
    ];
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      // gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          interval: Duration(days: 1).inMilliseconds.toDouble(),
          showTitles: true,
          reservedSize: 10,
          textStyle: const TextStyle(
            color: Color(0xFFB6B6C7),
            // fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          // margin: 10,
          getTitles: (value) {
            var date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
            date = DateTime(date.year, date.month);
            if (dates.contains(date)) {
              dates.remove(date);
              return Jiffy(date).yMMM;
            } else {
              return null;
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 10000.0,
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            // fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          getTitles: (value) => value.toString(),
          // margin: 8,
          reservedSize: 40,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      ),
      lineBarsData: generateChartBarData(data.reportsByEmployee),
    );
  }
}

List<LineChartBarData> generateChartBarData(Map<String, List<Report>> data) {
  var result = <LineChartBarData>[];
  data.forEach((employeeName, reports) {
    var barData = LineChartBarData(
      spots: reports
          .map<FlSpot>((report) => FlSpot(report.periodTimestamp.toDouble(), report.total))
          .toList(),
      isCurved: true,
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
    result.add(barData);
  });
  return result;
}
