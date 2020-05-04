import 'package:Staffield/core/models/entry.dart';

abstract class EntriesRepositoryInterface {
  Future<List<Entry>> fetch({int greaterThan, int lessThan, String employeeUid, int limit});
  Future<bool> addOrUpdate(List<Entry> entry);
  void remove(String uid);
}
