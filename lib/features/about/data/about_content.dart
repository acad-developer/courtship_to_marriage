import '../../../core/constants/app_constants.dart';

/// All the wording of the About Us screen. Edit it here.
class AboutContent {
  AboutContent._();

  static const mission =
      'We help young people prepare for marriage with clarity, '
      'confidence and good character. ${AppConstants.appName} brings '
      'guidance on courtship, expectations, communication and family '
      'life into short, practical video courses you can learn from '
      'at your own pace.';

  static const offers = <AboutItem>[
    AboutItem(
      icon: AboutIcon.play,
      title: 'Guided video courses',
      text: 'Step-by-step lessons made for those preparing for marriage.',
    ),
    AboutItem(
      icon: AboutIcon.schedule,
      title: 'Learn at your pace',
      text: 'Watch any lesson, any time, as often as you like.',
    ),
    AboutItem(
      icon: AboutIcon.heart,
      title: 'Practical and respectful',
      text: 'Honest, balanced advice you can apply to real life.',
    ),
    AboutItem(
      icon: AboutIcon.support,
      title: 'Support when you need it',
      text: 'Our team is a message away through Help & Support.',
    ),
  ];

  static const steps = <AboutItem>[
    AboutItem(
      icon: AboutIcon.phone,
      title: 'Sign in with your phone',
      text: 'Create your account in seconds with a one-time password.',
    ),
    AboutItem(
      icon: AboutIcon.search,
      title: 'Choose a course',
      text: 'Browse the courses and read what you will learn.',
    ),
    AboutItem(
      icon: AboutIcon.play,
      title: 'Start learning',
      text: 'Your purchased courses appear in My Learning.',
    ),
  ];

  static const values = <String>[
    'Honesty and clear guidance',
    'Respect for every person and family',
    'Privacy and trust',
    'Learning that leads to action',
  ];
}

enum AboutIcon { play, schedule, heart, support, phone, search }

class AboutItem {
  final AboutIcon icon;
  final String title;
  final String text;
  const AboutItem({required this.icon, required this.title, required this.text});
}
