import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/utils/regexp_digits_and_dot.dart';
import 'package:Staffield/views/edit_entry/screen_edit_entry_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EditableRevenue extends StatelessWidget {
  EditableRevenue({@required this.vModel, @required this.focusNode, @required this.nextFocus});
  final ScreenEditEntryVModel vModel;
  final FocusNode focusNode;
  final FocusNode nextFocus;
  @override
  Widget build(BuildContext context) {
    TextInputAction textInputAction =
        nextFocus == null ? TextInputAction.done : TextInputAction.next;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.5),
      margin: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: Color(0xFF99bdc9),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextFormField(
        controller: vModel.txtCtrlRevenue,
        textInputAction: textInputAction,
        minLines: 1,
        maxLines: 1,
        focusNode: focusNode,
        style: AppTextStyles.bodyBoldLight,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.0),
          isDense: true,
          icon: Icon(MdiIcons.cashMultiple, size: 26.0, color: AppColors.white),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.white)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.white)),
        ),
        cursorColor: AppColors.white,
        keyboardType: TextInputType.number,
        inputFormatters: [WhitelistingTextInputFormatter(regexpDigitsAndDot())],
        onChanged: (_) => vModel.formatRevenue(),
        validator: (txt) => vModel.validateRevenue(txt),
        onFieldSubmitted: (_) {
          if (nextFocus != null) FocusScope.of(context).requestFocus(nextFocus);
        },
      ),
    );
  }
}
