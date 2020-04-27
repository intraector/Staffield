import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Staffield/views/bottom_navigation.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/router_paths.dart';
import 'package:Staffield/services/router.dart';
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
            // appBar: AppBar(
            //   actions: <Widget>[
            //     Consumer<ScreenEntriesVModel>(
            //       builder: (_, vModel, __) => IconButton(
            //         icon: Icon(Icons.data_usage),
            //         onPressed: () => vModel.refreshDb(),
            //       ),
            //     ),
            //     IconButton(
            //       icon: Icon(Icons.date_range),
            //       onPressed: () async {
            //         DateTime date = await showDatePicker(
            //           context: context,
            //           firstDate: DateTime(DateTime.now().year - 5),
            //           lastDate: DateTime(DateTime.now().year + 5),
            //           initialDate: DateTime.now(),
            //         );
            //       },
            //     ),
            //     IconButton(
            //       icon: Icon(Icons.add),
            //       onPressed: () =>
            //           Router.sailor.navigate(RouterPaths.editEntry, params: {'entry_uid': null}),
            //     ),
            //   ],
            // ),
            bottomNavigationBar: BottomNavigation(RouterPaths.entries),
            floatingActionButton: Consumer<ScreenEntriesVModel>(
              builder: (_, vModel, __) => FloatingActionButton(
                backgroundColor: AppColors.secondary,
                child: Icon(Icons.ac_unit),
                onPressed: () => vModel.generateRandomEntries(days: 60, recordsPerDay: 3),
              ),
            ),
            body: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
                SliverAppBar(
                  expandedHeight: 150.0,
                  // floating: true,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("СМЕНЫ ПЕРСОНАЛА",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(0, 0),
                              blurRadius: 8,
                            ),
                            Shadow(
                              color: Colors.black,
                              offset: Offset(0, 0),
                              blurRadius: 20,
                            ),
                          ],
                        )),
                    background: Image.network(
                      "https://images.squarespace-cdn.com/content/5590cbb1e4b0927589e6557c/1466375978654-MLF3R0OMYXNX5BPN9LGR/image-asset.jpeg?format=1500w&content-type=image%2Fjpeg",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  actions: <Widget>[
                    Consumer<ScreenEntriesVModel>(
                      builder: (_, vModel, __) => IconButton(
                        icon: Icon(Icons.data_usage),
                        onPressed: () => vModel.refreshDb(),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => Router.sailor
                          .navigate(RouterPaths.editEntry, params: {'entry_uid': null}),
                    ),
                  ],
                ),
                SliverPadding(
                  padding: EdgeInsets.all(0.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      Row(
                        children: <Widget>[
                          Expanded(child: Text('ТЕКУЩАЯ ДАТА')),
                          IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () async {
                              // DateTime date = await showDatePicker(
                              //   context: context,
                              //   firstDate: DateTime(DateTime.now().year - 5),
                              //   lastDate: DateTime(DateTime.now().year + 5),
                              //   initialDate: DateTime.now(),
                              // );
                            },
                          ),
                        ],
                      )
                    ]),
                  ),
                ),
              ],
              body: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Consumer<ScreenEntriesVModel>(
                      builder: (_, vModel, __) {
                        return ListView(
                          children: <Widget>[
                            ...vModel.list.map((entry) => InkWell(
                                  onTap: () => Router.sailor.navigate(RouterPaths.editEntry,
                                      params: {'entry_uid': entry.uid}),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                Expanded(child: Text(entry.name)),
                                                // Text(' ' +
                                                //     timeAndDifference(
                                                //       timestamp1: entry.timestamp,
                                                //       showDate: true,
                                                //     ).toString()),
                                                Text(entry.total),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
