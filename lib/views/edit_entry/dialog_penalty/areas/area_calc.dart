import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/views/common/text_fields/text_field_double.dart';
import 'package:Staffield/views/edit_entry/dialog_penalty/dialog_penalty_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AreaCalc extends StatelessWidget {
  AreaCalc(this.vModel);
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
                child: TextFieldDouble(
                  vModel.unit,
                  autofocus: true,
                  nextFocusNode: focusCost,
                ),
              ),
            ),
            Icon(Icons.close, color: AppColors.primaryAccent, size: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFieldDouble(
                  vModel.cost,
                  focusNode: focusCost,
                ),
              ),
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
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                  context.select<DialogPenaltyVModel, String>((vModel) => vModel.labelTotal),
                  style: AppTextStyles.digitsBold),
            ),
          ],
        )
      ],
    );
  }
}
