import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/app_gradients.dart';
import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/constants/router_paths.dart';
import 'package:Staffield/services/router.dart';
import 'package:Staffield/views/entries/view_item_penalties.dart';
import 'package:Staffield/views/reports/adapted_entry_report.dart';
import 'package:flutter/material.dart';

class ViewScreenEntriesItem extends StatelessWidget {
  ViewScreenEntriesItem(this.item);
  final AdaptedEntryReport item;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Router.sailor.navigate(RouterPaths.editEntry, params: {'entry_uid': item.uid}),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: AppGradients.viciousStance,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  margin: const EdgeInsets.only(left: 5.0, top: 14.0, bottom: 0.0, right: 8.0),
                  padding: const EdgeInsets.only(left: 8.0, top: 5.0, right: 8.0),
                  child: Text(
                    item.name,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: AppTextStyles.titleBold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
            decoration: BoxDecoration(
              gradient: AppGradients.tameer,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
                bottomRight: Radius.circular(4.0),
              ),
            ),
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                            margin: EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlend,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('Выручка'),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(item.revenue),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                            margin: EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlend,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('Бонус'),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(item.interest),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                            margin: EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlend,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('Оклад'),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(item.wage),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ViewItemPenalties(item),
                    Container(
                        margin: EdgeInsets.only(top: 5.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Wrap(
                          children: <Widget>[
                            Text('Итог: ', style: AppTextStyles.bodyBoldLight),
                            Text(item.total, style: AppTextStyles.bodyBoldLight),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
