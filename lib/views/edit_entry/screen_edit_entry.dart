import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/constants/router_paths.dart';
import 'package:Staffield/views/bottom_navigation.dart';
import 'package:Staffield/views/common/chip_total.dart';
import 'package:Staffield/views/common/data_chip.dart';
import 'package:Staffield/views/common/text_fields/text_field_double.dart';
import 'package:Staffield/views/view_drawer.dart';
import 'package:flutter/material.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/views/edit_entry/screen_edit_entry_vmodel.dart';
import 'package:Staffield/views/edit_entry/view_penalties.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

final _formKey = GlobalKey<FormState>();

class ScreenEditEntry extends StatelessWidget {
  ScreenEditEntry([this.entryUid]);

  final String entryUid;
  final focusInterest = FocusNode();
  final focusRevenue = FocusNode();
  final focusWage = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ScreenEditEntryVModel(entryUid),
      builder: (context, _) {
        var vModel = Provider.of<ScreenEditEntryVModel>(context, listen: false);
        return SafeArea(
          child: Scaffold(
            drawer: ViewDrawer(),
            bottomNavigationBar: BottomNavigation(RouterPaths.editEntry),
            appBar: AppBar(
              title: Text('Запись'),
              actions: <Widget>[
                IconButton(
                    color: AppColors.error,
                    icon: Icon(Icons.delete),
                    onPressed: () => vModel.removeEntry(context)),
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
                                        key: vModel.dropdownState,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          labelText: vModel.labelName,
                                          labelStyle: AppTextStyles.dataChipLabel,
                                          hintStyle: AppTextStyles.dataChipLabel,
                                        ),
                                        value: vModel.employeeUid,
                                        isExpanded: true,
                                        validator: vModel.validateEmployeeUid,
                                        items: context.select<ScreenEditEntryVModel,
                                                List<DropdownMenuItem<String>>>(
                                            (vModel) => vModel.employeesItems),
                                        onChanged: (employeeUid) {
                                          vModel.setEmployeeUid(employeeUid, context);
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
                                    Container(
                                      width: MediaQuery.of(context).size.width / 1.5,
                                      child: TextFieldDouble(
                                        vModel.wage,
                                        focusNode: focusWage,
                                        nextFocusNode: focusRevenue,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10.0),
                                        child: TextFieldDouble(
                                          vModel.revenue,
                                          focusNode: focusRevenue,
                                          nextFocusNode: focusInterest,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: TextFieldDouble(
                                        vModel.interest,
                                        focusNode: focusInterest,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Divider(),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Wrap(
                                        alignment: WrapAlignment.spaceEvenly,
                                        children: <Widget>[
                                          DataChip(
                                              value: context.select<ScreenEditEntryVModel, String>(
                                                  (vModel) => vModel.penaltiesTotal),
                                              label: vModel.labelPenalties),
                                          DataChip(
                                              value: context.select<ScreenEditEntryVModel, String>(
                                                  (vModel) => vModel.bonus),
                                              label: vModel.labelBonus),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    ChipTotal(
                                      title: 'ИТОГО: ',
                                      value: context.select<ScreenEditEntryVModel, String>(
                                          (vModel) => vModel.total),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                        margin: const EdgeInsets.only(top: 20.0),
                                        child: DropdownButton<String>(
                                            // icon: Icon(Icons.add),
                                            iconSize: 36,
                                            hint: Text('Добавить штраф'),
                                            items: vModel.penaltyTypesList,
                                            onChanged: (typeUid) {
                                              return vModel.handlePenalty(context, typeUid);
                                            })),
                                  ],
                                ),
                                ViewPenalties(Provider.of<ScreenEditEntryVModel>(context)),
                                Center(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: OutlineButton(
                                              child: Text('НАЗАД',
                                                  style: AppTextStyles.buttonLabelOutline),
                                              onPressed: () => vModel.goBack(context)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RaisedButton(
                                              shape: ContinuousRectangleBorder(
                                                  borderRadius: BorderRadius.circular(48.0)),
                                              child: Text('ОК'),
                                              onPressed: () {
                                                if (_formKey.currentState.validate()) {
                                                  vModel.save();
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
