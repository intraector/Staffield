import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/utils/regexp_digits_and_dot.dart';
import 'package:Staffield/views/edit_entry/screen_edit_entry_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditableWage extends StatelessWidget {
  EditableWage({@required this.focusNode, @required this.nextFocus});
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
        controller: vModel.txtCtrlWage,
        textInputAction: textInputAction,
        minLines: 1,
        maxLines: 1,
        focusNode: focusNode,
        style: AppTextStyles.digitsBold,
        decoration: InputDecoration(
          labelText: vModel.labelWage,
          labelStyle: AppTextStyles.dataChipLabel,
          contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.0),
          isDense: true,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [WhitelistingTextInputFormatter(regexpDigitsAndDot())],
        onChanged: (_) => vModel.formatWage(),
        validator: (txt) => vModel.validateWage(txt),
        onFieldSubmitted: (_) {
          if (nextFocus != null) FocusScope.of(context).requestFocus(nextFocus);
        },
      ),
    );
  }
}
