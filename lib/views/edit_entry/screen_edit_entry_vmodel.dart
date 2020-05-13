import 'dart:async';

import 'package:Staffield/constants/router_paths.dart';
import 'package:Staffield/core/employees_repository.dart';
import 'package:Staffield/core/entries_repository.dart';
import 'package:Staffield/core/models/employee.dart';
import 'package:Staffield/core/models/entry.dart';
import 'package:Staffield/core/models/penalty.dart';
import 'package:Staffield/core/models/penalty_type.dart';
import 'package:Staffield/core/penalty_types_repository.dart';
import 'package:Staffield/core/utils/calc_total_mixin.dart';
import 'package:Staffield/services/router.dart';
import 'package:Staffield/utils/dialog_confirm.dart';
import 'package:Staffield/utils/string_utils.dart';
import 'package:Staffield/views/common/text_feild_handler/text_field_handler_double.dart';
import 'package:Staffield/views/edit_employee/dialog_edit_employee.dart';
import 'package:Staffield/views/edit_entry/dialog_penalty/dialog_penalty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ScreenEditEntryVModel with ChangeNotifier, CalcTotal {
  ScreenEditEntryVModel(String uid) {
    this.entry = uid == null ? Entry() : _entriesRepo.getEntry(uid);
    wage = TextFieldHandlerDouble(
      label: 'ОКЛАД',
      defaultValue: uid == null ? '' : entry.wage?.roundToDouble().toString()?.formatDouble,
      onChange: calcTotal,
    );
    revenue = TextFieldHandlerDouble(
      label: 'ВЫРУЧКА',
      defaultValue: uid == null ? '' : entry.revenue?.roundToDouble().toString()?.formatDouble,
      onChange: calcTotal,
    );
    interest = TextFieldHandlerDouble(
      label: 'ПРОЦЕНТ',
      maxLength: 5,
      defaultValue: uid == null ? '' : entry.interest?.roundToDouble().toString()?.formatDouble,
      onChange: calcTotal,
      validator: validateInterest,
    );
    penalties = entry.penalties.map((penalty) => Penalty.fromOther(penalty)).toList();
    entry.penaltiesTotalAux = entry.revenue * entry.interest / 100 ?? 0;
  }

  Entry entry;
  TextFieldHandlerDouble interest;
  String labelBonus = 'БОНУС';
  String labelName = 'СОТРУДНИК';
  String labelPenalties = 'ШТРАФЫ';
  final int nameMaxLength = 40;
  List<Penalty> penalties;
  TextFieldHandlerDouble revenue;
  TextFieldHandlerDouble wage;

  final _employeesRepo = getIt<EmployeesRepository>();
  final _entriesRepo = getIt<EntriesRepository>();
  final _penaltyTypesRepo = getIt<PenaltyTypesRepository>();

  //-----------------------------------------
  String get bonus => entry.bonusAux.toString().formatDouble;

  //-----------------------------------------
  List<Employee> get employeesItems {
    var result = _employeesRepo.repo.toList()
      ..add(Employee(name: 'Добавить сотрудника...', uid: '111'));
    return result;
  }

  //-----------------------------------------
  String get employeeUid => entry.employeeUid.isEmpty ? null : entry.employeeUid;

  //-----------------------------------------
  String get penaltiesTotal => entry.penaltiesTotalAux.toString().formatDouble;

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
    entry.bonusAux = result.bonus;
    entry.total = result.total;
    entry.penaltiesTotalAux = result.penaltiesTotal;
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
    calcTotal();
    notifyListeners();
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
  void _addPenaltyType(BuildContext context) {
    Router.sailor.navigate(RouterPaths.editPenaltyType, params: {'penaltyType': PenaltyType()});
  }
}
