import 'dart:math';

import 'package:Staffield/core/models/penalty_type.dart';
import 'package:Staffield/core/penalty_types_repository_interface.dart';

class PenaltyTypesRepository {
  PenaltyTypesRepository(this.sqlite) {
    _fetch();
  }
  final PenaltyTypeRepositoryInterface sqlite;
  var _repo = <PenaltyType>[];

  //-----------------------------------------
  List<PenaltyType> get repo => _repo;

  //-----------------------------------------
  PenaltyType getType(String typeUid) => _repo.firstWhere((type) => type.uid == typeUid);
  //-----------------------------------------
  Future<void> _fetch() async {
    _repo = await sqlite.fetch();
  }

  //-----------------------------------------
  PenaltyType getRandom() {
    var random = Random();
    return _repo[random.nextInt(_repo.length)];
  }

  //-----------------------------------------
  Future<bool> addOrUpdate(PenaltyType type) async {
    if (type.uid == null)
      return false;
    else {
      var index = _repo.indexWhere((item) => item.uid == type.uid);
      if (index < 0)
        _repo.add(type);
      else
        _repo[index] = type;
    }
    return sqlite.addOrUpdate(type);
  }

  //-----------------------------------------
  Future<int> hideUnHide(PenaltyType type) => sqlite.hideUnhide(uid: type.uid, hide: type.hide);
}
