import 'package:Staffield/constants/router_paths.dart';
import 'package:Staffield/views/bottom_navigation.dart';
import 'package:Staffield/views/reports/report_adapted.dart';
import 'package:Staffield/views/reports/report_type.dart';
import 'package:Staffield/views/reports/screen_reports_vmodel.dart';
import 'package:Staffield/views/view_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenReports extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ScreenReportsVModel(),
        child: Builder(
          builder: (context) {
            var vModel = Provider.of<ScreenReportsVModel>(context, listen: false);
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
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Selector<ScreenReportsVModel, String>(
                                  selector: (context, vModel) => vModel.startDate,
                                  builder: (context, startDate, _) => Row(
                                    children: <Widget>[
                                      Text('НАЧАЛО: '),
                                      InkWell(
                                        child: Text(vModel.startDate),
                                        onTap: () => vModel.pickStartDate(context),
                                      ),
                                    ],
                                  ),
                                ),
                                Selector<ScreenReportsVModel, String>(
                                  selector: (context, vModel) => vModel.endDate,
                                  builder: (context, startDate, _) => Row(
                                    children: <Widget>[
                                      Text('КОНЕЦ: '),
                                      InkWell(
                                        child: Text(vModel.endDate),
                                        onTap: () => vModel.pickEndDate(context),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Selector<ScreenReportsVModel, ReportType>(
                                    selector: (context, vModel) => vModel.reportType,
                                    builder: (context, reportType, _) => DropdownButton(
                                          items: ReportType.values
                                              .map((type) => DropdownMenuItem<ReportType>(
                                                    value: type,
                                                    child: Text(type.title),
                                                  ))
                                              .toList(),
                                          onChanged: (type) => vModel.reportType = type,
                                          value: reportType,
                                        )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Selector<ScreenReportsVModel, Future<List<ReportAdapted>>>(
                        selector: (context, vModel) => vModel.reportData,
                        builder: (context, reportData, _) => FutureBuilder<List<ReportAdapted>>(
                          future: reportData,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState != ConnectionState.done)
                              return Center(child: CircularProgressIndicator());
                            else
                              return vModel.getView(snapshot.data);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
}
