import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/views/common/text_feild_handler/text_field_handler_double.dart';
import 'package:flutter/material.dart';

class TextFieldDouble extends StatelessWidget {
  TextFieldDouble(this.handler, {this.focusNode, this.nextFocusNode, this.autofocus = false});
  final TextFieldHandlerDouble handler;
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
      ),
      textInputAction: nextFocusNode == null ? TextInputAction.done : TextInputAction.next,
      maxLines: 1,
      keyboardType: TextInputType.number,
      inputFormatters: handler.inputFormatters,
      validator: (_) => handler.validate(),
      onSaved: (_) => handler.onSave(),
      onChanged: (_) => handler.format(),
      focusNode: focusNode,
      onFieldSubmitted:
          nextFocusNode == null ? null : (_) => FocusScope.of(context).requestFocus(nextFocusNode),
    );
  }
}
