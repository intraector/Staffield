enum PenaltyType { plain, minutesByMoney }

String getPenaltyTitle(PenaltyType type) {
  String result;
  switch (type) {
    case PenaltyType.plain:
      result = 'Штраф';
      break;
    case PenaltyType.minutesByMoney:
      result = 'Опоздание';
      break;
  }
  return result;
}
