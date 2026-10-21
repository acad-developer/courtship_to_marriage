import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final int collapsedLines;

  const ExpandableText({
    super.key,
    required this.text,
    required this.style,
    this.collapsedLines = 3,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final painter = TextPainter(
        text: TextSpan(text: widget.text, style: widget.style),
        maxLines: widget.collapsedLines,
        textDirection: Directionality.of(context),
      )..layout(maxWidth: constraints.maxWidth);
      final overflows = painter.didExceedMaxLines;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: widget.style,
            maxLines: _expanded ? null : widget.collapsedLines,
            overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
          if (overflows)
            GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _expanded ? 'SHOW LESS' : 'SHOW MORE',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}