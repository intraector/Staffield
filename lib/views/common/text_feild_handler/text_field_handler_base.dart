import 'package:flutter/material.dart';

abstract class TextFieldHandlerBase {
  TextFieldHandlerBase({
    this.onChange,
    this.onSave,
    this.maxLength = 10,
    this.label,
    this.hint,
    String defaultValue,
  }) {
    if (defaultValue != null) txtCtrl.text = defaultValue;
    previousInput = txtCtrl.text;
  }
  final void Function() onChange;
  final void Function() onSave;
  TextEditingController txtCtrl = TextEditingController();
  final int maxLength;
  String previousInput;
  String label;
  String hint;

  String validate();
}
