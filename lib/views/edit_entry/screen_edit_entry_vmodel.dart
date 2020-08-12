import 'dart:async';

import 'package:Staffield/constants/router_paths.dart';
import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entries_repository.dart';
import 'package:Staffield/core/models/employee.dart';
import 'package:Staffield/core/models/entry.dart';
import 'package:Staffield/core/models/penalty.dart';
import 'package:Staffield/core/models/penalty_mode.dart';
import 'package:Staffield/core/models/penalty_type.dart';
import 'package:Staffield/core/penalty_types_repository.dart';
import 'package:Staffield/core/utils/calc_total_mixin.dart';
import 'package:Staffield/services/router.dart';
import 'package:Staffield/utils/string_utils.dart';
import 'package:Staffield/views/common/dialog_confirm.dart';
import 'package:Staffield/views/common/text_feild_handler/text_field_handler_double.dart';
import 'package:Staffield/views/edit_employee/dialog_edit_employee.dart';
import 'package:Staffield/views/edit_entry/dialog_penalty/dialog_penalty.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ScreenEditEntryVModel with ChangeNotifier, CalcTotal {
  Entry entry;
  TextFieldHandlerDouble interest;
  String labelBonus = 'БОНУС';
  String labelName = 'СОТРУДНИК';
  String labelPenalties = 'ШТРАФЫ';
  final int nameMaxLength = 40;
  double _penaltiesTotal;
  double _bonusAux;

  List<Penalty> penalties;
  TextFieldHandlerDouble revenue;
  TextFieldHandlerDouble wage;
  final dropdownState = GlobalKey<FormFieldState>();
  final _employeesRepo = getIt<EmployeesRepository>();

  final _entriesRepo = getIt<EntriesRepository>();
  final _penaltyTypesRepo = getIt<PenaltyTypesRepository>();

  ScreenEditEntryVModel(String uid) {
    this.entry = uid == null ? Entry() : _entriesRepo.getEntry(uid);
    wage = TextFieldHandlerDouble(
      label: 'ОКЛАД',
      defaultValue: uid == null ? '' : entry.wage?.toString()?.formatDouble?.noDotZero,
      onChange: calcTotalAndNotify,
    );
    revenue = TextFieldHandlerDouble(
      label: 'ВЫРУЧКА',
      defaultValue: uid == null ? '' : entry.revenue?.toString()?.formatDouble?.noDotZero,
      onChange: calcTotalAndNotify,
    );
    interest = TextFieldHandlerDouble(
      label: 'ПРОЦЕНТ',
      maxLength: 5,
      defaultValue: uid == null ? '' : entry.interest?.toString()?.formatDouble?.noDotZero,
      onChange: calcTotalAndNotify,
      validator: validateInterest,
    );
    penalties = entry.penalties.map((penalty) => Penalty.fromOther(penalty)).toList();
    calcTotal();
  }

  //-----------------------------------------
  String get bonus => _bonusAux.toString().formatDouble;

  //-----------------------------------------
  List<DropdownMenuItem<String>> get employeesItems {
    var result = _employeesRepo.repoWhereHidden(false)
      ..add(Employee(name: 'Добавить сотрудника...', uid: '111'));

    return result
        .map((employee) => DropdownMenuItem(value: employee.uid, child: Text(employee.name)))
        .toList();
  }

  //-----------------------------------------
  String get employeeUid => entry.employeeUid.isEmpty ? null : entry.employeeUid;

  //-----------------------------------------
  String get penaltiesTotal => _penaltiesTotal.toString().formatDouble;

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
  String get total => entry.total.toString().formatDouble;

  //-----------------------------------------
  void calcTotal() {
    var result = calcTotalAndBonus(
      revenue: revenue.result,
      interest: interest.result,
      wage: wage.result,
      penalties: penalties,
    );
    _bonusAux = result.bonus;
    entry.total = result.total;
    _penaltiesTotal = result.penaltiesTotal;
  }

  //-----------------------------------------
  void calcTotalAndNotify() {
    calcTotal();
    notifyListeners();
  }

  //-----------------------------------------
  PenaltyType getPenaltyType(String uid) => _penaltyTypesRepo.getType(uid);

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
    calcTotalAndNotify();
  }

  //-----------------------------------------
  void save() {
    entry.timestamp = DateTime.now().millisecondsSinceEpoch;
    entry.penalties = penalties.toList();
    entry.wage = wage.result;
    entry.revenue = revenue.result;
    entry.interest = interest.result;
    calcTotal();
    _entriesRepo.addOrUpdate([entry]);
  }

  //-----------------------------------------
  Future<void> setEmployeeUid(String uid, BuildContext context) async {
    if (uid != '111') {
      entry.employeeUid = uid;
      entry.employeeName = _employeesRepo.getEmployee(uid).name;
    } else {
      var result =
          await showDialog<String>(context: context, builder: (context) => DialogEditEmployee());
      if (result != null) {
        entry.employeeUid = result;
        entry.employeeName = _employeesRepo.getEmployee(result).name;
        dropdownState.currentState.didChange(result);
      }
    }
    notifyListeners();
  }

  //-----------------------------------------
  void updatePenalty(Penalty item) {
    var index = penalties.indexOf(item);
    if (index >= 0) penalties[index] = item;
    calcTotalAndNotify();
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
      return 'Введите';
    else if (txt.endsWith('.'))
      return 'Проверьте';
    else if ((double.tryParse(txt) ?? 101) > 100)
      return 'Проверьте';
    else {
      return null;
    }
  }

  //-----------------------------------------
  Future<void> _addPenalty(BuildContext context, String typeUid) async {
    var result = await showDialog<Penalty>(
      context: context,
      builder: (BuildContext context) => DialogPenalty(
        penalty: Penalty(typeUid: typeUid, parentUid: entry.uid),
        isNewPenalty: true,
        screenEntryVModel: this,
      ),
    );
    if (result != null) penalties.add(result);
    calcTotalAndNotify();
  }

  //-----------------------------------------
  void _addPenaltyType(BuildContext context) {
    Router.sailor.navigate(RouterPaths.editPenaltyType,
        params: {'penaltyType': PenaltyType(mode: PenaltyMode.plain)});
  }
}
