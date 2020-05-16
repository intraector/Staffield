import 'package:Staffield/views/common/text_fields/text_field_double.dart';
import 'package:Staffield/views/common/text_fields/text_field_string.dart';
import 'package:Staffield/views/edit_penalty_type/screen_edit_penalty_type_vmodel.dart';
import 'package:Staffield/views/edit_penalty_type/views/view_plain/view_expected.dart';
import 'package:Staffield/views/edit_penalty_type/views/view_plain/view_plain_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewPlain extends StatelessWidget {
  ViewPlain(this.vModelParent);
  final ScreenEditPenaltyTypeVModel vModelParent;
  final focusDefaultValue = FocusNode();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewPlainVModel>(
      create: (context) => ViewPlainVModel(vModelParent),
      builder: (context, _) {
        var vModel = Provider.of<ViewPlainVModel>(context, listen: false);
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(child: TextFieldString(vModel.title, nextFocusNode: focusDefaultValue)),
              ],
            ),
            Row(
              children: <Widget>[
                Flexible(child: TextFieldDouble(vModel.defaultValue, focusNode: focusDefaultValue)),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 40.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: ViewExpected(),
            ),
          ],
        );
      },
    );
  }
}
