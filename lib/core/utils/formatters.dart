/// Форматує суму у гривнях: 144 → «144 ₴», 450000 → «450 000 ₴».
String formatMoney(double value) {
  final negative = value < 0;
  final digits = value.abs().round().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('\u00A0');
    buffer.write(digits[i]);
  }
  return '${negative ? '-' : ''}${buffer.toString()}\u00A0₴';
}

/// Форматує дату у вигляді дд.мм.рррр.
String formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day.$month.${date.year}';
}

/// Форматує частку (0..1) у відсотках.
String formatPercent(double fraction) => '${(fraction * 100).round()}%';

/// Форматує кількість: 40.0 → «40», 4.5 → «4.5».
String formatQuantity(double value) {
  return value == value.roundToDouble()
      ? value.toInt().toString()
      : value.toStringAsFixed(1);
}
