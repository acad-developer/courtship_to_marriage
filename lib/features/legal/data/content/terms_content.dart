// GENERATED from one source together with hosting/terms-and-conditions.html.
// You can edit the wording directly in this file; keep the HTML page in sync.
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/contact_constants.dart';
import '../../../../core/constants/legal_constants.dart';
import '../../domain/entities/legal_document.dart';

class TermsContent {
  TermsContent._();

  static LegalDocument build() {
    return LegalDocument(
      title: 'Terms & Conditions',
      lastUpdated: LegalConstants.termsUpdated,
      intro: 'These Terms & Conditions govern your use of the ${AppConstants.appName} mobile app and its courses. By creating an account or using the app you agree to them, so please read them carefully.',
      highlights: [
        LegalHighlight(
          icon: LegalIcon.description,
          title: 'Personal licence',
          text: 'Buying a course gives you a personal, non-transferable right to watch it inside the app.',
        ),
        LegalHighlight(
          icon: LegalIcon.payments,
          title: 'Fair payments',
          text: 'Prices are shown before you pay. Refunds follow the policy in these terms.',
        ),
        LegalHighlight(
          icon: LegalIcon.shield,
          title: 'Respect and safety',
          text: 'Do not share your account, record or redistribute the course videos.',
        ),
        LegalHighlight(
          icon: LegalIcon.gavel,
          title: 'Governing law',
          text: 'These terms are governed by the laws of India.',
        ),
      ],
      sections: [
        LegalSection(
          title: 'Acceptance of These Terms',
          paragraphs: [
            'By downloading, registering for or using ${AppConstants.appName} (the "App"), you agree to be bound by these Terms & Conditions and by our Privacy Policy. If you do not agree, please do not use the App.',
            '${LegalConstants.companyName} ("we", "us", "our") may update these terms from time to time. Continued use of the App after an update means you accept the revised terms.',
          ],
        ),
        LegalSection(
          title: 'About the App',
          paragraphs: [
            '${AppConstants.appName} provides educational video courses that help people prepare for a healthy courtship and a strong marriage. The content is for general education and personal growth.',
          ],
          closing: [
            'The courses are not a substitute for professional counselling, legal, medical, financial or religious advice. Please consult a qualified professional for your personal situation.',
          ],
        ),
        LegalSection(
          title: 'Eligibility',
          paragraphs: [
            'You must be at least 18 years old and legally able to enter into a binding contract to use the App. By registering you confirm that you meet these requirements.',
          ],
        ),
        LegalSection(
          title: 'Your Account',
          paragraphs: [
            'You sign in with your mobile phone number and a one-time password (OTP). You agree to:',
          ],
          bullets: [
            'provide accurate and current information in your profile;',
            'keep your phone and OTPs private and not share your account with anyone;',
            'tell us immediately if you think your account has been used without your permission.',
          ],
          closing: [
            'You are responsible for all activity that happens under your account.',
          ],
        ),
        LegalSection(
          title: 'Courses and Licence',
          paragraphs: [
            'When you purchase a course, we grant you a limited, personal, non-exclusive, non-transferable and revocable licence to watch that course inside the App for your own private learning.',
            'Course access is linked to your account. Course content is streamed and is not available for download or offline use unless we clearly say so.',
          ],
        ),
        LegalSection(
          title: 'Prices and Payments',
          paragraphs: [
            'Prices are shown in Indian Rupees (INR) for users with an Indian (+91) phone number and in US Dollars (USD) for other users. The price shown before you buy is the price you pay.',
            'Payments are processed by third-party payment providers. We do not store your card or bank details. Taxes, where applicable, are included or shown at checkout.',
            'Once payment is confirmed, the course is added to your account. If your payment succeeded but the course does not appear, contact us and we will fix it.',
          ],
        ),
        LegalSection(
          title: 'Refunds and Cancellations',
          paragraphs: [
            'Because course videos are digital content that you can start watching immediately, purchases are generally non-refundable once access is granted.',
            'We will, however, review refund requests in these cases:',
          ],
          bullets: [
            'you were charged more than once for the same course;',
            'you paid but could not get access to the course and we were unable to resolve it;',
            'the course is materially different from how it was described.',
          ],
          closing: [
            'To request a refund, contact us at ${AppContact.supportEmail} within 7 days of the purchase with your registered phone number and payment details. Approved refunds are returned to the original payment method.',
          ],
        ),
        LegalSection(
          title: 'Acceptable Use',
          paragraphs: [
            'You agree not to:',
          ],
          bullets: [
            'copy, record, screen-capture, download, share, resell or publicly show any course or part of it;',
            'share your account or course access with other people;',
            'try to bypass security, hack, reverse engineer or interfere with the App or our servers;',
            'use the App for anything unlawful, abusive, harassing or misleading;',
            'send us false, offensive or spam messages through Help & Support.',
          ],
        ),
        LegalSection(
          title: 'Intellectual Property',
          paragraphs: [
            'All courses, videos, text, images, logos and other content in the App belong to ${LegalConstants.companyName} or its licensors and are protected by copyright and other laws. These terms do not give you any ownership of that content.',
          ],
        ),
        LegalSection(
          title: 'Third-Party Services',
          paragraphs: [
            'The App uses third-party services such as Firebase (sign-in, database and storage), YouTube (video playback) and payment providers. Your use of those services is also subject to their own terms and policies.',
          ],
        ),
        LegalSection(
          title: 'Suspension and Termination',
          paragraphs: [
            'We may suspend or end your access, with or without notice, if you break these terms, misuse the App or if we are required to by law. You can stop using the App at any time and may ask us to delete your account.',
            'If we terminate your account for a serious breach, you will not be entitled to a refund.',
          ],
        ),
        LegalSection(
          title: 'Disclaimer',
          paragraphs: [
            'The App and the courses are provided "as is" and "as available". We work hard to keep the App reliable, but we do not promise that it will always be uninterrupted or error free, or that following the courses will lead to a particular result in your relationship or marriage.',
          ],
        ),
        LegalSection(
          title: 'Limitation of Liability',
          paragraphs: [
            'To the fullest extent permitted by law, ${LegalConstants.companyName} will not be liable for any indirect, incidental or consequential loss arising from your use of the App. Our total liability for any claim relating to a course is limited to the amount you paid for that course.',
            'Nothing in these terms limits any right you have under applicable consumer protection law that cannot be excluded.',
          ],
        ),
        LegalSection(
          title: 'Privacy',
          paragraphs: [
            'Your use of the App is also governed by our Privacy Policy, which explains how we collect and use your personal information. You can read it in the App under Profile, then Privacy Policy.',
          ],
        ),
        LegalSection(
          title: 'Governing Law and Disputes',
          paragraphs: [
            'These terms are governed by the laws of India. We encourage you to contact us first so that we can try to resolve any concern informally. If that does not work, the courts in India will have jurisdiction, subject to any mandatory rights you have under the law of your place of residence.',
          ],
        ),
        LegalSection(
          title: 'Changes to These Terms',
          paragraphs: [
            'We may change these terms when our services, the law or our practices change. When we do, we will update the "Last updated" date above and, for important changes, tell you in the App.',
          ],
        ),
        LegalSection(
          title: 'Contact Us',
          paragraphs: [
            'If you have any questions about these terms, please contact us:',
          ],
          bullets: [
            'Email: ${AppContact.supportEmail}',
            'Phone and WhatsApp: ${AppContact.supportPhone}',
            'In the App: Profile, then Help & Support.',
          ],
        ),
      ],
    );
  }
}
