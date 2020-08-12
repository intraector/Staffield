import 'package:Staffield/services/sqlite/sqlite_fields.dart';
import 'package:Staffield/services/sqlite/sqlite_tables.dart';
import 'package:flutter/foundation.dart';

class PrepareQuery {
  PrepareQuery.forEntries(
      {@required int greaterThan,
      @required int lessThan,
      @required String employeeUid,
      @required int limit}) {
    _from += ' FROM ${SqliteTable.entries}';
    _addEntriesGreaterThan(greaterThan);
    _addEntriesLessThan(lessThan);
    _addEntriesEmployeeUid(employeeUid);
    _orderBy = ' ORDER BY timestamp DESC';
    _addLimit(limit);
  }

  PrepareQuery.forPenalties(
      {@required int greaterThan,
      @required int lessThan,
      @required String parentUid,
      @required int limit}) {
    _from += ' FROM ${SqliteTable.penalties}';
    _addPenaltiesGreaterThan(greaterThan);
    _addPenaltiesLessThan(lessThan);
    _addPenaltiesParentUid(parentUid);
    _addLimit(limit);
  }

  final _select = 'SELECT *';
  var _from = '';
  var _whereClause = '';
  var _orderBy = '';
  var _limit = '';

  String get string => _select + _from + _whereClause + _orderBy + _limit;

  //-----------------------------------------
  void _addEntriesGreaterThan(int greaterThan) {
    if (greaterThan == null) return;
    _whereClause += _whereClause.isEmpty ? ' WHERE' : ' AND';
    _whereClause += ' ${SqliteFieldsEntries.timestamp} > $greaterThan';
  }

  //-----------------------------------------
  void _addEntriesLessThan(int lessThan) {
    // lessThan = null;
    if (lessThan == null) return;
    _whereClause += _whereClause.isEmpty ? ' WHERE' : ' AND';
    _whereClause += ' ${SqliteFieldsEntries.timestamp} < $lessThan';
  }

  //-----------------------------------------
  void _addEntriesEmployeeUid(String employeeUid) {
    if (employeeUid == null) return;
    _whereClause += _whereClause.isEmpty ? ' WHERE' : ' AND';
    _whereClause += ' ${SqliteFieldsEntries.employeeUid} = \'$employeeUid\'';
  }

  //-----------------------------------------
  void _addPenaltiesGreaterThan(int greaterThan) {
    if (greaterThan == null) return;
    _whereClause += _whereClause.isEmpty ? ' WHERE' : ' AND';
    _whereClause += ' ${SqliteFieldsPenalties.timestamp} > $greaterThan';
  }

  //-----------------------------------------
  void _addPenaltiesLessThan(int lessThan) {
    if (lessThan == null) return;
    _whereClause += _whereClause.isEmpty ? ' WHERE' : ' AND';
    _whereClause += ' ${SqliteFieldsPenalties.timestamp} < $lessThan';
  }

  //-----------------------------------------
  void _addPenaltiesParentUid(String parentUid) {
    if (parentUid == null) return;
    _whereClause += _whereClause.isEmpty ? ' WHERE' : ' AND';
    _whereClause += ' ${SqliteFieldsPenalties.parentUid} = \'$parentUid\'';
  }

  //-----------------------------------------
  void _addLimit(int limit) {
    if (limit == null) return;
    _limit = ' LIMIT ' + limit.toString();
  }
}
