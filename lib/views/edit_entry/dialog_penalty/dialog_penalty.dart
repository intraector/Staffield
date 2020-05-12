import 'package:Staffield/views/edit_entry/dialog_penalty/dialog_penalty_vmodel.dart';
import 'package:Staffield/views/edit_entry/dialog_penalty/views/view_calc.dart';
import 'package:Staffield/views/edit_entry/dialog_penalty/views/view_plain.dart';
import 'package:Staffield/views/edit_entry/screen_edit_entry_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/core/models/penalty_mode.dart';
import 'package:Staffield/core/models/penalty.dart';
import 'package:provider/provider.dart';

final _formKey = GlobalKey<FormState>();

class DialogPenalty extends StatelessWidget {
  DialogPenalty(
      {@required this.penalty, this.isNewPenalty = false, @required this.screenEntryVModel});
  final Penalty penalty;
  final bool isNewPenalty;
  final ScreenEditEntryVModel screenEntryVModel;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => DialogPenaltyVModel(penalty: penalty, screenEntryVModel: screenEntryVModel),
        child: Builder(builder: (context) {
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
                      if (vModel.penalty.mode == PenaltyMode.plain) ViewPlain(vModel),
                      if (vModel.penalty.mode == PenaltyMode.calc) ViewCalc(vModel),
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
                      FlatButton(
                        textColor: AppColors.error,
                        child: Text("Удалить"),
                        onPressed: () {
                          vModel.remove();
                          Navigator.of(context).pop();
                        },
                      ),
                    Spacer(),
                    FlatButton(
                      textColor: Colors.black,
                      // padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      child: Text("Отмена"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    RaisedButton(
                      color: AppColors.primary,
                      textColor: AppColors.background,
                      elevation: 3,
                      highlightElevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: Text('Готово'),
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
        }),
      );
}
