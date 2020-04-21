import 'package:Staffield/models/entry.dart';

abstract class EntriesRepositoryInterface {
  Future<List<Entry>> fetch();
  Future<bool> addOrUpdate(Entry entry);
  void remove(String uid);
}
