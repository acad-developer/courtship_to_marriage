abstract class AccountRepository {
  /// Deletes all of the user's data, then the Firebase Auth account itself.
  /// The user must have signed in again moments before.
  Future<void> deleteAccount(String uid);
}