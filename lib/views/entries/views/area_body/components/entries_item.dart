import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/app_font_family.dart';
import 'package:Staffield/constants/app_fonts.dart';
import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/constants/routes_paths.dart';
import 'package:Staffield/constants/routes.dart';
import 'package:Staffield/views/common/data_chip.dart';
import 'package:Staffield/views/reports/report_ui_adapted.dart';
import 'package:flutter/material.dart';

class EntriesItem extends StatelessWidget {
  EntriesItem(this.item);
  final ReportUiAdapted item;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Routes.sailor.navigate(RoutesPaths.editEntry, params: {'entry_uid': item.uid}),
      child: Container(
        margin: EdgeInsets.only(left: 6.0, right: 6.0, bottom: 3.0, top: 3.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 15.0, top: 12.0, bottom: 2.0, right: 8.0),
                    child: Text(
                      item.employee.name,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontFamily: AppFontFamily.ptsans,
                        fontSize: AppFontSize.title1,
                        color: AppColors.primary,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        DataChip(value: item.wage, label: 'ОКЛАД'),
                        Icon(Icons.add, size: 18.0),
                        DataChip(value: item.bonus, label: 'БОНУС'),
                        Icon(Icons.remove, size: 18.0),
                        DataChip(value: item.penaltiesTotal, label: 'ШТРАФЫ'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 5.0),
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Text('Итого: ',
                          style: TextStyle(fontSize: AppFontSize.small1, color: AppColors.primary)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0),
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                      decoration: BoxDecoration(
                          // gradient: LinearGradient(colors: [Colors.white, Colors.blue.shade100]),
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            bottomRight: Radius.circular(4.0),
                          )),
                      child: Text(item.total, style: AppTextStyles.digitsBold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
