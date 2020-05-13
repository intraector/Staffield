import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/core/models/penalty_type.dart';
import 'package:Staffield/views/edit_penalty_type/screen_edit_penalty_type_vmodel.dart';
import 'package:Staffield/views/edit_penalty_type/views/view_calc/view_calc.dart';
import 'package:Staffield/views/edit_penalty_type/views/view_plain/view_plain.dart';
import 'package:flutter/material.dart';
import 'package:Staffield/core/models/penalty_mode.dart';
import 'package:provider/provider.dart';

class ScreenEditPenaltyType extends StatelessWidget {
  ScreenEditPenaltyType(this.penaltyType);
  final PenaltyType penaltyType;
  final _formKey = GlobalKey<FormState>();
  final focusCost = FocusNode();

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => ScreenEditPenaltyTypeVModel(penaltyType),
        child: Consumer<ScreenEditPenaltyTypeVModel>(
          builder: (_, vModel, __) => SafeArea(
              child: Scaffold(
            appBar: AppBar(title: Text("Вид штрафа", textAlign: TextAlign.center)),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    // shrinkWrap: true,
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          width: double.maxFinite,
                          child: Column(
                            children: <Widget>[
                              DropdownButton<String>(
                                value: vModel.mode,
                                items: vModel.dropdownItems,
                                onChanged: (value) => vModel.mode = value,
                              ),
                              vModel.type.mode == PenaltyMode.plain
                                  ? ViewPlain(vModel)
                                  : ViewCalc(vModel),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlineButton(
                          child: Text('НАЗАД', style: AppTextStyles.buttonLabelOutline),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(48.0)),
                            child: Text('ОК'),
                            onPressed: () {
                              vModel.save(_formKey);
                              Navigator.pop(context);
                            }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ),
      );
}
