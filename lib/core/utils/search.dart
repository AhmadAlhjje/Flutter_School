/// Arabic-friendly "search by name": ignores case, diacritics (tashkeel), tatweel and the usual
/// letter variants (أ إ آ ٱ → ا, ة → ه, ى → ي, ؤ → و, ئ → ي), so «الاشتقاق» finds «الإشتقاق».
String normalizeForSearch(String text) {
  final buffer = StringBuffer();
  for (final rune in text.toLowerCase().runes) {
    if ((rune >= 0x064B && rune <= 0x0652) || rune == 0x0670 || rune == 0x0640) continue;
    buffer.writeCharCode(switch (rune) {
      0x0623 || 0x0625 || 0x0622 || 0x0671 => 0x0627,
      0x0629 => 0x0647,
      0x0649 => 0x064A,
      0x0624 => 0x0648,
      0x0626 => 0x064A,
      _ => rune,
    });
  }
  return buffer.toString().replaceAll(RegExp(r'\s+'), ' ').trim();
}

/// True when [text] contains [query] (an empty query matches everything).
bool matchesSearch(String text, String query) {
  final wanted = normalizeForSearch(query);
  return wanted.isEmpty || normalizeForSearch(text).contains(wanted);
}
