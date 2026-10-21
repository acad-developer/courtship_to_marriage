import '../../../core/routes/app_routes.dart';
import '../domain/usecases/get_post_auth_destination_usecase.dart';

extension PostAuthDestinationRoute on PostAuthDestination {
  String get route {
    switch (this) {
      case PostAuthDestination.profileSetup:
        return AppRoutes.profile;
      case PostAuthDestination.admin:
        return AppRoutes.adminHome;
      case PostAuthDestination.home:
        return AppRoutes.home;
    }
  }
}