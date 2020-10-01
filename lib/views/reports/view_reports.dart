import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/routes_paths.dart';
import 'package:Staffield/views/bottom_navigation.dart';
import 'package:Staffield/views/reports/views/fl_charts/components/choose_employees.dart';
import 'package:Staffield/views/reports/views/fl_charts/components/menu_penalty_type/menu_penalty_type.dart';
import 'package:Staffield/views/reports/views/fl_charts/components/report_criteria.dart';
import 'package:Staffield/views/reports/vmodel_reports.dart';
import 'package:Staffield/views/view_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButtonHideUnderline(
                              child: DropdownButton<ReportCriterion>(
                                style: TextStyle(color: Colors.lightBlueAccent, fontSize: 20.0),
                                iconEnabledColor: Colors.white,
                                dropdownColor: AppColors.primary,
                                items: ReportCriterionMapper.dropdownItems,
                                onChanged: (value) => vmodel.criterion = value,
                                value: vmodel.criterion,
                              ),
                            ),
                            if (vmodel.criterion == ReportCriterion.penaltiesTotal)
                              MenuPenaltytype(),
                            if (vmodel.criterion == ReportCriterion.total)
                              DropdownButtonHideUnderline(
                                child: DropdownButton<MenuWageItem>(
                                  style: TextStyle(color: Colors.lightBlueAccent, fontSize: 20.0),
                                  iconEnabledColor: Colors.white,
                                  dropdownColor: AppColors.primary,
                                  items: vmodel.auxMenuWageItems,
                                  onChanged: (value) => vmodel.auxMenuCurrentValue = value,
                                  value: vmodel.auxMenuCurrentValue,
                                ),
                              ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Период: за   ', style: TextStyle(color: Colors.white)),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                style: TextStyle(color: Colors.lightBlueAccent, fontSize: 20.0),
                                iconEnabledColor: Colors.lightBlueAccent,
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
                            Text('мес. до', style: TextStyle(color: Colors.white)),
                            PlatformButton(
                              padding: EdgeInsets.only(bottom: 0.0, top: 0.0, left: 8.0),
                              // color: Colors.lightBlueAccent,
                              child: Text(
                                vmodel.startDate,
                                style: TextStyle(color: Colors.lightBlueAccent, fontSize: 20.0),
                              ),
                              onPressed: () => vmodel.pickStartDate(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Row(children: <Widget>[Flexible(child: ChooseEmployees())]),
                        vmodel.view
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
