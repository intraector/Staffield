import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/views/reports/views/fl_charts/components/menu_penalty_type/vmodel_penalty_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuPenaltytype extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VModelPenaltyType>(
      init: VModelPenaltyType(),
      builder: (vmodel) => DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: false,
          style: TextStyle(color: Colors.lightBlueAccent, fontSize: 20.0),
          iconEnabledColor: Colors.white,
          dropdownColor: AppColors.primary,
          items: vmodel.penaltiesMenuItems.keys
              .map<DropdownMenuItem<String>>((uid) =>
                  DropdownMenuItem(value: uid, child: Text(vmodel.penaltiesMenuItems[uid])))
              .toList(),
          onChanged: (value) => vmodel.penaltyTypeCurrentUid = value,
          value: vmodel.penaltyTypeCurrentUid,
        ),
      ),
    );
  }
}
