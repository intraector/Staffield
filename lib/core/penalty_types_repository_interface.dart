import 'package:Staffield/core/models/penalty_type.dart';
import 'package:flutter/foundation.dart';

abstract class PenaltyTypeRepositoryInterface {
  Future<List<PenaltyType>> fetch();
  Future<bool> addOrUpdate(PenaltyType type);
  Future<int> hideUnhide({@required String uid, @required bool hide});
}
