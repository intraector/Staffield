import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/app_font_family.dart';
import 'package:Staffield/constants/app_fonts.dart';
import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/views/screen_edit_penalty_type/screen_edit_penalty_type_vmodel.dart';
import 'package:Staffield/views/screen_edit_penalty_type/views/view_calc/view_calc_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      child: Builder(builder: (context) {
        var vModel = Provider.of<ViewCalcVModel>(context, listen: false);
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      // autofocus: true,
                      textInputAction: TextInputAction.next,
                      controller: vModel.title.txtCtrl,
                      maxLines: 1,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: vModel.title.label,
                        labelStyle: AppTextStyles.dataChipLabel,
                        counterStyle: TextStyle(color: Colors.transparent),
                        hintText: vModel.title.hint,
                        hintStyle: Theme.of(context).textTheme.caption,
                      ),
                      onChanged: (_) => vModel.title.callback(),
                      validator: (_) => vModel.title.validate(),
                      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(focusUnitLabel),
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
                                  child: TextFormField(
                                    controller: vModel.unitLabel.txtCtrl,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: vModel.unitLabel.label,
                                      labelStyle: AppTextStyles.dataChipLabel,
                                      counterStyle: TextStyle(color: Colors.transparent),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    maxLines: 1,
                                    maxLengthEnforced: true,
                                    validator: (_) => vModel.unitLabel.validate(),
                                    onChanged: (_) => vModel.unitLabel.callback(),
                                    onFieldSubmitted: (_) =>
                                        FocusScope.of(context).requestFocus(focusUnitDefault),
                                    focusNode: focusUnitLabel,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: TextFormField(
                                    controller: vModel.unitDefault.txtCtrl,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: vModel.unitDefault.label,
                                      labelStyle: AppTextStyles.dataChipLabel,
                                      counterStyle: TextStyle(color: Colors.transparent),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    maxLines: 1,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: vModel.unitDefault.inputFormatters,
                                    validator: (_) => vModel.unitDefault.validate(),
                                    onChanged: (_) => vModel.unitDefault.format(),
                                    onFieldSubmitted: (_) =>
                                        FocusScope.of(context).requestFocus(focusCostDefault),
                                    focusNode: focusUnitDefault,
                                  ),
                                ),
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
                      child: TextFormField(
                        controller: vModel.costDefault.txtCtrl,
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: vModel.costDefault.label,
                          labelStyle: AppTextStyles.dataChipLabel,
                          counterStyle: TextStyle(color: Colors.transparent),
                        ),
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        inputFormatters: vModel.costDefault.inputFormatters,
                        validator: (_) => vModel.costDefault.validate(),
                        onChanged: (_) => vModel.costDefault.format(),
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
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 14.0, top: 0.0),
                                  child: Text('Как это будет выглядеть:'),
                                ),
                              ),
                            ],
                          ),
                          Card(
                            margin: EdgeInsets.all(0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(vertical: 20.0),
                                  child: Selector<ViewCalcVModel, String>(
                                    selector: (_, vModel) => vModel.title.txtCtrl.text,
                                    builder: (context, titleLabel, _) => Text(
                                      titleLabel.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: AppFontSize.body1,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0, right: 5.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Selector<ViewCalcVModel, String>(
                                              selector: (_, vModel) =>
                                                  vModel.unitLabel.txtCtrl.text,
                                              builder: (context, unitLabel, child) => Text(
                                                unitLabel.toUpperCase(),
                                                style: TextStyle(
                                                  fontFamily: AppFontFamily.comfortaa,
                                                  fontSize: AppFontSize.tiny3,
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                                              decoration: BoxDecoration(
                                                  border: Border(bottom: BorderSide(width: 1.0))),
                                              child: Selector<ViewCalcVModel, String>(
                                                selector: (_, vModel) =>
                                                    vModel.unitDefault.txtCtrl.text,
                                                builder: (_, unitDefault, __) => Text(
                                                  unitDefault,
                                                  style: TextStyle(
                                                    fontFamily: AppFontFamily.ptsans,
                                                    fontSize: AppFontSize.small1,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Icon(Icons.close),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5.0, right: 10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Text(
                                              'ЦЕНА',
                                              style: TextStyle(
                                                fontFamily: AppFontFamily.comfortaa,
                                                fontSize: AppFontSize.tiny3,
                                                color: AppColors.black,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                                              decoration: BoxDecoration(
                                                  border: Border(bottom: BorderSide(width: 1.0))),
                                              child: Selector<ViewCalcVModel, String>(
                                                selector: (_, vModel) =>
                                                    vModel.costDefault.txtCtrl.text,
                                                builder: (_, costDefault, __) => Text(
                                                  costDefault,
                                                  style: TextStyle(
                                                    fontFamily: AppFontFamily.ptsans,
                                                    fontSize: AppFontSize.small1,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0, top: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'СУММА: ',
                                        style: TextStyle(
                                          fontFamily: AppFontFamily.comfortaa,
                                          fontSize: AppFontSize.tiny3,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      Selector<ViewCalcVModel, String>(
                                        selector: (_, vModel) => vModel.sum,
                                        builder: (_, sum, __) => Text(
                                          sum,
                                          style: TextStyle(
                                            fontFamily: AppFontFamily.ptsans,
                                            fontSize: AppFontSize.small1,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 20.0)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(5.0),
                                      width: 80.0,
                                      height: 30,
                                      child: FlatButton(
                                        padding: EdgeInsets.all(0.0),
                                        textColor: Colors.black,
                                        child: Text(
                                          "Отмена",
                                          style: TextStyle(fontSize: 9.0),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5.0),
                                      width: 80.0,
                                      height: 30,
                                      child: RaisedButton(
                                        padding: EdgeInsets.all(0.0),
                                        color: AppColors.primary,
                                        textColor: AppColors.background,
                                        elevation: 3,
                                        highlightElevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8)),
                                        child: Text(
                                          'Готово',
                                          style: TextStyle(fontSize: 9.0),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
