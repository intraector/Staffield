import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/router_paths.dart';
import 'package:Staffield/views/bottom_navigation.dart';
import 'package:Staffield/views/reports/report_type.dart';
import 'package:Staffield/views/reports/vmodel_view_reports.dart';
import 'package:Staffield/views/view_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewReports extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<VModelViewReports>(
        init: VModelViewReports(),
        builder: (vmodel) {
          return SafeArea(
            child: Scaffold(
              drawer: ViewDrawer(),
              appBar: AppBar(
                title: Text('ОТЧЕТЫ'),
              ),
              bottomNavigationBar: BottomNavigation(RouterPaths.reports),
              body: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 0,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('НАЧАЛО: ', style: TextStyle(color: Colors.white)),
                                InkWell(
                                  child:
                                      Text(vmodel.endDate, style: TextStyle(color: Colors.white)),
                                  onTap: () => vmodel.pickEndDate(context),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('КОНЕЦ: ', style: TextStyle(color: Colors.white)),
                                InkWell(
                                  child:
                                      Text(vmodel.startDate, style: TextStyle(color: Colors.white)),
                                  onTap: () => vmodel.pickStartDate(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text('Вид:', style: TextStyle(color: Colors.white)),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                style: Theme.of(context).primaryTextTheme.bodyText2,
                                iconEnabledColor: Colors.white,
                                dropdownColor: AppColors.primary,
                                items: ReportType.values
                                    .map((type) => DropdownMenuItem<ReportType>(
                                          value: type,
                                          child: Text(type.title),
                                        ))
                                    .toList(),
                                onChanged: (type) => vmodel.reportType = type,
                                value: vmodel.reportType,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView(
                    children: [vmodel.view],
                    shrinkWrap: true,
                  )),
                ],
              ),
            ),
          );
        },
      );
}
