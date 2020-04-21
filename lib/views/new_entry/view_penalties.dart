import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/models/penalty.dart';
import 'package:Staffield/views/new_entry/dialog_penalty.dart';
import 'package:Staffield/views/new_entry/screen_entry_vmodel.dart';
import 'package:Staffield/utils/string_utils.dart';

class ViewPenalties extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenEntryVModel = Injector.getAsReactive<ScreenEntryVModel>(context: context);
    var penalties = screenEntryVModel.state.penalties;
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
  final ReactiveModel<ScreenEntryVModel> vModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryBlend,
      child: InkWell(
        onTap: () async {
          var res = await showDialog<Penalty>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => DialogPenalty(penalty),
          );

          if (res != null) vModel.setState((state) => state.updatePenalty(res));
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
