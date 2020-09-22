import 'package:Staffield/core/entities/penalty_type.dart';
import 'package:Staffield/core/penalty_types_repository_interface.dart';
import 'package:Staffield/services/sqlite/srvc_sqlite_penalty_types.dart';

class SrvcSqlitePenaltyTypesAdapter implements PenaltyTypeRepositoryInterface {
  final _srvcSqlitePenaltyTypes = SrvcSqlitePenaltyTypes();

  //-----------------------------------------
  @override
  Future<List<PenaltyType>> fetch() async {
    var result = await _srvcSqlitePenaltyTypes.fetch();
    return result.map((map) => PenaltyType.fromSqlite(map)).toList();
  }

  //-----------------------------------------
  @override
  Future<bool> addOrUpdate(PenaltyType type) => _srvcSqlitePenaltyTypes.addOrUpdate(type.toSqlite);

  //-----------------------------------------
  @override
  Future<int> hideUnhide({String uid, bool hide}) =>
      _srvcSqlitePenaltyTypes.hideUnhide(uid: uid, hide: hide);
}
