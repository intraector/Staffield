import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/core/entities/penalty.dart';
import 'package:Staffield/views/reports/report_ui_adapted.dart';
import 'package:flutter/material.dart';

class ListEmployees extends StatelessWidget {
  ListEmployees(this.list);
  final List<ReportUiAdapted> list;
  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(list[index].name,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
                          Text(list[index].total,
                              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 5.0)),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Wrap(
                              alignment: WrapAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                                  margin: EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryBlend,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('Выручка'),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(list[index].revenue),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                                  margin: EdgeInsets.all(3.0),
                                  color: AppColors.primaryBlend,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('Бонус'),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(list[index].interest),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                                  margin: EdgeInsets.all(3.0),
                                  color: AppColors.primaryBlend,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('Оклад'),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(list[index].wage),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (list[index].penalties.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                      Column(
                        children: <Widget>[
                          ...list[index].penalties.map(
                                (penalty) => Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 0.5,
                                          color: isLastItem(list[index], penalty)
                                              ? AppColors.primaryMiddle
                                              : Colors.transparent),
                                      top: BorderSide(width: 0.5, color: AppColors.primaryMiddle),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        // Container(
                                        //     // color: Colors.cyan,
                                        //     width: 100,
                                        //     alignment: Alignment.centerLeft,
                                        //     child: Text(penalty.title)),
                                        Container(
                                          width: 50,
                                          alignment: containsTime(list[index])
                                              ? Alignment.center
                                              : Alignment.centerRight,
                                          child: Text(penalty.total),
                                        ),
                                        if (containsTime(list[index]))
                                          Container(
                                              alignment: Alignment.centerRight,
                                              width: 50,
                                              child: Text(penalty.units)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  bool containsTime(ReportUiAdapted report) =>
      report.penalties.any((penalty) => penalty.units != '');

  bool isLastItem(ReportUiAdapted report, PenaltyStrings penalty) =>
      report.penalties.indexOf(penalty) == report.penalties.length - 1;
}
