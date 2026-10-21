import 'package:flutter/material.dart';
import '../../data/content/privacy_policy_content.dart';
import 'legal_document_view.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) =>
      LegalDocumentView(document: PrivacyPolicyContent.build());
}
