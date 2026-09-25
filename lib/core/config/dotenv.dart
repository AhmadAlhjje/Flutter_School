/// Parses `KEY=value` lines of a `.env` file: `#` comments and blank lines are ignored,
/// surrounding quotes are removed, later keys win. Pure Dart (unit-tested).
Map<String, String> parseDotEnv(String content) {
  final values = <String, String>{};
  for (final raw in content.split(RegExp(r'\r?\n'))) {
    final line = raw.trim();
    if (line.isEmpty || line.startsWith('#')) continue;
    final separator = line.indexOf('=');
    if (separator <= 0) continue;
    final key = line.substring(0, separator).trim();
    var value = line.substring(separator + 1).trim();
    if (value.length >= 2 &&
        ((value.startsWith('"') && value.endsWith('"')) || (value.startsWith("'") && value.endsWith("'")))) {
      value = value.substring(1, value.length - 1);
    }
    values[key] = value;
  }
  return values;
}
