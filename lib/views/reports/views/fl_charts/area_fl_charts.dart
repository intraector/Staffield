import 'package:Staffield/views/reports/views/fl_charts/area_table.dart';
import 'package:Staffield/views/reports/views/fl_charts/components/chart_data.dart';
import 'package:Staffield/views/reports/views/fl_charts/area_line_chart.dart';
import 'package:flutter/material.dart';

class AreaFlCharts extends StatelessWidget {
  AreaFlCharts(this.data);
  final ChartData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            color: Color(0xff232d37),
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 0.0, top: 24, bottom: 5.0),
              child: data.periodValues.isEmpty
                  ? Center(
                      child: Text(
                        'Нет данных',
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    )
                  : AreaLineChart(data),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
              child: Text(
                'Подробнее',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ],
        ),
        Divider(color: Colors.transparent),
        AreaTable(data),
      ],
    );
  }
}
