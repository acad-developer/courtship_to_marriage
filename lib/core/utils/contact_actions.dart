import '../constants/contact_constants.dart';
import 'app_snackbar.dart';
import 'url_opener.dart';

class ContactActions {
  ContactActions._();

  static Future<void> _run(Future<bool> action, String failMessage) async {
    if (!await action) AppSnackbar.error(failMessage);
  }

  // ---- the app's own support contacts ----
  static Future<void> emailSupport() => email(
    AppContact.supportEmail,
    subject: AppContact.emailSubject,
  );

  static Future<void> callSupport() => call(AppContact.supportPhone);

  static Future<void> whatsappSupport() =>
      whatsapp(AppContact.whatsappPhone, message: AppContact.whatsappMessage);

  // ---- generic (also used by the admin to reply to users) ----
  static Future<void> email(String address, {String? subject}) => _run(
    UrlOpener.email(address, subject: subject),
    "Couldn't open your email app.",
  );

  static Future<void> call(String phone) =>
      _run(UrlOpener.call(phone), "Couldn't open the phone dialer.");

  static Future<void> whatsapp(String phone, {String? message}) => _run(
    UrlOpener.whatsapp(phone, message: message),
    "Couldn't open WhatsApp.",
  );
}