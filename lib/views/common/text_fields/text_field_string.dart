import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/views/common/text_feild_handler/text_field_handler_string.dart';
import 'package:flutter/material.dart';

class TextFieldString extends StatelessWidget {
  TextFieldString(this.handler, {this.focusNode, this.nextFocusNode, this.autofocus = false});
  final TextFieldHandlerString handler;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: handler.txtCtrl,
      autofocus: autofocus,
      decoration: InputDecoration(
        isDense: true,
        labelText: handler.label,
        labelStyle: AppTextStyles.dataChipLabel,
        counterStyle: TextStyle(color: Colors.transparent),
        hintText: handler.hint,
        hintStyle: Theme.of(context).textTheme.caption,
      ),
      textInputAction: nextFocusNode == null ? TextInputAction.done : TextInputAction.next,
      maxLines: 1,
      maxLength: handler.maxLength,
      maxLengthEnforced: true,
      validator: (_) => handler.validate(),
      onSaved: (_) => handler.onSave(),
      onChanged: (_) => handler.onChange(),
      focusNode: focusNode,
      onFieldSubmitted:
          nextFocusNode == null ? null : (_) => FocusScope.of(context).requestFocus(nextFocusNode),
    );
  }
}
