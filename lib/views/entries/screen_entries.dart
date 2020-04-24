import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Staffield/views/bottom_navigation.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/router_paths.dart';
import 'package:Staffield/services/router.dart';
import 'package:Staffield/utils/time_and_difference.dart';
import 'package:Staffield/views/entries/screen_entries_vmodel.dart';
import 'package:Staffield/views/view_drawer.dart';
import 'package:provider/provider.dart';

class ScreenEntries extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ScreenEntriesVModel(),
        child: SafeArea(
          child: Scaffold(
            drawer: ViewDrawer(),
            appBar: AppBar(
              actions: <Widget>[
                Consumer<ScreenEntriesVModel>(
                  builder: (_, vModel, __) => IconButton(
                    icon: Icon(Icons.data_usage),
                    onPressed: () => vModel.refreshDb(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () =>
                      Router.sailor.navigate(RouterPaths.editEntry, params: {'entry_uid': null}),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigation(0),
            floatingActionButton: Consumer<ScreenEntriesVModel>(
              builder: (_, vModel, __) => FloatingActionButton(
                backgroundColor: AppColors.secondary,
                child: Icon(Icons.ac_unit),
                onPressed: () => vModel.generateRandomEntries(days: 60, recordsPerDay: 3),
              ),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Consumer<ScreenEntriesVModel>(
                    builder: (_, vModel, __) => ListView(
                      children: <Widget>[
                        ...vModel.list.map((entry) => InkWell(
                              onTap: () => Router.sailor.navigate(RouterPaths.editEntry,
                                  params: {'entry_uid': entry.uid}),
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(entry.name),
                                      Text(' ' +
                                          timeAndDifference(
                                            timestamp1: entry.timestamp,
                                            // showTime: true,
                                            showDate: true,
                                          ).toString()),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
