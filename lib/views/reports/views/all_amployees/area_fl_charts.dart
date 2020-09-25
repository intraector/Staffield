import 'package:Staffield/views/reports/views/all_amployees/chart_data.dart';
import 'package:Staffield/views/reports/views/all_amployees/dropdown_employees.dart';
import 'package:Staffield/views/reports/vmodel_view_reports.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AreaFlCharts extends StatelessWidget {
  AreaFlCharts(this.data);
  final ChartData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // GetBuilder<VModelViewReports>(
        //   builder: (vmodel) => Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: <Widget>[
        //       Flexible(
        //         child: DropdownButton<Employee>(
        //           items: vmodel.employeesList
        //               .map((employee) =>
        //                   DropdownMenuItem(value: employee, child: Text(employee.name)))
        //               .toList(),
        //           value: vmodel.employee,
        //           onChanged: (uid) => vmodel.employee = uid,
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        GetBuilder<VModelViewReports>(
          builder: (vmodel) => Row(
            children: <Widget>[
              Flexible(child: DropdownEmployees(vmodel)),
            ],
          ),
        ),
        AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            color: Color(0xff232d37),
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 0.0, top: 24, bottom: 5.0),
              child: data.bottomValues.isEmpty
                  ? Center(
                      child: Text(
                        'Нет данных',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    )
                  : AreaLinaChart(data),
            ),
          ),
        ),
      ],
    );
  }
}

class AreaLinaChart extends StatelessWidget {
  AreaLinaChart(this.data);
  final ChartData data;
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
      lineTouchData: LineTouchData(enabled: true),
      gridData: FlGridData(
          drawVerticalLine: true,
          show: true,
          drawHorizontalLine: true,
          getDrawingVerticalLine: (_) => FlLine(
                color: Colors.blueGrey.shade800,
                strokeWidth: 1,
              ),
          getDrawingHorizontalLine: (_) => FlLine(
                color: Colors.blueGrey.shade800,
                strokeWidth: 1,
              ),
          checkToShowHorizontalLine: (val) => (val % 5000 == 0.0) ? true : false),
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
          getTitles: (value) => '₽ ' + value.toInt().toString(),
          interval: 5000,
          reservedSize: 80,
          margin: 4,
        ),
      ),
      borderData:
          FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      // minX: 0,
      // maxX: 11,
      minY: 0,
      // maxY: 6,
      lineBarsData: [...buildLines(data)],
    ));
  }
}

List<LineChartBarData> buildLines(ChartData data) {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  var list = <LineChartBarData>[];
  for (var key in data.spots.keys) {
    list.add(
      LineChartBarData(
        spots: data.spots[key],
        isCurved: true,
        colors: [
          ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2),
          ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2),
        ],
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(show: false, colors: [
          ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2).withOpacity(0.1),
          ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2).withOpacity(0.1),
        ]),
      ),
    );
  }
  return list;
}
