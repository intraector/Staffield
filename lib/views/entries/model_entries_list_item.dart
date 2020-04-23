import 'package:Staffield/models/entry.dart';

class ModelEntriesListItem {
  ModelEntriesListItem.fromEntry(Entry entry) {
    uid = entry.uid;
    name = entry.employeeName;
    timestamp = entry.timestamp;
  }

  String uid = '';
  String name = '';
  int timestamp;
}
