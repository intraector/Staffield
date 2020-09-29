import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/routes_paths.dart';
import 'package:Staffield/views/bottom_navigation.dart';
import 'package:Staffield/views/reports/report_type.dart';
import 'package:Staffield/views/reports/views/fl_charts/components/choose_employees.dart';
import 'package:Staffield/views/reports/views/fl_charts/components/report_criteria.dart';
import 'package:Staffield/views/reports/vmodel_reports.dart';
import 'package:Staffield/views/view_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class ViewReports extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<VModelReports>(
        init: VModelReports(),
        builder: (vmodel) {
          return SafeArea(
            child: Scaffold(
              drawer: ViewDrawer(),
              appBar: AppBar(
                title: Text('ОТЧЕТЫ'),
              ),
              bottomNavigationBar: BottomNavigation(RoutesPaths.reports),
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
                        // Padding(padding: EdgeInsets.only(top: 10.0)),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: <Widget>[
                        //     Row(
                        //       children: <Widget>[
                        //         Text('НАЧАЛО: ', style: TextStyle(color: Colors.white)),
                        //         InkWell(
                        //           child:
                        //               Text(vmodel.endDate, style: TextStyle(color: Colors.white)),
                        //           onTap: () => vmodel.pickEndDate(context),
                        //         ),
                        //       ],
                        //     ),
                        //     Row(
                        //       children: <Widget>[
                        //         Text('КОНЕЦ: ', style: TextStyle(color: Colors.white)),
                        //         InkWell(
                        //           child:
                        //               Text(vmodel.startDate, style: TextStyle(color: Colors.white)),
                        //           onTap: () => vmodel.pickStartDate(context),
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: <Widget>[
                        //     Padding(
                        //       padding: const EdgeInsets.only(right: 8.0),
                        //       child: Text('Вид:', style: TextStyle(color: Colors.white)),
                        //     ),
                        //     DropdownButtonHideUnderline(
                        //       child: DropdownButton(
                        //         style: Theme.of(context).primaryTextTheme.bodyText2,
                        //         iconEnabledColor: Colors.white,
                        //         dropdownColor: AppColors.primary,
                        //         items: ReportType.values
                        //             .map((type) => DropdownMenuItem<ReportType>(
                        //                   value: type,
                        //                   child: Text(type.title),
                        //                 ))
                        //             .toList(),
                        //         onChanged: (type) => vmodel.reportType = type,
                        //         value: vmodel.reportType,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text('Месяцы: ', style: TextStyle(color: Colors.white)),
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<int>(
                                    style: Theme.of(context).primaryTextTheme.bodyText2,
                                    iconEnabledColor: Colors.white,
                                    dropdownColor: AppColors.primary,
                                    items: List<int>.generate(12, (index) => index + 1)
                                        .map((index) => DropdownMenuItem<int>(
                                              value: index,
                                              child: Text(
                                                index.toString(),
                                                softWrap: false,
                                                overflow: TextOverflow.fade,
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (index) => vmodel.periodsAmount = index,
                                    value: vmodel.periodsAmount,
                                  ),
                                ),
                              ],
                            ),
                            Flexible(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: <Widget>[
                                    Text('Показатель: ', style: TextStyle(color: Colors.white)),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<ReportCriterion>(
                                        style: Theme.of(context).primaryTextTheme.bodyText2,
                                        iconEnabledColor: Colors.white,
                                        dropdownColor: AppColors.primary,
                                        items: ReportCriterionMapper.criteria,
                                        onChanged: (value) => vmodel.criterion = value,
                                        value: vmodel.criterion,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        vmodel.view,
                        Row(children: <Widget>[Flexible(child: ChooseEmployees())]),
                      ],
                      shrinkWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
