import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/utils/regexp_digits_and_dot.dart';
import 'package:Staffield/views/edit_entry/screen_edit_entry_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditablInterest extends StatelessWidget {
  EditablInterest({@required this.vModel, @required this.focusNode, @required this.nextFocus});
  final ScreenEditEntryVModel vModel;
  final FocusNode focusNode;
  final FocusNode nextFocus;
  @override
  Widget build(BuildContext context) {
    var vModel = Provider.of<ScreenEditEntryVModel>(context, listen: false);
    TextInputAction textInputAction =
        nextFocus == null ? TextInputAction.done : TextInputAction.next;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: TextFormField(
        controller: vModel.txtCtrlInterest,
        textInputAction: textInputAction,
        minLines: 1,
        maxLines: 1,
        focusNode: focusNode,
        style: AppTextStyles.digitsBold,
        decoration: InputDecoration(
          labelText: 'ПРОЦЕНТ',
          labelStyle: AppTextStyles.dataChipLabel,
          contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.0),
          isDense: true,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [WhitelistingTextInputFormatter(regexpDigitsAndDot())],
        onChanged: (_) => vModel.formatInterest(),
        validator: (txt) => vModel.validateInterest(txt),
        onFieldSubmitted: (_) {
          if (nextFocus != null) FocusScope.of(context).requestFocus(nextFocus);
        },
      ),
    );
  }
}
