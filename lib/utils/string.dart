import 'package:flutter/material.dart';
import 'package:breakq/generated/l10n.dart';

/// [String] extensions.
extension StringExtension on String {
  bool get isNotNullOrEmpty => this != null && isNotEmpty;
  bool get isNullOrEmpty => this == null || isEmpty;

  List<TextSpan> getSpans({String matchWord = '', TextStyle style}) {
    final List<TextSpan> spans = <TextSpan>[];
    int spanBoundary = 0;

    final String _text = this;

    do {
      // look for the next match
      final int startIndex =
          _text.toLowerCase().indexOf(matchWord.toLowerCase(), spanBoundary);

      // if no more matches then add the rest of the string without style
      if (startIndex == -1) {
        spans.add(TextSpan(text: _text.substring(spanBoundary)));
        return spans;
      }

      // add any unstyled text before the next match
      if (startIndex > spanBoundary) {
        spans.add(TextSpan(text: _text.substring(spanBoundary, startIndex)));
      }

      // style the matched text
      final int endIndex = startIndex + matchWord.length;
      final String spanText = _text.substring(startIndex, endIndex);
      spans.add(TextSpan(text: spanText, style: style));

      // mark the boundary to start the next search from
      spanBoundary = endIndex;

      // continue until there are no more matches
    } while (spanBoundary < _text.length);

    return spans;
  }

  /// Prettify URL.
  String prettifyUrl() {
    final Uri urlObject = Uri.parse(this);

    return urlObject.host +
        ((urlObject.path != '' && urlObject.path != '/') ? urlObject.path : '');
  }

  /// Get initials for a given name.
  String get initials {
    final List<String> names = split(' ');
    String initials = '';
    int numWords = 1;

    if (numWords < names.length) {
      numWords = names.length;
    }
    for (int i = 0; i < numWords; i++) {
      initials += '${names[i][0]}';
    }
    return initials;
  }

  /// Truncate string with ellipsis.
  String truncateWithEllipsis(int cutoff) {
    return (length <= cutoff) ? this : '${substring(0, cutoff)}...';
  }
}
