import 'package:intl/intl.dart';

/// 3725 → "1:02:05", 125 → "2:05".
String formatDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);
  String two(int value) => value.toString().padLeft(2, '0');
  return hours > 0 ? '$hours:${two(minutes)}:${two(seconds)}' : '$minutes:${two(seconds)}';
}

String formatBytes(int bytes, {String locale = 'ar'}) {
  const ar = ['بايت', 'ك.ب', 'م.ب', 'غ.ب'];
  const en = ['B', 'KB', 'MB', 'GB'];
  final units = locale == 'ar' ? ar : en;
  var value = bytes.toDouble();
  var unit = 0;
  while (value >= 1024 && unit < units.length - 1) {
    value /= 1024;
    unit++;
  }
  final text = unit == 0 || value >= 100 ? value.toStringAsFixed(0) : value.toStringAsFixed(1);
  return '$text ${units[unit]}';
}

String formatDate(DateTime date, String locale) => DateFormat.yMMMd(locale).format(date.toLocal());

String formatDateTime(DateTime date, String locale) => DateFormat.yMMMd(locale).add_Hm().format(date.toLocal());

/// Arabic-Indic digits → ASCII and separators removed (mirrors the backend normalization).
String normalizePhone(String raw) {
  var value = raw.trim().replaceAllMapped(RegExp('[٠-٩۰-۹]'), (match) {
    final code = match.group(0)!.codeUnitAt(0);
    return String.fromCharCode(0x30 + code - (code >= 0x06F0 ? 0x06F0 : 0x0660));
  });
  value = value.replaceAll(RegExp(r'[\s\-.()‎‏]'), '');
  if (value.startsWith('00')) value = '+${value.substring(2)}';
  return value;
}

bool isValidPhone(String value) => RegExp(r'^\+?\d{8,15}$').hasMatch(normalizePhone(value));

bool isStrongPassword(String value) =>
    value.length >= 8 &&
    value.length <= 128 &&
    RegExp(r'\p{L}', unicode: true).hasMatch(value) &&
    RegExp(r'\d').hasMatch(value);
