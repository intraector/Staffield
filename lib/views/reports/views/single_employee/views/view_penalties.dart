import 'package:Staffield/core/models/report.dart';
import 'package:flutter/material.dart';

class ViewPenalties extends StatelessWidget {
  ViewPenalties(this.list);
  final List<ReportStrings> list;
  final cellPadding = EdgeInsets.only(left: 10.0);
  @override
  Widget build(BuildContext context) {
    // Print.yellow('||| list : $list');
    return ListView(
      shrinkWrap: true,
      children: <Widget>[...list.map((e) => _MonthPenalties(e))],
    );
  }
}

class _MonthPenalties extends StatelessWidget {
  _MonthPenalties(this.report);
  final ReportStrings report;
  final cellHeight = 30.0;
  final cellPadding = EdgeInsets.symmetric(horizontal: 8.0);
  final headerCellHeight = 40.0;
  final headerCellWidth = 100.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: cellHeight,
          padding: cellPadding,
          decoration: BoxDecoration(
            color: Theme.of(context).dividerColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.elliptical(25.0, 50.0),
              bottomRight: Radius.elliptical(25.0, 50.0),
            ),
          ),
          child: Text(report.periodTitle, style: Theme.of(context).textTheme.bodyText1),
        ),
        ...report.penalties.map((penalty) => Row(children: <Widget>[
              Padding(
                padding: cellPadding,
                child: Text(penalty.typeTitle),
              ),
              Padding(
                padding: cellPadding,
                child: Text(penalty.totalString),
              ),
              Padding(
                padding: cellPadding,
                child: Text(penalty.unitTitle),
              ),
              Padding(
                padding: cellPadding,
                child: Text(penalty.unitString),
              ),
            ]))
      ],
    );
  }
}

List<Widget> generateItems(Map<String, String> list) {
  var result = <Widget>[];
  list.forEach((title, value) => result.add(Row(children: <Widget>[Text(title), Text(value)])));
  return result;
}
