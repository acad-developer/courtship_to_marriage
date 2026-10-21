import '../../../../../core/utils/currency.dart';
import '../../../auth/domain/repositories/auth_repository.dart';

class GetUserCurrencyUseCase {
  final AuthRepository _auth;
  GetUserCurrencyUseCase(this._auth);

  /// Computed on every call, so it is always right after switching accounts.
  Currency call() => Currency.fromPhone(_auth.currentUser?.phoneNumber);
}