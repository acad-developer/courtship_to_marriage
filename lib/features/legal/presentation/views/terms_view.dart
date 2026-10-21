import 'package:flutter/material.dart';
import '../../data/content/terms_content.dart';
import 'legal_document_view.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) =>
      LegalDocumentView(document: TermsContent.build());
}
