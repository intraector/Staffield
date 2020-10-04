import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/views/common/text_feild_handler/text_field_data_decimal.dart';
import 'package:flutter/material.dart';

class TextFieldDecimal extends StatelessWidget {
  TextFieldDecimal(this.data, {this.focusNode, this.nextFocusNode, this.autofocus = false});
  final TextFieldDataDecimal data;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: data.txtCtrl,
      autofocus: autofocus,
      decoration: InputDecoration(
        isDense: true,
        labelText: data.label,
        labelStyle: AppTextStyles.dataChipLabel,
        counter: SizedBox.shrink(),
        hintText: data.hint,
        hintStyle: Theme.of(context).textTheme.caption,
      ),
      textInputAction: nextFocusNode == null ? TextInputAction.done : TextInputAction.next,
      maxLines: 1,
      keyboardType: TextInputType.number,
      inputFormatters: data.inputFormatters,
      validator: data.validate,
      onSaved: data.onSave,
      onChanged: data.onChanged,
      focusNode: focusNode,
      onFieldSubmitted:
          nextFocusNode == null ? null : (_) => FocusScope.of(context).requestFocus(nextFocusNode),
    );
  }
}
