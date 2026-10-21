import '../repositories/user_repository.dart';

enum PostAuthDestination { profileSetup, home, admin }

class GetPostAuthDestinationUseCase {
  final UserRepository _repository;
  GetPostAuthDestinationUseCase(this._repository);

  Future<PostAuthDestination> call(String uid) async {
    final user = await _repository.getUser(uid);
    if (user == null) return PostAuthDestination.profileSetup;
    if (user.isAdmin) return PostAuthDestination.admin;
    return PostAuthDestination.home;
  }
}