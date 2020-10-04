import 'package:flutter/material.dart';

abstract class TextFieldDataBase {
  TextFieldDataBase({
    this.onChanged,
    this.onSave,
    this.maxLength = 10,
    this.label,
    this.hint,
    String defaultValue,
  }) {
    if (defaultValue != null) txtCtrl.text = defaultValue;
  }
  final void Function([String _]) onChanged;
  final void Function([String _]) onSave;
  TextEditingController txtCtrl = TextEditingController();
  final int maxLength;
  String label;
  String hint;

  String validate();
}
