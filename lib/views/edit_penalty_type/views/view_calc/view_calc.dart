import 'package:Staffield/views/common/text_fields/text_field_double.dart';
import 'package:Staffield/views/common/text_fields/text_field_string.dart';
import 'package:Staffield/views/edit_penalty_type/screen_edit_penalty_type_vmodel.dart';
import 'package:Staffield/views/edit_penalty_type/views/view_calc/view_calc_vmodel.dart';
import 'package:Staffield/views/edit_penalty_type/views/view_calc/view_expected.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewCalc extends StatelessWidget {
  ViewCalc(this.vModelParent);
  final ScreenEditPenaltyTypeVModel vModelParent;
  final focusUnitLabel = FocusNode();
  final focusUnitDefault = FocusNode();
  final focusCostDefault = FocusNode();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewCalcVModel>(
      create: (context) => ViewCalcVModel(vModelParent),
      builder: (context, _) {
        var vModel = Provider.of<ViewCalcVModel>(context, listen: false);
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    child: TextFieldString(
                      vModel.title,
                      autofocus: false,
                      nextFocusNode: focusUnitLabel,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 0.0),
                      child: Text(vModel.labelUnitSection.toUpperCase()),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: TextFieldString(
                                    vModel.unitLabel,
                                    focusNode: focusUnitLabel,
                                    nextFocusNode: focusUnitDefault,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: TextFieldDouble(
                                      vModel.unitDefault,
                                      focusNode: focusUnitDefault,
                                      nextFocusNode: focusCostDefault,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFieldDouble(
                        vModel.costDefault,
                        focusNode: focusCostDefault,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 40.0),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: ViewExpected(),
              ),
            ],
          ),
        );
      },
    );
  }
}
