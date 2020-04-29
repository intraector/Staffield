extension MonthTitle on int {
  String get monthTitle {
    String result;
    switch (this) {
      case 1:
        result = 'январь';
        break;
      case 2:
        result = 'февраль';
        break;
      case 3:
        result = 'март';
        break;
      case 4:
        result = 'апрель';
        break;
      case 5:
        result = 'май';
        break;
      case 6:
        result = 'июнь';
        break;
      case 7:
        result = 'июль';
        break;
      case 8:
        result = 'август';
        break;
      case 9:
        result = 'сентябрь';
        break;
      case 10:
        result = 'октябрь';
        break;
      case 11:
        result = 'ноябрь';
        break;
      case 12:
        result = 'декабрь';
        break;
    }
    return result;
  }
}
