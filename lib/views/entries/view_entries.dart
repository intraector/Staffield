import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/views/common/sliver_delegate.dart';
import 'package:Staffield/views/entries/views/area_sliver_appbar.dart';
import 'package:Staffield/views/entries/views/area_body/area_body.dart';
import 'package:flutter/material.dart';
import 'package:Staffield/views/bottom_navigation.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/routes_paths.dart';
import 'package:Staffield/constants/routes.dart';
import 'package:Staffield/views/entries/vmodel_entries.dart';
import 'package:Staffield/views/view_drawer.dart';
import 'package:get/get.dart';

class ViewEntries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VModelEntries>(
        init: VModelEntries(),
        builder: (vmodel) {
          return SafeArea(
            child: Scaffold(
              drawer: ViewDrawer(),
              bottomNavigationBar: BottomNavigation(RoutesPaths.entries),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () =>
                    Routes.sailor.navigate(RoutesPaths.editEntry, params: {'entry_uid': null}),
              ),
              backgroundColor: AppColors.primaryAccent,
              body: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
                  AreaSliverAppBar(vModel: vmodel),
                  SliverPersistentHeader(
                      pinned: true,
                      delegate: SliverAppBarDelegate(
                          minHeight: 44.0,
                          maxHeight: 44.0,
                          child: Container(
                            height: 44.0,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                OutlineButton(
                                  borderSide: BorderSide(color: AppColors.primaryMiddle),
                                  child:
                                      Text(vmodel.startTimestampLabel, style: AppTextStyles.button),
                                  onPressed: () => vmodel.setEndTimestamp(context: context),
                                ),
                              ],
                            ),
                          ))),
                ],
                body: AreaBody(),
              ),
            ),
          );
        });
  }
}
