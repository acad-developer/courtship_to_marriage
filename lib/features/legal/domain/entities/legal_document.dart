/// Icons the presentation layer maps to real icons (keeps this layer Flutter-free).
enum LegalIcon { person, tune, shield, lock, description, gavel, payments }

class LegalHighlight {
  final LegalIcon icon;
  final String title;
  final String text;

  const LegalHighlight({
    required this.icon,
    required this.title,
    required this.text,
  });
}

class LegalSection {
  final String title;

  /// Text shown before the bullet list.
  final List<String> paragraphs;
  final List<String> bullets;

  /// Text shown after the bullet list.
  final List<String> closing;

  const LegalSection({
    required this.title,
    this.paragraphs = const [],
    this.bullets = const [],
    this.closing = const [],
  });
}

class LegalDocument {
  final String title;
  final String lastUpdated;
  final String intro;
  final List<LegalHighlight> highlights;
  final List<LegalSection> sections;

  const LegalDocument({
    required this.title,
    required this.lastUpdated,
    required this.intro,
    this.highlights = const [],
    required this.sections,
  });
}
