import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/constants/routes_paths.dart';
import 'package:Staffield/views/bottom_navigation.dart';
import 'package:Staffield/views/common/chip_total.dart';
import 'package:Staffield/views/common/data_chip.dart';
import 'package:Staffield/views/common/text_fields/text_field_decimal.dart';
import 'package:Staffield/views/view_drawer.dart';
import 'package:flutter/material.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/views/edit_entry/vmodel_edit_entry.dart';
import 'package:Staffield/views/edit_entry/area_penalties.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

final _formKey = GlobalKey<FormState>();

class ViewEditEntry extends StatelessWidget {
  ViewEditEntry([this.entryUid]);

  final String entryUid;
  final focusInterest = FocusNode();
  final focusRevenue = FocusNode();
  final focusWage = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VModelEditEntry>(
      init: VModelEditEntry(entryUid),
      builder: (vmodel) {
        return SafeArea(
          child: Scaffold(
            drawer: ViewDrawer(),
            bottomNavigationBar: BottomNavigation(RoutesPaths.editEntry),
            appBar: AppBar(
              title: Text('Запись'),
              actions: <Widget>[
                IconButton(
                    color: AppColors.error,
                    icon: Icon(Icons.delete),
                    onPressed: () => vmodel.removeEntry(context)),
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                  // gradient: FlutterGradients.cloudyApple(tileMode: TileMode.clamp),
                  ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Form(
                            key: _formKey,
                            child: ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              children: <Widget>[
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.center,
                                  children: [
                                    Icon(
                                      MdiIcons.fileEdit,
                                      size: 60.0,
                                      color: AppColors.primaryAccent,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'ЗАПИСЬ',
                                        style: AppTextStyles.titleDisplay,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: DropdownButtonFormField(
                                        key: vmodel.dropdownKey,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          labelText: vmodel.labelName,
                                          labelStyle: AppTextStyles.dataChipLabel,
                                          hintStyle: AppTextStyles.dataChipLabel,
                                        ),
                                        value: vmodel.employeeUid,
                                        isExpanded: true,
                                        validator: vmodel.validateEmployeeUid,
                                        items: vmodel.employeesItems,
                                        onChanged: (employeeUid) {
                                          vmodel.setEmployeeUid(employeeUid, context);
                                          FocusScope.of(context).requestFocus(focusWage);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10.0),
                                        child: TextFieldDecimal(
                                          vmodel.wage,
                                          focusNode: focusWage,
                                          nextFocusNode: focusRevenue,
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 1, child: SizedBox.shrink()),
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10.0),
                                        child: TextFieldDecimal(
                                          vmodel.revenue,
                                          focusNode: focusRevenue,
                                          nextFocusNode: focusInterest,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: TextFieldDecimal(
                                        vmodel.interest,
                                        focusNode: focusInterest,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                GetBuilder<VModelEditEntry>(
                                    id: 'calc',
                                    builder: (vmodel) => Column(
                                          children: [
                                            Divider(),
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Wrap(
                                                    alignment: WrapAlignment.spaceEvenly,
                                                    children: <Widget>[
                                                      DataChip(
                                                        value: vmodel.penaltiesTotal,
                                                        label: vmodel.labelPenalties,
                                                      ),
                                                      DataChip(
                                                          value: vmodel.bonus,
                                                          label: vmodel.labelBonus),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                DropdownButton<String>(
                                                    hint: Text('Добавить штраф'),
                                                    items: vmodel.penaltyTypesList,
                                                    onChanged: (typeUid) {
                                                      return vmodel.handlePenalty(context, typeUid);
                                                    }),
                                              ],
                                            ),
                                            AreaPenalties(vmodel),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  ChipTotal(
                                                    title: 'ИТОГО: ',
                                                    value: vmodel.total,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                Center(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: OutlineButton(
                                              child: Text('НАЗАД',
                                                  style: AppTextStyles.buttonLabelOutline),
                                              onPressed: () => vmodel.goBack(context)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RaisedButton(
                                              child: Text('ОК'),
                                              onPressed: () {
                                                if (_formKey.currentState.validate()) {
                                                  vmodel.save();
                                                  Navigator.of(context).pop();
                                                }
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
