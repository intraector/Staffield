import 'package:Staffield/core/models/entry.dart';

abstract class EntriesRepositoryInterface {
  Future<List<Entry>> fetch({int start, int end});
  Future<bool> addOrUpdate(Entry entry);
  void remove(String uid);
}
