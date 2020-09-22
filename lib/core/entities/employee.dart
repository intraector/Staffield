import 'package:uuid_type/uuid_type.dart';

class Employee {
  Employee({uid, this.name = '', this.hide = false})
      : this.uid = uid ?? TimeBasedUuidGenerator().generate().toString();
  String uid;
  String name;
  bool hide;

  @override
  String toString() => '$uid $name $hide';
}
