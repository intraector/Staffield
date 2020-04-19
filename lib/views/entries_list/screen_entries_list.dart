import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:staff_time/constants/app_colors.dart';
import 'package:staff_time/constants/sailor_paths.dart';
import 'package:staff_time/services/router.dart';
import 'package:staff_time/utils/time_and_difference.dart';
import 'package:staff_time/views/entries_list/screen_entries_vmodel.dart';
import 'package:staff_time/views/view_drawer.dart';

class ScreenEntriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Injector(
        inject: [Inject<ScreenEntriesVModel>(() => ScreenEntriesVModel())],
        builder: (context) {
          final vModel = Injector.get<ScreenEntriesVModel>(context: context);
          return SafeArea(
              child: Scaffold(
            drawer: ViewDrawer(),
            appBar: AppBar(),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.secondary,
              child: Icon(Icons.add),
              onPressed: () =>
                  Router.sailor.navigate(SailorPaths.newEntry, params: {'entry_uid': null}),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      ...vModel.list.map((entry) => InkWell(
                            onTap: () => Router.sailor
                                .navigate(SailorPaths.newEntry, params: {'entry_uid': entry.uid}),
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: <Widget>[
                                    Text(entry.name),
                                    Text(' ' +
                                        timeAndDifference(
                                          timestamp1: entry.timestamp,
                                          showTime: true,
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
              ],
            ),
          ));
        },
      );
}
