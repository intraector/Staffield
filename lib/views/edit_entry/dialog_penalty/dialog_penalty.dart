import 'package:Staffield/views/edit_entry/dialog_penalty/dialog_penalty_vmodel.dart';
import 'package:Staffield/views/edit_entry/dialog_penalty/areas/area_calc.dart';
import 'package:Staffield/views/edit_entry/dialog_penalty/areas/area_plain.dart';
import 'package:Staffield/views/edit_entry/vmodel_edit_entry.dart';
import 'package:flutter/material.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/core/entities/penalty_mode.dart';
import 'package:Staffield/core/entities/penalty.dart';
import 'package:provider/provider.dart';

final _formKey = GlobalKey<FormState>();

class DialogPenalty extends StatelessWidget {
  DialogPenalty(
      {@required this.penalty, this.isNewPenalty = false, @required this.screenEntryVModel});
  final Penalty penalty;
  final bool isNewPenalty;
  final VModelEditEntry screenEntryVModel;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => DialogPenaltyVModel(penalty: penalty, screenEntryVModel: screenEntryVModel),
        builder: (context, _) {
          var vModel = Provider.of<DialogPenaltyVModel>(context, listen: false);
          return SimpleDialog(
            contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0),
            title: Text(vModel.labelTitle, textAlign: TextAlign.center),
            children: <Widget>[
              Form(
                key: _formKey,
                child: Container(
                  width: double.maxFinite,
                  constraints: BoxConstraints.loose(Size.fromHeight(200)),
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      if (vModel.penalty.mode == PenaltyMode.plain) AreaPlain(vModel),
                      if (vModel.penalty.mode == PenaltyMode.calc) AreaCalc(vModel),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    if (!isNewPenalty)
                      IconButton(
                        icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
                        onPressed: () => vModel.remove(context: context),
                      ),
                    Spacer(),
                    RaisedButton(
                      color: AppColors.primary,
                      textColor: AppColors.background,
                      elevation: 3,
                      highlightElevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: Text('ОК'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          vModel.save();
                          Navigator.of(context).pop(vModel.penalty);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
}
