import 'package:Staffield/constants/app_text_styles.dart';
import 'package:Staffield/core/models/employee.dart';
import 'package:Staffield/utils/dialog_confirm.dart';
import 'package:Staffield/views/bottom_navigation.dart';
import 'package:Staffield/views/view_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/core/models/penalty_type.dart';
import 'package:Staffield/utils/regexp_digits_and_dot.dart';
import 'package:Staffield/views/edit_entry/screen_edit_entry_vmodel.dart';
import 'package:Staffield/views/edit_entry/view_penalties.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
// import 'package:Staffield/utils/CurrencyFormatter.dart';

final _formKey = GlobalKey<FormState>();

class ScreenEditEntry extends StatelessWidget {
  ScreenEditEntry([this.entryUid]);
  final focusRevenue = FocusNode();
  final focusWage = FocusNode();
  final focusInterest = FocusNode();
  final String entryUid;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ScreenEditEntryVModel(entryUid),
      child: Builder(
        builder: (context) {
          var vModel = Provider.of<ScreenEditEntryVModel>(context, listen: false);
          return SafeArea(
            child: Scaffold(
              drawer: ViewDrawer(),
              bottomNavigationBar: BottomNavigation('nopath'),
              appBar: AppBar(
                title: Text('Запись'),
                actions: <Widget>[
                  IconButton(
                      color: AppColors.error,
                      icon: Icon(Icons.delete),
                      onPressed: () => vModel.removeEntry(context)),
                ],
              ),
              body: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/edit_entry.png',
                      color: AppColors.secondary,
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                  ),
                  Column(
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
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Selector<ScreenEditEntryVModel,
                                                  Tuple2<String, List<Employee>>>(
                                              selector: (_, _vModel) => Tuple2(
                                                  _vModel.employeeUid, _vModel.employeesItems),
                                              builder: (context, tuple, __) =>
                                                  DropdownButtonFormField(
                                                    decoration: InputDecoration(isDense: true),
                                                    value: tuple.item1,
                                                    hint: Text(vModel.labelName),
                                                    isExpanded: true,
                                                    validator: vModel.validateEmployeeUid,
                                                    items: tuple.item2
                                                        .map((employee) => DropdownMenuItem(
                                                              value: employee.uid,
                                                              child: Text(employee.name),
                                                            ))
                                                        .toList(),
                                                    onChanged: (employeeUid) {
                                                      vModel.setEmployeeUid(employeeUid, context);
                                                      FocusScope.of(context)
                                                          .requestFocus(focusWage);
                                                    },
                                                  )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                                child: Text(
                                                  vModel.labelWage,
                                                  style: AppTextStyles.small1Bold,
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 7.0, vertical: 5.5),
                                                margin: EdgeInsets.all(3.0),
                                                decoration: BoxDecoration(
                                                  color: AppColors.primaryAccent,
                                                  borderRadius: BorderRadius.circular(5.0),
                                                ),
                                                child: TextFormField(
                                                  controller: vModel.txtCtrlWage,
                                                  textInputAction: TextInputAction.next,
                                                  minLines: 1,
                                                  maxLines: 1,
                                                  focusNode: focusWage,
                                                  style: AppTextStyles.bodyBoldLight,
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.symmetric(
                                                        horizontal: 0.0, vertical: 2.0),
                                                    isDense: true,
                                                    icon: Icon(
                                                      MdiIcons.cash,
                                                      size: 26.0,
                                                      color: AppColors.white,
                                                    ),
                                                    enabledBorder: UnderlineInputBorder(
                                                        borderSide:
                                                            BorderSide(color: AppColors.white)),
                                                    focusedBorder: UnderlineInputBorder(
                                                        borderSide:
                                                            BorderSide(color: AppColors.white)),
                                                  ),
                                                  cursorColor: AppColors.white,
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [
                                                    WhitelistingTextInputFormatter(
                                                        regexpDigitsAndDot())
                                                  ],
                                                  onChanged: (_) => vModel.formatWage(),
                                                  validator: (txt) => vModel.validateWage(txt),
                                                  onFieldSubmitted: (_) => FocusScope.of(context)
                                                      .requestFocus(focusRevenue),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                                child: Text(
                                                  vModel.labelBonus,
                                                  style: AppTextStyles.small1Bold,
                                                ),
                                              ),
                                              Selector<ScreenEditEntryVModel, String>(
                                                selector: (_, _vModel) => _vModel.bonus,
                                                builder: (context, bonus, __) => DataChip(
                                                  text: bonus,
                                                  icon: MdiIcons.cashPlus,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                                child: Text(
                                                  vModel.labelPenalties,
                                                  style: AppTextStyles.small1Bold,
                                                ),
                                              ),
                                              Selector<ScreenEditEntryVModel, String>(
                                                  selector: (_, _vModel) => _vModel.penaltiesTotal,
                                                  builder: (context, penaltiesTotal, __) =>
                                                      DataChip(
                                                        text: penaltiesTotal,
                                                        icon: MdiIcons.cashMinus,
                                                      )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 20.0),
                                            child: TextFormField(
                                              controller: vModel.txtCtrlRevenue,
                                              textInputAction: TextInputAction.next,
                                              focusNode: focusRevenue,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelText: vModel.labelRevenue,
                                                icon: Icon(MdiIcons.cashMultiple, size: 24.0),
                                              ),
                                              maxLines: 1,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [
                                                WhitelistingTextInputFormatter(regexpDigitsAndDot())
                                              ],
                                              onChanged: (_) => vModel.formatRevenue(),
                                              validator: (txt) => vModel.validateRevenue(txt),
                                              onFieldSubmitted: (_) => FocusScope.of(context)
                                                  .requestFocus(focusInterest),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 20.0),
                                            child: TextFormField(
                                              controller: vModel.txtCtrlInterest,
                                              focusNode: focusInterest,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelText: vModel.labelInterest,
                                                icon: Icon(MdiIcons.brightnessPercent, size: 24.0),
                                              ),
                                              maxLines: 1,
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [
                                                WhitelistingTextInputFormatter(regexpDigitsAndDot())
                                              ],
                                              onChanged: (_) => vModel.formatInterest(),
                                              validator: (txt) => vModel.validateInterest(txt),
                                              onFieldSubmitted: (_) =>
                                                  FocusScope.of(context).requestFocus(focusWage),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 20.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                Text(
                                                  'ИТОГО: ',
                                                  style: AppTextStyles.bodyBold,
                                                ),
                                                Selector<ScreenEditEntryVModel, String>(
                                                    selector: (_, _vModel) => _vModel.total,
                                                    builder: (context, total, __) => Text(
                                                          total,
                                                          style: AppTextStyles.bodyBold,
                                                        ))
                                              ],
                                            ),
                                          ),
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
                                                items: [
                                                  DropdownMenuItem(
                                                      child: Text(PenaltyType.plain.title),
                                                      value: PenaltyType.plain),
                                                  DropdownMenuItem(
                                                      child: Text(PenaltyType.timeByMoney.title),
                                                      value: PenaltyType.timeByMoney)
                                                ],
                                                onChanged: (type) =>
                                                    vModel.addPenalty(context, type))),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DataChip extends StatelessWidget {
  DataChip({@required this.text, @required this.icon});
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 4.0),
      margin: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: AppColors.primaryAccent,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Icon(icon, color: AppColors.white),
          ),
          Flexible(
            child: SingleChildScrollView(child: Text(text, style: AppTextStyles.bodyBoldLight)),
          ),
        ],
      ),
    );
  }
}
