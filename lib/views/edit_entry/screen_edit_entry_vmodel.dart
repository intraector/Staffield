import 'dart:async';

import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/models/employee.dart';
import 'package:Staffield/core/utils/calc_total_mixin.dart';
import 'package:Staffield/utils/dialog_confirm.dart';
import 'package:Staffield/views/edit_employee/dialog_edit_employee.dart';
import 'package:Staffield/views/edit_entry/dialog_penalty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:Staffield/core/entries_repository.dart';
import 'package:Staffield/core/models/entry.dart';
import 'package:Staffield/core/models/penalty.dart';
import 'package:Staffield/utils/format_input_currency.dart';
import 'package:Staffield/utils/string_utils.dart';

final getIt = GetIt.instance;

class ScreenEditEntryVModel with ChangeNotifier, CalcTotal {
  ScreenEditEntryVModel(String uid) {
    this.entry = uid == null ? Entry() : _entriesRepo.getEntry(uid);
    txtCtrlRevenue.text =
        uid == null ? '' : entry.revenue?.roundToDouble().toString()?.formatCurrency();
    txtCtrlInterest.text = uid == null ? '' : entry.interest?.toString()?.formatCurrency() ?? '';
    txtCtrlWage.text = uid == null ? '' : entry.wage?.toString()?.formatCurrency() ?? '';
    penalties = entry.penalties.map((penalty) => Penalty.fromOther(penalty)).toList();
    entry.penaltiesTotalAux = entry.revenue * entry.interest / 100 ?? 0;
  }

  final _entriesRepo = getIt<EntriesRepository>();
  final _employeesRepo = getIt<EmployeesRepository>();
  Entry entry;
  List<Penalty> penalties;

  var txtCtrlRevenue = TextEditingController();
  var txtCtrlWage = TextEditingController();
  var txtCtrlInterest = TextEditingController();
  var _revenuePreviosInput = '';
  var _wagePreviosInput = '';
  var _interestPreviosInput = '';
  final int _revenueMaxLength = 10;
  final int _wageMaxLength = 10;
  final int nameMaxLength = 40;
  final int _interestMaxLength = 5;

  //-----------------------------------------
  String get bonus => entry.penaltiesTotalAux.toString().formatCurrency();

  //-----------------------------------------
  String get total => entry.total.toString().formatCurrency();

