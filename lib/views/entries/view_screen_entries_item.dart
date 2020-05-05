import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/app_gradients.dart';
import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/constants/router_paths.dart';
import 'package:Staffield/services/router.dart';
import 'package:Staffield/views/reports/adapted_entry_report.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
                    style: AppTextStyles.bodyBoldLight,
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
                        alignment: WrapAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                            margin: EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              color: AppColors.primaryAccent,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(MdiIcons.cash, color: AppColors.white),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    item.wage,
                                    style: AppTextStyles.bodyBoldLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                            margin: EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              color: AppColors.primaryAccent,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(MdiIcons.cashPlus, color: AppColors.white),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    item.bonus,
                                    style: AppTextStyles.bodyBoldLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                            margin: EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              color: AppColors.primaryAccent,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(MdiIcons.cashMinus, color: AppColors.white),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    item.penaltiesTotal,
                                    style: AppTextStyles.bodyBoldLight,
                                  ),
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                      margin: EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: AppColors.primaryAccent,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(MdiIcons.cashMultiple, color: AppColors.white),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              item.revenue,
                              style: AppTextStyles.bodyBoldLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                      margin: EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: AppColors.primaryAccent,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(MdiIcons.brightnessPercent, color: AppColors.white),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              item.interest,
                              style: AppTextStyles.bodyBoldLight,
                            ),
                          ),
                        ],
                      ),
                    ),
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
