/// Plain-text projection of Woohoo-provided HTML (descriptions, T&C,
/// how-to-use). The app deliberately renders this content as styled plain
/// text instead of shipping an HTML engine: payloads are simple (`<br>`,
/// `<p>`, `<ol><li>`, inline spans) and brand markup carries hard-coded
/// colors that would clash with the app theme.
library;

/// Converts an HTML/entity-laden string into clean plain text:
/// block tags (`<br>`, `<p>`, `<div>`, `<h1..6>`, `<tr>`) become newlines,
/// `<li>` becomes a `• ` bullet line, remaining tags are stripped, common
/// entities are decoded, and blank lines are collapsed.
String gcHtmlToPlainText(String raw) {
  var text = raw
      // Line-producing tags first, while the markup is still present.
      .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
      .replaceAll(
        RegExp(r'</(p|div|h[1-6]|tr|ol|ul)\s*>', caseSensitive: false),
        '\n',
      )
      .replaceAll(RegExp(r'<li[^>]*>', caseSensitive: false), '\n• ')
      // Everything else (spans, anchors, styling) is dropped wholesale.
      .replaceAll(RegExp(r'<[^>]+>'), '')
      // Entities the Woohoo payloads actually use.
      .replaceAll(RegExp('&nbsp;', caseSensitive: false), ' ')
      .replaceAll(RegExp('&bull;', caseSensitive: false), '•')
      .replaceAll(RegExp('&amp;', caseSensitive: false), '&')
      .replaceAll(RegExp('&quot;', caseSensitive: false), '"')
      .replaceAll('&#39;', "'")
      .replaceAll('&rsquo;', "'")
      .replaceAll('&lsquo;', "'")
      .replaceAll('&ldquo;', '"')
      .replaceAll('&rdquo;', '"')
      .replaceAll('&ndash;', '–')
      .replaceAll('&mdash;', '—')
      // Escaped/literal newline variants.
      .replaceAll(r'\n', '\n')
      .replaceAll(RegExp(r'\r\n?'), '\n');

  // Tidy whitespace: trim each line, drop leading bullets-only artifacts,
  // collapse runs of blank lines.
  final lines = text
      .split('\n')
      .map((l) => l.replaceAll(RegExp(r'[ \t]+'), ' ').trim())
      .toList();

  final buffer = StringBuffer();
  var lastBlank = true;
  for (final line in lines) {
    if (line.isEmpty || line == '•') {
      if (!lastBlank) buffer.write('\n');
      lastBlank = true;
      continue;
    }
    if (!lastBlank) buffer.write('\n');
    buffer.write(line);
    lastBlank = false;
  }
  return buffer.toString().trim();
}

/// Splits normalized text into display lines, keeping bullet markers.
/// Useful for rendering step/bullet lists from `gcHtmlToPlainText` output.
List<String> gcHtmlToLines(String raw) => gcHtmlToPlainText(raw)
    .split('\n')
    .map((l) => l.trim())
    .where((l) => l.isNotEmpty)
    .toList();
