import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/utils/regexp_digits_and_dot.dart';
import 'package:Staffield/views/edit_entry/dialog_penalty/dialog_penalty_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ViewCalc extends StatelessWidget {
  ViewCalc(this.vModel);
  final DialogPenaltyVModel vModel;
  final focusCost = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: vModel.txtCtrlUnit,
                  style: AppTextStyles.digitsBold,
                  decoration: InputDecoration(
                    labelText: vModel.labelUnit,
                    counterStyle: TextStyle(color: Colors.transparent),
                    labelStyle: AppTextStyles.dataChipLabel,
                  ),
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  maxLengthEnforced: true,
                  maxLength: vModel.maxLengthUnit,
                  keyboardType: TextInputType.number,
                  inputFormatters: [WhitelistingTextInputFormatter(regexpDigitsAndDot())],
                  autofocus: true,
                  validator: (txt) => vModel.validateUnit(),
                  onChanged: (_) => vModel.formatUnitAndCalcTotal(),
                  onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(focusCost),
                ),
              ),
            ),
            Icon(Icons.close, color: AppColors.primaryAccent, size: 20),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: vModel.txtCtrlCost,
                    style: AppTextStyles.digitsBold,
                    decoration: InputDecoration(
                      labelText: vModel.labelCost,
                      labelStyle: AppTextStyles.dataChipLabel,
                      counterStyle: TextStyle(color: Colors.transparent),
                    ),
                    maxLines: 1,
                    maxLengthEnforced: true,
                    maxLength: vModel.maxLengthCost,
                    keyboardType: TextInputType.number,
                    inputFormatters: [WhitelistingTextInputFormatter(regexpDigitsAndDot())],
                    validator: (txt) => vModel.validateCost(),
                    onChanged: (_) => vModel.formatCostAndCalcTotal(),
                    focusNode: focusCost,
                  )),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              vModel.labelTotalPrefix,
              style: AppTextStyles.dataChipLabel,
            ),
            Selector<DialogPenaltyVModel, String>(
              selector: (_, vModel) => vModel.labelTotal,
              builder: (context, labelTotal, child) => Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(labelTotal, style: AppTextStyles.digitsBold),
              ),
            )
          ],
        )
      ],
    );
  }
}
