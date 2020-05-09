import 'package:Staffield/core/models/penalty_type.dart';
import 'package:Staffield/views/dialog_penalty_type/dialog_penalty_type_vmodel.dart';
import 'package:Staffield/views/dialog_penalty_type/views/view_plain/view_plain.dart';
import 'package:flutter/material.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/core/models/penalty_mode.dart';
import 'package:provider/provider.dart';

class DialogPenaltyType extends StatelessWidget {
  DialogPenaltyType({@required this.penaltyType});
  final PenaltyType penaltyType;
  final _formKey = GlobalKey<FormState>();
  final focusCost = FocusNode();

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => DialogPenaltyTypeVModel(penaltyType),
        child: Consumer<DialogPenaltyTypeVModel>(
          builder: (_, vModel, __) => SimpleDialog(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text("ШТРАФ", textAlign: TextAlign.center),
            children: <Widget>[
              Form(
                key: _formKey,
                child: Container(
                  width: double.maxFinite,
                  // constraints: BoxConstraints.loose(Size.fromHeight(400)),
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      if (vModel.type.mode == PenaltyMode.plain) ViewPlain(vModel),
                      // if (vModel.type.mode == PenaltyMode.calc)
                      // Column(
                      //   children: <Widget>[
                      //     Row(
                      //       children: <Widget>[
                      //         Expanded(
                      //           child: Row(
                      //             children: <Widget>[
                      //               Expanded(
                      //                 child: Padding(
                      //                     padding: const EdgeInsets.all(10.0),
                      //                     child: TextFormField(
                      //                       controller: vModel.txtCtrlUnit,
                      //                       decoration: InputDecoration(
                      //                         // labelText: vModel.labelMinutes,
                      //                         counterStyle: TextStyle(color: Colors.transparent),
                      //                       ),
                      //                       textInputAction: TextInputAction.next,
                      //                       maxLines: 1,
                      //                       maxLengthEnforced: true,
                      //                       // maxLength: vModel.maxLengthUnit,
                      //                       keyboardType: TextInputType.number,
                      //                       inputFormatters: [
                      //                         WhitelistingTextInputFormatter.digitsOnly
                      //                       ],
                      //                       autofocus: true,
                      //                       validator: (txt) => vModel.validateMinutes(),
                      //                       // onChanged: (_) => vModel.calcPenaltyTimeByMoney(),
                      //                       onFieldSubmitted: (_) =>
                      //                           FocusScope.of(context).requestFocus(focusCost),
                      //                     )),
                      //               ),
                      //               Expanded(
                      //                 child: Padding(
                      //                     padding: const EdgeInsets.all(10.0),
                      //                     child: TextFormField(
                      //                       controller: vModel.txtCtrlCost,
                      //                       decoration: InputDecoration(
                      //                         // labelText: vModel.labelMoney,
                      //                         counterStyle: TextStyle(color: Colors.transparent),
                      //                       ),
                      //                       maxLines: 1,
                      //                       maxLengthEnforced: true,
                      //                       // maxLength: vModel.maxLengthMoney,
                      //                       keyboardType: TextInputType.number,
                      //                       inputFormatters: [
                      //                         WhitelistingTextInputFormatter.digitsOnly
                      //                       ],
                      //                       validator: (txt) => vModel.validateMoney(),
                      //                       // onChanged: (_) => vModel.calcPenaltyTimeByMoney(),
                      //                       focusNode: focusCost,
                      //                     )),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
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
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text('Готово'),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      // vModel.save();
                                      // Navigator.of(context).pop(vModel.penaltyType);
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
              ),
            ],
          ),
        ),
      );
}
