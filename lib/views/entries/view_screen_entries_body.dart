import 'package:Staffield/constants/app_gradients.dart';
import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/views/entries/screen_entries_vmodel.dart';
import 'package:Staffield/views/entries/view_screen_entries_item.dart';
import 'package:Staffield/views/reports/adapted_entry_report.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ViewScreenEntriesBody extends StatefulWidget {
  @override
  _ViewScreenEntriesBodyState createState() => _ViewScreenEntriesBodyState();
}

class _ViewScreenEntriesBodyState extends State<ViewScreenEntriesBody> {
  final itemPositionsListener = ItemPositionsListener.create();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var vModel = Provider.of<ScreenEntriesVModel>(context, listen: false);
    itemPositionsListener.itemPositions.addListener(() => listenerItemPosition(vModel));
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Selector<ScreenEntriesVModel, List<AdaptedEntryReport>>(
              selector: (context, vModel) => vModel.cache,
              builder: (_, list, __) => list.length == 0
                  ? Center(child: CircularProgressIndicator())
                  : NotificationListener<ScrollNotification>(
                      onNotification: (notif) {
                        if (notif.metrics.extentAfter < 200)
                          Provider.of<ScreenEntriesVModel>(context, listen: false).fetchNextChunk();
                        return true;
                      },
                      child: Scrollbar(
                        child: ScrollablePositionedList.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: list.length,
                            itemPositionsListener: itemPositionsListener,
                            itemBuilder: (context, index) => list[index].isDateLabel
                                ? Container(
                                    padding: EdgeInsets.only(left: 8.0),
                                    margin: EdgeInsets.only(top: 14.0, left: 5.0),
                                    alignment: Alignment.centerLeft,
                                    height: 22,
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
                                    child: Text(list[index].date, style: AppTextStyles.dateLabel),
                                  )
                                : ViewScreenEntriesItem(list[index])),
                      ),
                    ),
            ),
          ),
        ],
      );

  void listenerItemPosition(ScreenEntriesVModel vModel) =>
      vModel.setCurrentItemDate(itemPositionsListener.itemPositions.value.first.index);
}
