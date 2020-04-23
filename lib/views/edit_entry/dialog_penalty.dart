import 'package:Staffield/views/edit_entry/screen_edit_entry_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/penalty_type.dart';
import 'package:Staffield/models/penalty.dart';
import 'package:Staffield/views/edit_entry/dialog_penalty_vmodel.dart';
import 'package:provider/provider.dart';

class DialogPenalty extends StatelessWidget {
  DialogPenalty(
      {@required this.penalty, this.isNewPenalty = false, @required this.screenEntryVModel});
  final Penalty penalty;
  final bool isNewPenalty;
  final ScreenEditEntryVModel screenEntryVModel;
  final _formKey = GlobalKey<FormState>();
  final focusMoney = FocusNode();

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => DialogPenaltyVModel(penalty: penalty, screenEntryVModel: screenEntryVModel),
        child: Consumer<DialogPenaltyVModel>(
          builder: (_, vModel, __) => SimpleDialog(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text("ШТРАФ", textAlign: TextAlign.center),
            children: <Widget>[
              Form(
                key: _formKey,
                child: Container(
                  width: double.maxFinite,
                  constraints: BoxConstraints.loose(Size.fromHeight(200)),
                  child: ListView(
                    children: <Widget>[
                      if (vModel.penalty.type == PenaltyType.plain)
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: TextFormField(
                                    buildCounter: (BuildContext context,
                                            {int currentLength, int maxLength, bool isFocused}) =>
                                        null,
                                    decoration: InputDecoration(labelText: 'Cумма штрафа'),
                                    controller: vModel.txtCtrlPlainSum,
                                    maxLines: 1,
                                    maxLengthEnforced: true,
                                    maxLength: vModel.maxLengthPlainSum,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                                    validator: (txt) => vModel.validatePlainSum(),
                                    autofocus: true,
                                  )),
                            ),
                          ],
                        ),
                      if (vModel.penalty.type == PenaltyType.minutesByMoney)
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: vModel.txtCtrlMinutes,
                                              decoration: InputDecoration(
                                                labelText: vModel.labelMinutes,
                                                counterStyle: TextStyle(color: Colors.transparent),
                                              ),
                                              textInputAction: TextInputAction.next,
                                              maxLines: 1,
                                              maxLengthEnforced: true,
                                              maxLength: vModel.maxLengthMinutes,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [
                                                WhitelistingTextInputFormatter.digitsOnly
                                              ],
                                              autofocus: true,
                                              validator: (txt) => vModel.validateMinutes(),
                                              onChanged: (_) => vModel.calcPenaltyTimeByMoney(),
                                              onFieldSubmitted: (_) =>
                                                  FocusScope.of(context).requestFocus(focusMoney),
                                            )),
                                      ),
                                      Expanded(
                                        child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: vModel.txtCtrlMoney,
                                              decoration: InputDecoration(
                                                labelText: vModel.labelMoney,
                                                counterStyle: TextStyle(color: Colors.transparent),
                                              ),
                                              maxLines: 1,
                                              maxLengthEnforced: true,
                                              maxLength: vModel.maxLengthMoney,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [
                                                WhitelistingTextInputFormatter.digitsOnly
                                              ],
                                              validator: (txt) => vModel.validateMoney(),
                                              onChanged: (_) => vModel.calcPenaltyTimeByMoney(),
                                              focusNode: focusMoney,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(vModel.labelTotal),
                                )
                              ],
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
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
              ),
            ],
          ),
        ),
      );
}
