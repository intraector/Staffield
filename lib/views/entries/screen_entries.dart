import 'package:Staffield/constants/app_gradients.dart';
import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/views/entries/view_screen_entries_body.dart';
import 'package:flutter/material.dart';
import 'package:Staffield/views/bottom_navigation.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/router_paths.dart';
import 'package:Staffield/services/router.dart';
import 'package:Staffield/views/entries/screen_entries_vmodel.dart';
import 'package:Staffield/views/view_drawer.dart';
import 'package:provider/provider.dart';

import 'dart:math' as math;

class ScreenEntries extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ScreenEntriesVModel(),
        child: Builder(
          builder: (context) {
            var vModel = Provider.of<ScreenEntriesVModel>(context, listen: false);
            return SafeArea(
              child: Scaffold(
                drawer: ViewDrawer(),
                bottomNavigationBar: BottomNavigation(RouterPaths.entries),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: AppColors.secondary,
                  child: Icon(Icons.add),
                  onPressed: () =>
                      Router.sailor.navigate(RouterPaths.editEntry, params: {'entry_uid': null}),
                ),
                body: Container(
                  // color: Colors.green,
                  decoration:
                      BoxDecoration(gradient: LinearGradient(colors: AppGradientsColors.marble)),
                  child: NestedScrollView(
                    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
                        <Widget>[
                      SliverAppBar(
                        expandedHeight: 150.0,
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
                            icon: Icon(Icons.ac_unit),
                            onPressed: () =>
                                vModel.generateRandomEntries(days: 180, recordsPerDay: 3),
                          ),
                        ],
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                            decoration: BoxDecoration(
                              gradient: AppGradients.solidStone,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 0,
                                  blurRadius: 3,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Selector<ScreenEntriesVModel, String>(
                                    selector: (context, vModel) => vModel.currentItemDate,
                                    builder: (context, currentItemDate, _) =>
                                        Text(currentItemDate, style: AppTextStyles.dateLabel)),
                                Selector<ScreenEntriesVModel, String>(
                                  selector: (context, vModel) => vModel.startTimestampLabel,
                                  builder: (context, startTimestampLabel, _) => InkWell(
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8.0,
                                            horizontal: 12.0,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: AppGradients.blueBlueish,
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          child: Text(startTimestampLabel,
                                              style: AppTextStyles.button)),
                                      onTap: () => vModel.setEndTimestamp(context: context)),
                                ),
                                //
                              ],
                            ),
                          )
                        ]),
                      ),
                      // SliverPersistentHeader(
                      //   pinned: true,
                      //   delegate: SliverAppBarDelegate(
                      //     minHeight: 0.0,
                      //     maxHeight: 28.0,
                      //     child: Container(
                      //       decoration: BoxDecoration(gradient: AppGradients.jungle),
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: <Widget>[
                      //           Padding(
                      //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      //             child: Selector<ScreenEntriesVModel, String>(
                      //                 selector: (context, vModel) => vModel.currentItemDate,
                      //                 builder: (context, currentItemDate, _) =>
                      //                     Text(currentItemDate, style: AppTextStyles.dateLabel)),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                    body: ViewScreenEntriesBody(),
                  ),
                ),
              ),
            );
          },
        ),
      );
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
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
