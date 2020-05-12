import 'package:flutter/material.dart';

abstract class TextFieldHandlerBase {
  TextFieldHandlerBase({this.callback, this.maxLength = 10, this.label, this.hint});
  final void Function() callback;
  TextEditingController txtCtrl = TextEditingController();
  final int maxLength;
  String previousInput = '';
  String label;
  String hint;

  String validate();
}
