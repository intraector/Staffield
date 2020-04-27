import 'package:flutter/material.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/core/models/penalty.dart';
import 'package:Staffield/views/edit_entry/dialog_penalty.dart';
import 'package:Staffield/views/edit_entry/screen_edit_entry_vmodel.dart';
import 'package:Staffield/utils/string_utils.dart';

class ViewPenalties extends StatelessWidget {
  ViewPenalties(this.screenEntryVModel);
  final ScreenEditEntryVModel screenEntryVModel;
  @override
  Widget build(BuildContext context) {
    var penalties = screenEntryVModel.penalties;
    return Column(
      children: <Widget>[
        if (penalties != null)
          ...penalties.map((penalty) => ViewPenaltiesItem(penalty, screenEntryVModel)).toList()
      ],
    );
  }
}

class ViewPenaltiesItem extends StatelessWidget {
  ViewPenaltiesItem(this.penalty, this.vModel);
  final Penalty penalty;
  final ScreenEditEntryVModel vModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryBlend,
      child: InkWell(
        onTap: () async {
          var res = await showDialog<Penalty>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) =>
                DialogPenalty(penalty: penalty, screenEntryVModel: vModel),
          );

          if (res != null) vModel.updatePenalty(res);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: Row(children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    penalty.title.toUpperCase(),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(penalty.total.toString().formatCurrencyDecimal()),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
