import 'package:Staffield/views/reports/report_adapted.dart';
import 'package:flutter/material.dart';

class ByEmployee extends StatelessWidget {
  ByEmployee(this.list);
  final List<ReportAdapted> list;
  @override
  Widget build(BuildContext context) => ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) => Row(
          children: <Widget>[
            Expanded(
                child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: ExpansionTile(
                      title: Text(list[index].name),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Text('Зарплата'),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(list[index].total),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(list[index].totalAverage),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Text('Выручка'),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(list[index].revenue),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(list[index].revenueAverage),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Text('Штрафы'),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(list[index].reportsCount),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(list[index].penaltiesTotal),
                              ),
                            ],
                          ),
                        ),
                        ...list[index].penalties.keys.map((name) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[Text(name), Text(list[index].penalties[name])],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      );
}
