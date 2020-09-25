import 'dart:ui';

import 'package:Staffield/constants/app_colors.dart';
import 'package:uuid_type/uuid_type.dart';

class Employee {
  Employee({String uid, this.name = '', this.hide = false, Color color})
      : this.uid = uid ?? TimeBasedUuidGenerator().generate().toString(),
        this.color = color ?? AppColors.getRandomColor;
  String uid;
  String name;
  bool hide;
  Color color;

  @override
  String toString() => '$uid $name $hide';
}
