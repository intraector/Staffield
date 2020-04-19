import 'package:staff_time/models/entry.dart';

abstract class InterfaceEntriesRepository {
  Future<List<Entry>> fetch();
  Future<bool> add(Entry entry);
  void remove(String uid);
  void update();
}
