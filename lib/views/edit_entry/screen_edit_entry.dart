import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Staffield/constants/app_colors.dart';
import 'package:Staffield/constants/penalty_type.dart';
import 'package:Staffield/models/penalty.dart';
import 'package:Staffield/utils/regexp_digits_and_dot.dart';
import 'package:Staffield/views/edit_entry/dialog_penalty.dart';
import 'package:Staffield/views/edit_entry/screen_edit_entry_vmodel.dart';
import 'package:Staffield/views/edit_entry/view_penalties.dart';
import 'package:provider/provider.dart';
// import 'package:Staffield/utils/CurrencyFormatter.dart';

final _formKey = GlobalKey<FormState>();

class ScreenEditEntry extends StatelessWidget {
  ScreenEditEntry([this.entryUid]);
  final focusRevenue = FocusNode();
  final focusWage = FocusNode();
  final focusInterest = FocusNode();
  final String entryUid;
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => ScreenEditEntryVModel(entryUid),
        child: SafeArea(
          child: Scaffold(
            body: Container(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: Consumer<ScreenEditEntryVModel>(
                  builder: (_, vModel, __) => ListView(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: DropdownButtonFormField(
                              value: vModel.employeeUid,
                              hint: Text(vModel.labelName),
                              isExpanded: true,
                              validator: vModel.validateEmployeeUid,
                              items: vModel.employeesItems
                                  .map((employee) => DropdownMenuItem(
                                        value: employee.uid,
                                        child: Text(employee.name),
                                      ))
                                  .toList(),
                              onChanged: (employeeUid) =>
                                  vModel.setEmployeeUid(employeeUid, context),
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
                                decoration: InputDecoration(labelText: vModel.labelRevenue),
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(regexpDigitsAndDot())
                                ],
                                onChanged: (_) => vModel.formatRevenue(),
                                validator: (txt) => vModel.validateRevenue(txt),
                                onFieldSubmitted: (_) =>
                                    FocusScope.of(context).requestFocus(focusWage),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextFormField(
                                controller: vModel.txtCtrlWage,
                                textInputAction: TextInputAction.next,
                                focusNode: focusWage,
                                decoration: InputDecoration(labelText: vModel.labelWage),
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(regexpDigitsAndDot())
                                ],
                                onChanged: (_) => vModel.formatWage(),
                                validator: (txt) => vModel.validateWage(txt),
                                onFieldSubmitted: (_) =>
                                    FocusScope.of(context).requestFocus(focusInterest),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 20.0),
                              child: TextFormField(
                                controller: vModel.txtCtrlInterest,
                                focusNode: focusInterest,
                                decoration: InputDecoration(labelText: vModel.labelInterest),
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(regexpDigitsAndDot())
                                ],
                                onChanged: (_) => vModel.formatInterest(),
                                validator: (txt) => vModel.validateInterest(txt),
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
                              child: DropdownButton<PenaltyType>(
                                  // icon: Icon(Icons.add),
                                  iconSize: 36,
                                  hint: Text('Добавить штраф'),
                                  items: [
                                    DropdownMenuItem(
                                        child: Text(getPenaltyTitle(PenaltyType.plain)),
                                        value: PenaltyType.plain),
                                    DropdownMenuItem(
                                        child: Text(getPenaltyTitle(PenaltyType.minutesByMoney)),
                                        value: PenaltyType.minutesByMoney)
                                  ],
                                  onChanged: (type) async {
                                    var res = await showDialog<Penalty>(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) => DialogPenalty(
                                        penalty: Penalty(type: type, parentUid: vModel.entry.uid),
                                        isNewPenalty: true,
                                        screenEntryVModel: vModel,
                                      ),
                                    );
                                    if (res != null) vModel.addPenalty(res);
                                  })),
                        ],
                      ),
                      ViewPenalties(vModel),
                      Center(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                    color: AppColors.error,
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      vModel.removeEntry();
                                      return Navigator.of(context).pop();
                                    }),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                    child: Text('НАЗАД'),
                                    onPressed: () => Navigator.of(context).pop()),
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