  //-----------------------------------------
  Future<void> addPenalty(BuildContext context, String type) async {
    var result = await showDialog<Penalty>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => DialogPenalty(
        penalty: Penalty(type: type, parentUid: entry.uid),
        isNewPenalty: true,
        screenEntryVModel: this,
      ),
    );
    if (result != null) penalties.add(result);
    calcTotal();
    notifyListeners();
  }

  //-----------------------------------------
  List<Employee> get employeesItems {
    var result = _employeesRepo.repo.toList()
      ..add(Employee(name: 'Добавить сотрудника...', uid: '111'));
    return result;
  }

  //-----------------------------------------
  String get employeeUid => entry.employeeUid.isEmpty ? null : entry.employeeUid;

  //-----------------------------------------
  Future<void> setEmployeeUid(String uid, BuildContext context) async {
    if (uid != '111')
      entry.employeeUid = uid;
    else {
      var result = await showDialog(context: context, builder: (context) => DialogEditEmployee());
      if (result != null) {
        entry.employeeUid = result;
        entry.employeeNameAux = _employeesRepo.getEmployee(result).name;
      }
    }
    notifyListeners();
  }

  //-----------------------------------------
  void removePenalty(Penalty item) {
    var index = penalties.indexOf(item);
    if (index >= 0) penalties.removeAt(index);
    calcTotal();
    notifyListeners();
  }

  //-----------------------------------------
  void updatePenalty(Penalty item) {
    var index = penalties.indexOf(item);
    if (index >= 0) penalties[index] = item;
    calcTotal();
    notifyListeners();
  }

  //-----------------------------------------
  String validateEmployeeUid(String txt) {
    if (txt == null)
      return 'Выберите сотрудника';
    else {
      return null;
    }
  }

  //-----------------------------------------
  String validateRevenue(String txt) {
    if (txt.isEmpty)
      return 'Введите выручку';
    else if (txt.endsWith('.'))
      return 'Проверьте ввод';
    else {
      entry.revenue = double.parse(txtCtrlRevenue.text.removeSpaces());
      return null;
    }
  }

  //-----------------------------------------
  String validateWage(String txt) {
    if (txt.isEmpty)
      return 'Введите выручку';
    else if (txt.endsWith('.'))
      return 'Проверьте ввод';
    else {
      entry.wage = double.parse(txtCtrlWage.text.removeSpaces());
      return null;
    }
  }

  //-----------------------------------------
  String validateInterest(String txt) {
    if (txt.isEmpty)
      return 'Введите процент';
    else if (txt.endsWith('.'))
      return 'Проверьте ввод';
    else if ((double.tryParse(txt) ?? 101) > 100)
      return 'Проверьте ввод';
    else {
      entry.interest = double.parse(txtCtrlInterest.text.removeSpaces());
      return null;
    }
  }

  //-----------------------------------------
  void formatRevenue() {
    var result = formatInputCurrency(
      newValue: txtCtrlRevenue.text,
      oldValue: _revenuePreviosInput,
      maxLength: _revenueMaxLength,
      separateThousands: true,
    );
    txtCtrlRevenue.value = TextEditingValue(
      text: result,
      composing: TextRange.empty,
      selection: TextSelection.collapsed(offset: result.length),
    );
    _revenuePreviosInput = result;
    calcTotal();
  }

  //-----------------------------------------
  void formatWage() {
    var result = formatInputCurrency(
      newValue: txtCtrlWage.text,
      oldValue: _wagePreviosInput,
      maxLength: _wageMaxLength,
      separateThousands: true,
    );
    txtCtrlWage.value = TextEditingValue(
      text: result,
      composing: TextRange.empty,
      selection: TextSelection.collapsed(offset: result.length),
    );
    _wagePreviosInput = result;
    calcTotal();
  }

  //-----------------------------------------
  void formatInterest() {
    var result = formatInputCurrency(
      newValue: txtCtrlInterest.text,
      oldValue: _interestPreviosInput,
      maxLength: _interestMaxLength,
    );
    txtCtrlInterest.value = TextEditingValue(
      text: result,
      composing: TextRange.empty,
      selection: TextSelection.collapsed(offset: result.length),
    );
    _interestPreviosInput = result;
    calcTotal();
  }

  //-----------------------------------------
  void save() {
    entry.timestamp = DateTime.now().millisecondsSinceEpoch;
    entry.penalties = penalties.toList();
    calcTotal();
    _entriesRepo.addOrUpdate([entry]);
  }

  //-----------------------------------------
  void calcTotal() {
    // var fold = penalties.fold<double>(0, (value, penalty) => value + penalty.total);
    var revenue = double.tryParse(txtCtrlRevenue.text.replaceAll(' ', '')) ?? 0;
    var interest = double.tryParse(txtCtrlInterest.text.replaceAll(' ', '')) ?? 0;
    var wage = double.tryParse(txtCtrlWage.text.replaceAll(' ', '')) ?? 0;
    var result =
        calcTotalAndBonus(revenue: revenue, interest: interest, wage: wage, penalties: penalties);
    // _bonus = revenue * interest / 100;
    entry.penaltiesTotalAux = result.penaltiesTotal;
    // entry.total = (wage + _bonus - fold).roundToDouble();
    entry.total = result.total;
    notifyListeners();
  }

  //-----------------------------------------
  Future<void> removeEntry(BuildContext context) async {
    var _isConfirmed = await dialogConfirm(context, text: 'Удалить эту запись?');
    if (_isConfirmed ?? false) {
      _entriesRepo.remove(entry.uid);
      Navigator.of(context).pop();
    }
  }

  //-----------------------------------------
  Future<void> goBack(BuildContext context) async {
    if (penalties.isEmpty)
      Navigator.of(context).pop();
    else {
      var isConfirmed =
          await dialogConfirm(context, text: ('Изменения не будут сохранены. Продолжить?'));
      if (isConfirmed ?? false) Navigator.of(context).pop();
    }
  }

  //-----------------------------------------
  String labelName = 'Сотрудник';
  String labelRevenue = 'Выручка';
  String labelInterest = 'Процент';
  String labelBonus = 'Бонус';
  String labelWage = 'Оклад';
}
