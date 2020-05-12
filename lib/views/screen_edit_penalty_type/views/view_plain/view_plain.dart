import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/app_font_family.dart';
import 'package:Staffield/constants/app_fonts.dart';
import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/utils/regexp_digits_and_dot.dart';
import 'package:Staffield/views/screen_edit_penalty_type/screen_edit_penalty_type_vmodel.dart';
import 'package:Staffield/views/screen_edit_penalty_type/views/view_plain/view_plain_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ViewPlain extends StatelessWidget {
  ViewPlain(this.vModelParent);
  final ScreenEditPenaltyTypeVModel vModelParent;
  final focusDefaultValue = FocusNode();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewPlainVModel>(
      create: (context) => ViewPlainVModel(vModelParent),
      child: Consumer<ViewPlainVModel>(
        builder: (context, vModel, _) => Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: vModel.txtCtrlTitle,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: vModel.labelTypeTitle,
                      labelStyle: AppTextStyles.dataChipLabel,
                      counterStyle: TextStyle(color: Colors.transparent),
                      isDense: true,
                      hintText: 'Например, "Бой посуды"',
                      hintStyle: Theme.of(context).textTheme.caption,
                    ),
                    maxLengthEnforced: true,
                    maxLength: vModel.titleMaxLength,
                    // autofocus: true,
                    onChanged: (_) => vModel.updateScreen,
                    validator: (_) => vModel.validateTitle(),
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(focusDefaultValue),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    controller: vModel.txtCtrlDefaultValue,
                    minLines: 1,
                    focusNode: focusDefaultValue,
                    style: AppTextStyles.digitsBold,
                    decoration: InputDecoration(
                      labelText: vModel.labelDefaultValue,
                      labelStyle: AppTextStyles.dataChipLabel,
                      contentPadding: EdgeInsets.only(bottom: 0.0),
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [WhitelistingTextInputFormatter(regexpDigitsAndDot())],
                    onChanged: (_) => vModel.formatDefaultValue(),
                    validator: (_) => vModel.validateDefaultValue(),
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
                                child: Text(
                                  'Как это будет выглядеть:',
                                  // style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Card(
                                margin: EdgeInsets.all(0.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.symmetric(vertical: 20.0),
                                      child: Text(
                                        vModel.txtCtrlTitle.text,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: AppFontSize.body1,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text('СУММА ШТРАФА',
                                                    style: TextStyle(
                                                      fontFamily: AppFontFamily.comfortaa,
                                                      fontSize: AppFontSize.tiny3,
                                                      color: AppColors.black,
                                                    )),
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 10.0, top: 10.0),
                                                        decoration: BoxDecoration(
                                                            border: Border(
                                                                bottom: BorderSide(width: 1.0))),
                                                        child: Text(
                                                          vModel.txtCtrlDefaultValue.text,
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
                                                Padding(padding: EdgeInsets.only(top: 40.0)),
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
                                                )
                                              ],
                                            ),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
