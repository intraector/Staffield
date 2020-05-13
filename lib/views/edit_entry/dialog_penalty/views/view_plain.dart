import 'package:Staffield/views/common/text_fields/text_field_double.dart';
import 'package:Staffield/views/edit_entry/dialog_penalty/dialog_penalty_vmodel.dart';
import 'package:flutter/material.dart';

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
            child: TextFieldDouble(vModel.plainSum, autofocus: true),
          ),
        ),
      ],
    );
  }
}
