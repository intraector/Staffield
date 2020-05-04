String timeAndDifference({
  int timestamp1,
  int timestamp2,
  DateTime date1,
  DateTime date2,
  bool showTime = false,
  bool showDate = false,
  bool showDateDigits = false,
  bool showYear = false,
  bool spellToday = true,
  bool spellTodayAdditional = false,
}) {
  if (spellToday) spellTodayAdditional = false;
  assert(timestamp1 == null || date1 == null);
  assert(timestamp2 == null || date2 == null);
  if (timestamp1 == null && date1 == null) return '';

  String timeString = '';
  String dateString = '';
  String yearString = '';

  if (timestamp1 != null) date1 = DateTime.fromMillisecondsSinceEpoch(timestamp1);
  if (timestamp2 == null) {
    if (date2 == null) date2 = DateTime.now();
  } else
    date2 = DateTime.fromMillisecondsSinceEpoch(timestamp2);
  if (showDate) {
    bool isToday = false;
    if (date2.difference(date1).inDays == 0 && date2.day == date1.day) isToday = true;
    if (isToday) {
      if (spellToday) {
        dateString = 'сегодня';
        showYear = false;
      } else {
        String todayAdditional = spellTodayAdditional ? ' (сегодня)' : '';
        dateString = dateString = _processMonth(date1) + todayAdditional;
      }
    } else
      dateString = _processMonth(date1);
  }
  if (showDateDigits) {
    if (date2.difference(date1).inDays == 0 && date2.day == date1.day) {
      dateString = '';
      showYear = false;
    } else {
      dateString = '${date1.day}/${date1.month} ';
    }
  }
  if (showTime) {
    timeString = date1.minute < 10 ? '0' + date1.minute.toString() : date1.minute.toString();
    timeString = '${date1.hour}:' + timeString;
  }
  if (showYear) yearString = date1.year.toString() + ' ';
  return '$dateString$yearString$timeString';
}

//-----------------------------------------
_processMonth(DateTime date) {
  String _month = '';
  switch (date.month) {
    case 1:
      _month = 'января';
      break;
    case 2:
      _month = 'февраля';
      break;
    case 3:
      _month = 'марта';
      break;
    case 4:
      _month = 'апреля';
      break;
    case 5:
      _month = 'мая';
      break;
    case 6:
      _month = 'июня';
      break;
    case 7:
      _month = 'июля';
      break;
    case 8:
      _month = 'августа';
      break;
    case 9:
      _month = 'сентября';
      break;
    case 10:
      _month = 'октября';
      break;
    case 11:
      _month = 'ноября';
      break;
    case 12:
      _month = 'декабря';
      break;
  }
  return '${date.day} $_month ';
}
