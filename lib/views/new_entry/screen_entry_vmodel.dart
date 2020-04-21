import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:Staffield/core/entries_repository.dart';
import 'package:Staffield/models/entry.dart';
import 'package:Staffield/models/penalty.dart';
import 'package:Staffield/utils/format_input_currency.dart';
import 'package:Staffield/utils/string_utils.dart';

final getIt = GetIt.instance;

class ScreenEntryVModel with ChangeNotifier {
  ScreenEntryVModel(String uid) {
    this.entry = uid == null ? Entry() : repo.getEntry(uid);
    txtCtrlRevenue.text = entry.revenue?.toString()?.formatCurrency() ?? '';
    txtCtrlWage.text = entry.wage?.toString()?.formatCurrency() ?? '';
    txtCtrlInterest.text = entry.interest?.toString()?.formatCurrency() ?? '';
    penalties = entry.penalties.map((penalty) => Penalty.fromOther(penalty)).toList();
  }

  final repo = getIt<EntriesRepository>();
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
  void addPenalty(Penalty newItem) {
    penalties.add(newItem);
    notifyListeners();
  }

  //-----------------------------------------
  void removePenalty(Penalty item) {
    var index = penalties.indexOf(item);
    if (index >= 0) penalties.removeAt(index);
    notifyListeners();
  }

  //-----------------------------------------
  void updatePenalty(Penalty item) {
    var index = penalties.indexOf(item);
    if (index >= 0) penalties[index] = item;
    notifyListeners();
  }

  //-----------------------------------------
  String validateName(txt) {
    if (txt.trim().isEmpty)
      return 'введите имя';
    else {
      entry.name = txt;
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
  }

  //-----------------------------------------
  void save() {
    entry.penalties = penalties.toList();
    repo.addOrUpdate(entry);
  }

  //-----------------------------------------
  void removeEntry() {
    repo.remove(entry);
  }

  //-----------------------------------------
  String labelName = 'Имя';
  String labelRevenue = 'Выручка';
  String labelWage = 'Оклад';
  String labelInterest = 'Процент';
}
