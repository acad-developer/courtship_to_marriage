import 'package:firebase_core/firebase_core.dart';
import 'app_exception.dart';

AppException mapFirebaseException(FirebaseException e) {
  switch (e.code) {
    case 'permission-denied':
    case 'unauthorized':
      return const AppException(
          'Permission denied. Check your admin role and the security rules.');
    case 'unavailable':
    case 'network-request-failed':
    case 'retry-limit-exceeded':
      return const AppException(
          'Unable to reach the server. Please check your connection.');
    case 'canceled':
      return const AppException('The operation was cancelled.');
    case 'quota-exceeded':
      return const AppException('Storage quota exceeded.');
    default:
      return AppException(
          e.message ?? 'Something went wrong. Please try again.');
  }
}