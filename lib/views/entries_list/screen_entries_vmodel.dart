import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:Staffield/core/entries_repository.dart';
import 'package:Staffield/views/entries_list/model_entries_list_item.dart';

class ScreenEntriesVModel with StatesRebuilder {
  ScreenEntriesVModel() {
    _repo.updates.listen((data) {
      updateList();
    });
  }
  var list = <ModelEntriesListItem>[];
  int recordsPerScreen = 10;
  final _repo = Injector.get<EntriesRepository>();

  //-----------------------------------------
  void updateList() {
    list = _repo.repo
        .take(recordsPerScreen)
        .map((entry) => ModelEntriesListItem.fromEntry(entry))
        .toList();
    rebuildStates();
  }
}
