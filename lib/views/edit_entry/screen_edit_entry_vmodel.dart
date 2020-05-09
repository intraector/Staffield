import 'dart:async';

import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entries_repository.dart';
import 'package:Staffield/core/models/employee.dart';
import 'package:Staffield/core/models/entry.dart';
import 'package:Staffield/core/models/penalty.dart';
import 'package:Staffield/core/models/penalty_type.dart';
import 'package:Staffield/core/penalty_types_repository.dart';
import 'package:Staffield/core/utils/calc_total_mixin.dart';
import 'package:Staffield/utils/dialog_confirm.dart';
import 'package:Staffield/utils/format_input_currency.dart';
import 'package:Staffield/utils/string_utils.dart';
import 'package:Staffield/views/dialog_penalty_type/dialog_penalty_type.dart';
import 'package:Staffield/views/edit_employee/dialog_edit_employee.dart';
import 'package:Staffield/views/edit_entry/dialog_penalty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ScreenEditEntryVModel with ChangeNotifier, CalcTotal {
  //-----------------------------------------
  ScreenEditEntryVModel(String uid) {
    this.entry = uid == null ? Entry() : _entriesRepo.getEntry(uid);
    txtCtrlRevenue.text =
        uid == null ? '' : entry.revenue?.roundToDouble().toString()?.formatCurrency();
    txtCtrlInterest.text = uid == null ? '' : entry.interest?.toString()?.formatCurrency() ?? '';
    txtCtrlWage.text = uid == null ? '' : entry.wage?.toString()?.formatCurrency() ?? '';
    penalties = entry.penalties.map((penalty) => Penalty.fromOther(penalty)).toList();
    entry.penaltiesTotalAux = entry.revenue * entry.interest / 100 ?? 0;
  }

  Entry entry;
  String labelBonus = 'БОНУС';
  String labelInterest = 'ПРОЦЕНТ';
  String labelName = 'СОТРУДНИК';
  String labelPenalties = 'ШТРАФЫ';
  String labelRevenue = 'ВЫРУЧКА';
  String labelWage = 'ОКЛАД';
  final int nameMaxLength = 40;
  List<Penalty> penalties;
  var txtCtrlInterest = TextEditingController();
  var txtCtrlRevenue = TextEditingController();
  var txtCtrlWage = TextEditingController();

  final _employeesRepo = getIt<EmployeesRepository>();
  final _entriesRepo = getIt<EntriesRepository>();
  final int _interestMaxLength = 5;
  var _interestPreviosInput = '';
  final _penaltyTypesRepo = getIt<PenaltyTypesRepository>();
  final int _revenueMaxLength = 10;
  var _revenuePreviosInput = '';
  final int _wageMaxLength = 10;
  var _wagePreviosInput = '';

  //-----------------------------------------
  String get bonus => entry.bonusAux.toString().formatCurrency();

  //-----------------------------------------
  List<Employee> get employeesItems {
    var result = _employeesRepo.repo.toList()
      ..add(Employee(name: 'Добавить сотрудника...', uid: '111'));
    return result;
  }

  //-----------------------------------------
  String get employeeUid => entry.employeeUid.isEmpty ? null : entry.employeeUid;

  //-----------------------------------------
  String get penaltiesTotal => entry.penaltiesTotalAux.toString().formatCurrency();

  //-----------------------------------------
  List<DropdownMenuItem> get penaltyTypesList {
    _penaltyTypesRepo.repo.forEach((element) {});
    var list = _penaltyTypesRepo.repo
        .map((type) => DropdownMenuItem<String>(child: Text(type.title), value: type.uid))
        .toList();
    list.add(DropdownMenuItem<String>(child: Text('Создать новый...'), value: '111'));
    return list;
  }

  //-----------------------------------------
  String get total => entry.total.toString().formatCurrency();

  //-----------------------------------------
  void calcTotal() {
    var revenue = double.tryParse(txtCtrlRevenue.text.replaceAll(' ', '')) ?? 0;
    var interest = double.tryParse(txtCtrlInterest.text.replaceAll(' ', '')) ?? 0;
    var wage = double.tryParse(txtCtrlWage.text.replaceAll(' ', '')) ?? 0;
    var result =
        calcTotalAndBonus(revenue: revenue, interest: interest, wage: wage, penalties: penalties);
    entry.bonusAux = result.bonus;
    entry.total = result.total;
    entry.penaltiesTotalAux = result.penaltiesTotal;
    notifyListeners();
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
  PenaltyType getPenaltyType(String uid) {
    return _penaltyTypesRepo.getType(uid);
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
  void handlePenalty(BuildContext context, String typeUid) {
    if (typeUid != '111')
      _addPenalty(context, typeUid);
    else
      _addPenaltyType(context);
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
  void removePenalty(Penalty item) {
    var index = penalties.indexOf(item);
    if (index >= 0) penalties.removeAt(index);
    calcTotal();
    notifyListeners();
  }

  //-----------------------------------------
  void save() {
    entry.timestamp = DateTime.now().millisecondsSinceEpoch;
    entry.penalties = penalties.toList();
    calcTotal();
    _entriesRepo.addOrUpdate([entry]);
  }

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
  String validateInterest(String txt) {
    if (txt.isEmpty)
      return '!';
    else if (txt.endsWith('.'))
      return '!';
    else if ((double.tryParse(txt) ?? 101) > 100)
      return '!';
    else {
      entry.interest = double.parse(txtCtrlInterest.text.removeSpaces());
      return null;
    }
  }

  //-----------------------------------------
  String validateRevenue(String txt) {
    if (txt.isEmpty)
      return '!';
    else if (txt.endsWith('.'))
      return '!';
    else {
      entry.revenue = double.parse(txtCtrlRevenue.text.removeSpaces());
      return null;
    }
  }

  //-----------------------------------------
  String validateWage(String txt) {
    if (txt.isEmpty)
      return '!';
    else if (txt.endsWith('.'))
      return '!';
    else {
      entry.wage = double.parse(txtCtrlWage.text.removeSpaces());
      return null;
    }
  }

  //-----------------------------------------
  Future<void> _addPenalty(BuildContext context, String typeUid) async {
    var result = await showDialog<Penalty>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => DialogPenalty(
        penalty: Penalty(typeUid: typeUid, parentUid: entry.uid),
        isNewPenalty: true,
        screenEntryVModel: this,
      ),
    );
    if (result != null) penalties.add(result);
    calcTotal();
    notifyListeners();
  }

  //-----------------------------------------
  Future<void> _addPenaltyType(BuildContext context) async {
    var result = await showDialog<PenaltyType>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => DialogPenaltyType(penaltyType: PenaltyType()),
    );
    if (result != null) _penaltyTypesRepo.addOrUpdate(result);

    notifyListeners();
  }
}
