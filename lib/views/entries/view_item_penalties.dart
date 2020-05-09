import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/core/models/penalty.dart';
import 'package:Staffield/views/reports/adapted_entry_report.dart';
import 'package:flutter/material.dart';

class ViewItemPenalties extends StatelessWidget {
  ViewItemPenalties(this.item);
  final AdaptedEntryReport item;
  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          if (item.penalties.isNotEmpty) Padding(padding: EdgeInsets.only(top: 10.0)),
          ...item.penalties.map(
            (penalty) => Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      width: 0.5,
                      color:
                          isLastItem(item, penalty) ? AppColors.primaryMiddle : Colors.transparent),
                  top: BorderSide(width: 0.5, color: AppColors.primaryMiddle),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Container(
                    //     width: 100,
                    //     alignment: Alignment.centerLeft,
                    //     child: Text(penalty.title, style: AppTextStyles.small1Light)),
                    Container(
                      width: 50,
                      alignment: containsTime(item) ? Alignment.center : Alignment.centerRight,
                      child: Text(penalty.total, style: AppTextStyles.small1Light),
                    ),
                    if (containsTime(item))
                      Container(
                          alignment: Alignment.centerRight,
                          // width: 50,
                          child: Text(penalty.time, style: AppTextStyles.small1Light)),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  bool containsTime(AdaptedEntryReport report) =>
      report.penalties.any((penalty) => penalty.time != '');

  bool isLastItem(AdaptedEntryReport report, PenaltyReport penalty) =>
      report.penalties.indexOf(penalty) == report.penalties.length - 1;
}
