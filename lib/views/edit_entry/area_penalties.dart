import 'package:Staffield/views/edit_entry/dialog_penalty/dialog_penalty.dart';
import 'package:flutter/material.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/core/entities/penalty.dart';
import 'package:Staffield/views/edit_entry/vmodel_edit_entry.dart';
import 'package:Staffield/utils/string_utils.dart';

class AreaPenalties extends StatelessWidget {
  AreaPenalties(this.vmodelEditEntry);
  final VModelEditEntry vmodelEditEntry;
  @override
  Widget build(BuildContext context) {
    var penalties = vmodelEditEntry.penalties;
    return Column(
      children: <Widget>[
        if (penalties != null)
          ...penalties.map((penalty) => ViewPenaltiesItem(penalty, vmodelEditEntry)).toList()
      ],
    );
  }
}

class ViewPenaltiesItem extends StatelessWidget {
  ViewPenaltiesItem(this.penalty, this.vmodel);
  final Penalty penalty;
  final VModelEditEntry vmodel;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: AppColors.primaryBlend,
      child: InkWell(
        onTap: () async {
          var res = await showDialog<Penalty>(
            context: context,
            builder: (BuildContext context) =>
                DialogPenalty(penalty: penalty, screenEntryVModel: vmodel),
          );

          if (res != null) vmodel.updatePenalty(res);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: Row(children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    vmodel.getPenaltyType(penalty.typeUid).title.toUpperCase(),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      penalty.total.toString().formatAsCurrency(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Theme.of(context).primaryColor),
          ]),
        ),
      ),
    );
  }
}
