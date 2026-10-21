import 'package:url_launcher/url_launcher.dart';

class UrlOpener {
  UrlOpener._();

  static Future<bool> _launch(Uri uri) async {
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }

  static Future<bool> openUrl(String url) async {
    final uri = Uri.tryParse(url);
    return uri == null ? false : _launch(uri);
  }

  static Future<bool> email(String address, {String? subject, String? body}) {
    final params = <String>[
      if (subject != null) 'subject=${Uri.encodeComponent(subject)}',
      if (body != null) 'body=${Uri.encodeComponent(body)}',
    ];
    final query = params.isEmpty ? '' : '?${params.join('&')}';
    return _launch(Uri.parse('mailto:$address$query'));
  }

  static Future<bool> call(String phone) {
    final dialable = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    return _launch(Uri.parse('tel:$dialable'));
  }

  static Future<bool> whatsapp(String phone, {String? message}) {
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    final text = message == null ? '' : '?text=${Uri.encodeComponent(message)}';
    return _launch(Uri.parse('https://wa.me/$digits$text'));
  }
}