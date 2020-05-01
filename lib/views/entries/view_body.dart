import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/constants/router_paths.dart';
import 'package:Staffield/services/router.dart';
import 'package:Staffield/views/entries/screen_entries_vmodel.dart';
import 'package:Staffield/views/entries/view_item_penalties.dart';
import 'package:Staffield/views/reports/adapted_entry_report.dart';
import 'package:flutter/material.dart';
import 'package:print_color/print_color.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ViewBody extends StatefulWidget {
  @override
  _ViewBodyState createState() => _ViewBodyState();
}

class _ViewBodyState extends State<ViewBody> {
  final itemPositionsListener = ItemPositionsListener.create();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    itemPositionsListener.itemPositions.addListener(() => listenerItemPosition(context));
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Selector<ScreenEntriesVModel, List<AdaptedEntryReport>>(
              selector: (context, vModel) => vModel.cache,
              builder: (_, list, __) {
                Print.green('||| {list.length} : ${list.length}');
                return NotificationListener<ScrollNotification>(
                  onNotification: (notif) {
                    if (notif.metrics.extentAfter < 200) {
                      Provider.of<ScreenEntriesVModel>(context, listen: false).fetchNextChunk();
                    }
                    return true;
                  },
                  child: Scrollbar(
                    child: ScrollablePositionedList.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: list.length,
                      itemPositionsListener: itemPositionsListener,
                      itemBuilder: (context, index) {
                        if (list[index].isDateLabel)
                          return Container(
                            alignment: Alignment.center,
                            height: 22,
                            color: AppColors.primaryAccent,
                            child: Text(list[index].date,
                                style: TextStyle(fontSize: 16, color: Colors.white)),
                          );
                        else
                          return InkWell(
                            onTap: () => Router.sailor.navigate(RouterPaths.editEntry,
                                params: {'entry_uid': list[index].uid}),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(list[index].name,
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                            style: AppTextStyles.body
                                                .copyWith(fontWeight: FontWeight.bold)),
                                        Text(list[index].total,
                                            style: AppTextStyles.body
                                                .copyWith(fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 5.0)),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Wrap(
                                            alignment: WrapAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8.0, vertical: 5.0),
                                                margin: EdgeInsets.all(3.0),
                                                decoration: BoxDecoration(
                                                    color: AppColors.primaryBlend,
                                                    borderRadius: BorderRadius.circular(5.0)),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    Text('Выручка'),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8.0),
                                                      child: Text(list[index].revenue),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8.0, vertical: 5.0),
                                                margin: EdgeInsets.all(3.0),
                                                color: AppColors.primaryBlend,
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    Text('Бонус'),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8.0),
                                                      child: Text(list[index].interest),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8.0, vertical: 5.0),
                                                margin: EdgeInsets.all(3.0),
                                                color: AppColors.primaryBlend,
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    Text('Оклад'),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 8.0),
                                                      child: Text(list[index].wage),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    ViewItemPenalties(list[index]),
                                  ],
                                ),
                              ),
                            ),
                          );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );

  void listenerItemPosition(BuildContext context) =>
      Provider.of<ScreenEntriesVModel>(context, listen: false)
          .setCurrentItemDate(itemPositionsListener.itemPositions.value.first.index);
}
