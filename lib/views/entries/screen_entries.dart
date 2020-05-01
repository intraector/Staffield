import 'package:Staffield/views/entries/view_body.dart';
import 'package:flutter/material.dart';
import 'package:Staffield/views/bottom_navigation.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/router_paths.dart';
import 'package:Staffield/services/router.dart';
import 'package:Staffield/views/entries/screen_entries_vmodel.dart';
import 'package:Staffield/views/view_drawer.dart';
import 'package:print_color/print_color.dart';
import 'package:provider/provider.dart';

import 'dart:math' as math;

class ScreenEntries extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ScreenEntriesVModel(),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.primaryAccent,
            drawer: ViewDrawer(),
            bottomNavigationBar: BottomNavigation(RouterPaths.entries),
            floatingActionButton: Builder(
                builder: (context) => FloatingActionButton(
                      backgroundColor: AppColors.secondary,
                      child: Icon(Icons.ac_unit),
                      onPressed: () => Provider.of<ScreenEntriesVModel>(context, listen: false)
                          .generateRandomEntries(days: 180, recordsPerDay: 3),
                    )),
            body: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
                SliverAppBar(
                  expandedHeight: 60.0,
                  floating: false,
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
                // Selector<ScreenEntriesVModel, bool>(
                //   selector: (context, vModel) => vModel.isVisibleDateHeader,
                //   builder: (context, isVisibleDateHeader, _) => SliverPersistentHeader(
                //     pinned: true,
                //     delegate: SliverAppBarDelegate(
                //       minHeight: 0.0,
                //       maxHeight: 30.0,
                //       visibility: isVisibleDateHeader,
                //       child: Container(
                //         color: Colors.cyan,
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: <Widget>[
                //             Padding(
                //               padding: const EdgeInsets.symmetric(
                //                 horizontal: 16.0,
                //                 // vertical: 8.0,
                //               ),
                //               child: Selector<ScreenEntriesVModel, String>(
                //                   selector: (context, vModel) => vModel.currentItemDate,
                //                   builder: (context, currentItemDate, _) =>
                //                       Text(currentItemDate, style: TextStyle(fontSize: 16))),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                // SliverPadding(
                //   padding: EdgeInsets.all(0.0),
                //   sliver: SliverList(
                //     delegate: SliverChildListDelegate([
                //       Row(
                //         children: <Widget>[
                //           Expanded(child: Text('ТЕКУЩАЯ ДАТА')),
                //           IconButton(
                //             icon: Icon(Icons.date_range),
                //             onPressed: () async {
                //               // DateTime date = await showDatePicker(
                //               //   context: context,
                //               //   firstDate: DateTime(DateTime.now().year - 5),
                //               //   lastDate: DateTime(DateTime.now().year + 5),
                //               //   initialDate: DateTime.now(),
                //               // );
                //             },
                //           ),
                //         ],
                //       )
                //     ]),
                //   ),
                // ),
              ],
              body: Stack(
                children: <Widget>[
                  ViewBody(),
                  Selector<ScreenEntriesVModel, bool>(
                      selector: (context, vModel) => vModel.isVisibleDateHeader,
                      builder: (context, isVisibleDateHeader, _) => Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            visible: isVisibleDateHeader,
                            child: Selector<ScreenEntriesVModel, String>(
                                selector: (context, vModel) => vModel.currentItemDate,
                                builder: (context, currentItemDate, _) => AnimatedOpacity(
                                      opacity: isVisibleDateHeader ? 1.0 : 0.0,
                                      duration: Duration(milliseconds: 500),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 30,
                                              color: AppColors.primaryAccent,
                                              child: Text(
                                                currentItemDate,
                                                style: TextStyle(fontSize: 16, color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                          )),
                ],
              ),
            ),
          ),
        ),
      );
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
    @required this.visibility,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  final bool visibility;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => visibility ? math.max(maxHeight, minHeight) : 0.0;
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
