import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

/// Text that turns emails, phone numbers and web links into tappable links.
class LinkedText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const LinkedText(this.text, {super.key, required this.style});

  @override
  State<LinkedText> createState() => _LinkedTextState();
}

class _LinkedTextState extends State<LinkedText> {
  static final _pattern = RegExp(
    r'([A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,})'
    r'|(https?://[^\s]+)'
    r'|(\+\d[\d ]{8,}\d)',
  );

  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void dispose() {
    for (final r in _recognizers) {
      r.dispose();
    }
    super.dispose();
  }

  Future<void> _open(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
  }

  String _urlFor(String match) {
    if (match.contains('@') && !match.startsWith('http')) return 'mailto:$match';
    if (match.startsWith('http')) return match;
    return 'tel:${match.replaceAll(' ', '')}';
  }

  List<InlineSpan> _spans() {
    for (final r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();

    final spans = <InlineSpan>[];
    var last = 0;
    for (final m in _pattern.allMatches(widget.text)) {
      if (m.start > last) {
        spans.add(TextSpan(text: widget.text.substring(last, m.start)));
      }
      final value = m.group(0)!;
      final recognizer = TapGestureRecognizer()
        ..onTap = () => _open(_urlFor(value));
      _recognizers.add(recognizer);
      spans.add(TextSpan(
        text: value,
        recognizer: recognizer,
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.primary,
        ),
      ));
      last = m.end;
    }
    if (last < widget.text.length) {
      spans.add(TextSpan(text: widget.text.substring(last)));
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(style: widget.style, children: _spans()));
  }
}
