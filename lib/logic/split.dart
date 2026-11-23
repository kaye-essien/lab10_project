/// Pure bill-splitting logic kept separate from UI widgets for easy unit testing.
double shareOf(double total, int people, {double tipPercent = 0}) {
  if (people < 1) throw ArgumentError('people must be at least 1');
  if (tipPercent < 0) throw ArgumentError('tipPercent cannot be negative');
  final totalWithTip = total * (1 + tipPercent / 100);
  return totalWithTip / people;
}