import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/views/common/sliver_delegate.dart';
import 'package:Staffield/views/entries/view_screen_entries_body.dart';
import 'package:Staffield/views/entries/views/entries_sliver_appbar.dart';
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
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
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
              backgroundColor: AppColors.primaryAccent,
              body: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
                  EntriesSliverAppBar(vModel: vModel),
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
                                  blurRadius: 3,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Selector<ScreenEntriesVModel, String>(
                                    selector: (context, vModel) => vModel.startTimestampLabel,
                                    builder: (context, startTimestampLabel, _) => OutlineButton(
                                          borderSide: BorderSide(color: AppColors.primaryMiddle),
                                          child: Text(startTimestampLabel,
                                              style: AppTextStyles.button),
                                          onPressed: () => vModel.setEndTimestamp(context: context),
                                        )),
                              ],
                            ),
                          ))),
                ],
                body: ViewScreenEntriesBody(),
              ),
            ),
          );
        },
      ),
    );
  }
}
