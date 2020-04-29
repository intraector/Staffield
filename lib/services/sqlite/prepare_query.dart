import 'package:Staffield/services/sqlite/sqlite_fields.dart';
import 'package:Staffield/services/sqlite/sqlite_tables.dart';
import 'package:flutter/foundation.dart';

class PrepareQuery {
  //-----------------------------------------
  PrepareQuery.forEntries({@required int start, @required int end, @required String employeeUid}) {
    _from += ' FROM ${SqliteTable.entries}';
    entriesStart(start);
    entriesEnd(end);
    entriesEmployeeUid(employeeUid);
    _orderBy = ' ORDER BY timestamp DESC';
  }

  //-----------------------------------------
  PrepareQuery.forPenalties({@required int start, @required int end, @required String parentUid}) {
    _from += ' FROM ${SqliteTable.penalties}';
    penaltiesStart(start);
    penaltiesEnd(end);
    penaltiesParentUid(parentUid);
  }

  final _select = 'SELECT *';
  var _from = '';
  var _whereClause = '';
  var _orderBy = '';

  String get string => _select + _from + _whereClause + _orderBy;

  //-----------------------------------------
  void entriesStart(int start) {
    if (start == null) return;
    _whereClause += _whereClause.isEmpty ? ' WHERE' : ' AND';
    _whereClause += ' ${SqliteFieldsEntries.timestamp} > $start';
  }

  //-----------------------------------------
  void entriesEnd(int end) {
    if (end == null) return;
    _whereClause += _whereClause.isEmpty ? ' WHERE' : ' AND';
    _whereClause += ' ${SqliteFieldsEntries.timestamp} < $end';
  }

  //-----------------------------------------
  void entriesEmployeeUid(String employeeUid) {
    if (employeeUid == null) return;
    _whereClause += _whereClause.isEmpty ? ' WHERE' : ' AND';
    _whereClause += ' ${SqliteFieldsEntries.employeeUid} = \'$employeeUid\'';
  }

  //-----------------------------------------
  void penaltiesStart(int start) {
    if (start == null) return;
    _whereClause += _whereClause.isEmpty ? ' WHERE' : ' AND';
    _whereClause += ' ${SqliteFieldsPenalties.timestamp} > $start';
  }

  //-----------------------------------------
  void penaltiesEnd(int end) {
    if (end == null) return;
    _whereClause += _whereClause.isEmpty ? ' WHERE' : ' AND';
    _whereClause += ' ${SqliteFieldsPenalties.timestamp} < $end';
  }

  //-----------------------------------------
  void penaltiesParentUid(String parentUid) {
    if (parentUid == null) return;
    _whereClause += _whereClause.isEmpty ? ' WHERE' : ' AND';
    _whereClause += ' ${SqliteFieldsPenalties.parentUid} = \'$parentUid\'';
  }
}
