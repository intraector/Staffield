import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/core/models/report.dart';
import 'package:flutter/material.dart';

class ViewGeneral extends StatelessWidget {
  ViewGeneral(this.list);
  final List<ReportStrings> list;
  final headerCellHeight = 40.0;
  final headerCellWidth = 100.0;
  final cellHeight = 30.0;
  final cellPadding = EdgeInsets.symmetric(horizontal: 8.0);
  @override
  Widget build(BuildContext context) {
    final TextStyle cellTextStyle = Theme.of(context).textTheme.bodyText1;
    final TextStyle headerTextStyle = cellTextStyle.copyWith(fontWeight: FontWeight.bold);
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: headerCellHeight,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: AppColors.primarySemiBlend),
                          bottom: BorderSide(width: 1.0, color: AppColors.primarySemiBlend),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                              width: headerCellWidth,
                              padding: cellPadding,
                              child: Text('Итого', style: headerTextStyle)),
                          Container(
                              width: headerCellWidth,
                              padding: cellPadding,
                              child: Text('Оклад', style: headerTextStyle)),
                          Container(
                              width: headerCellWidth,
                              padding: cellPadding,
                              child: Text('Бонус', style: headerTextStyle)),
                          Container(
                              width: headerCellWidth,
                              padding: cellPadding,
                              child: Text('Штрафы', style: headerTextStyle)),
                          Container(
                              width: headerCellWidth,
                              padding: cellPadding,
                              child: Text('Выручка', style: headerTextStyle)),
                          Container(
                              width: headerCellWidth,
                              padding: cellPadding,
                              child: Text('Смены', style: headerTextStyle)),
                          // Container(
                          //     width: headerCellWidth,
                          //     padding: cellPadding,
                          //     child: Text('Штрафы', style: headerTextStyle)),
                        ],
                      ),
                    ),
                    ...list
                        .map(
                          (report) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[Container(height: cellHeight)],
                              ),
                              Container(
                                height: cellHeight,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(width: 1.0, color: AppColors.primaryBlend))),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                        width: headerCellWidth,
                                        padding: cellPadding,
                                        child: Text(report.total, style: cellTextStyle)),
                                    Container(
                                        width: headerCellWidth,
                                        padding: cellPadding,
                                        child: Text(report.wage, style: cellTextStyle)),
                                    Container(
                                        width: headerCellWidth,
                                        padding: cellPadding,
                                        child: Text(report.bonus, style: cellTextStyle)),
                                    Container(
                                        width: headerCellWidth,
                                        padding: cellPadding,
                                        child: Text(report.penaltiesTotal, style: cellTextStyle)),
                                    Container(
                                        width: headerCellWidth,
                                        padding: cellPadding,
                                        child: Text(report.revenue, style: cellTextStyle)),
                                    Container(
                                        width: headerCellWidth,
                                        padding: cellPadding,
                                        child: Text(report.reportsCount, style: cellTextStyle)),
                                    // Container(
                                    //     width: headerCellWidth,
                                    //     padding: cellPadding,
                                    //     child: Text(report.penaltiesCount, style: cellTextStyle)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
              ...List.generate(
                list.length,
                (index) => Positioned(
                  top: headerCellHeight + cellHeight * 2 * index,
                  child: Container(
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
                    child: Text(
                      list[index].periodTitle,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
