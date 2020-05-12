import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/utils/regexp_digits_and_dot.dart';
import 'package:Staffield/views/edit_entry/dialog_penalty/dialog_penalty_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ViewPlain extends StatelessWidget {
  ViewPlain(this.vModel);
  final DialogPenaltyVModel vModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
              child: TextFormField(
                buildCounter: (BuildContext context,
                        {int currentLength, int maxLength, bool isFocused}) =>
                    null,
                decoration: InputDecoration(
                  labelText: 'CУММА ШТРАФА',
                  labelStyle: AppTextStyles.dataChipLabel,
                ),
                controller: vModel.txtCtrlPlainSum,
                maxLines: 1,
                maxLengthEnforced: true,
                maxLength: vModel.maxLengthPlainSum,
                keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter(regexpDigitsAndDot())],
                validator: (txt) => vModel.validatePlainSum(),
                onChanged: (_) => vModel.formatPlainSum(),
                autofocus: true,
              )),
        ),
      ],
    );
  }
}
