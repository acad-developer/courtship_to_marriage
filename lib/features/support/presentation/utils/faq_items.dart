class FaqItem {
  final String question;
  final String answer;
  const FaqItem(this.question, this.answer);
}

const faqItems = <FaqItem>[
  FaqItem(
    'How do I watch a course I have purchased?',
    'Open the My Learning tab, tap "Open Course" on your course, then tap any '
        'lesson to start watching. Videos play inside the app.',
  ),
  FaqItem(
    "I bought a course but I can't see it in My Learning.",
    'Pull down on the My Learning screen to refresh. If the course still does '
        'not appear after a minute, send us a message below with the course '
        'name and the phone number you registered with, and we will check it '
        'for you.',
  ),
  FaqItem(
    'A video is not playing or shows an error.',
    'Check that your internet connection is working, then tap Retry. If the '
        'problem continues, close and reopen the app. Still stuck? Message us '
        'with the course name and lesson name.',
  ),
  FaqItem(
    'Can I watch lessons without internet?',
    'No. Lessons are streamed, so you need an internet connection to watch '
        'them.',
  ),
  FaqItem(
    'Can I change the playback speed or watch in full screen?',
    'Yes. Use the speed icon on the video player to change the speed, and the '
        'full-screen icon to watch in landscape.',
  ),
  FaqItem(
    'Why are prices shown in ₹ or \$?',
    'Prices are shown in Indian rupees (₹) for phone numbers with the +91 '
        'country code, and in US dollars (\$) for all other countries.',
  ),
  FaqItem(
    'How can I update my name or email?',
    'Go to Profile → Edit Profile, change your details and tap Save Changes. '
        'Your phone number is verified and cannot be changed there. To change '
        'it, please contact us.',
  ),
  FaqItem(
    'Can I share my course or account with others?',
    'Courses are for your personal use only. Please do not share your account '
        'or lesson videos with others.',
  ),
  FaqItem(
    'How do I delete my account?',
    'Send us a message using the form below with the subject "Delete my '
        'account", from the phone number you registered with. We will remove '
        'your account and data.',
  ),
  FaqItem(
    'How can I request a refund?',
    'Send us a message with your registered phone number and the course name, '
        'and our team will review your request.',
  ),
  FaqItem(
    'Which languages are the courses available in?',
    'Courses are available in English, Hindi and other languages. The '
        'language is shown on each course card.',
  ),
];