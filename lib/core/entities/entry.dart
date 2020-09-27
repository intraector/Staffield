import 'package:Staffield/core/entities/employee.dart';
import 'package:Staffield/core/entities/penalty.dart';
import 'package:uuid_type/uuid_type.dart';

class Entry {
  // String employeeName = '';
  // String employeeUid = '';
  Employee employee = Employee();
  double interest = 0;
  var penalties = <Penalty>[];
  double revenue = 0;
  int timestamp;
  double total = 0;
  String uid = TimeBasedUuidGenerator().generate().toString();
  double wage = 0;

  //-----------------------------------------
  @override
  String toString() =>
      'uid: $uid,  timestamp : $timestamp, total: $total, revenue: $revenue, wage: $wage, interest: $interest';
}
