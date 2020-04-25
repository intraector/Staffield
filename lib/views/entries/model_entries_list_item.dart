import 'package:Staffield/models/entry.dart';
import 'package:Staffield/utils/string_utils.dart';

class ModelEntriesListItem {
  ModelEntriesListItem.fromEntry(Entry entry) {
    uid = entry.uid;
    name = entry.employeeName;
    timestamp = entry.timestamp;
    total = entry.total.toString().formatCurrencyDecimal();
  }

  String uid = '';
  String name = '';
  String total = '';
  int timestamp;
  @override
  String toString() {
    return '$uid, name: $name';
  }
}
