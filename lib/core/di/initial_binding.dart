import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/datasources/user_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/data/repositories/user_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/repositories/user_repository.dart';
import '../../features/auth/domain/usecases/get_current_auth_user_usecase.dart';
import '../../features/auth/domain/usecases/get_user_profile_usecase.dart';
import '../../features/auth/domain/usecases/save_user_profile_usecase.dart';
import '../../features/auth/domain/usecases/send_otp_usecase.dart';
import '../../features/auth/domain/usecases/verify_otp_usecase.dart';
import '../../features/courses/data/repositories/courses_repository_impl.dart';
import '../../features/courses/domain/repositories/courses_repository.dart';
import '../../features/courses/domain/usecases/get_courses_usecase.dart';
import '../../features/learning/domain/usecases/learning_preferences_usecase.dart';
import '../../features/my_learning/data/repositories/my_learning_repository_impl.dart';
import '../../features/my_learning/domain/repositories/my_learning_repository.dart';
import '../../features/my_learning/domain/usecases/get_purchased_courses_usecase.dart';
import '../../features/auth/domain/usecases/sign_out_usecase.dart';
import '../../features/auth/domain/usecases/get_post_auth_destination_usecase.dart';
import '../../features/admin/data/datasources/admin_courses_remote_datasource.dart';
import '../../features/admin/data/repositories/admin_courses_repository_impl.dart';
import '../../features/admin/data/repositories/admin_storage_repository_impl.dart';
import '../../features/admin/domain/repositories/admin_courses_repository.dart';
import '../../features/admin/domain/repositories/admin_storage_repository.dart';
import '../../features/admin/domain/usecases/delete_course_usecase.dart';
import '../../features/admin/domain/usecases/save_course_usecase.dart';
import '../../features/admin/domain/usecases/set_course_status_usecase.dart';
import '../../features/admin/domain/usecases/watch_admin_courses_usecase.dart';
import '../../features/admin/data/datasources/admin_lessons_remote_datasource.dart';
import '../../features/admin/data/repositories/admin_lessons_repository_impl.dart';
import '../../features/admin/data/repositories/video_info_repository_impl.dart';
import '../../features/admin/domain/repositories/admin_lessons_repository.dart';
import '../../features/admin/domain/repositories/video_info_repository.dart';
import '../../features/admin/domain/usecases/delete_lesson_usecase.dart';
import '../../features/admin/domain/usecases/get_video_duration_usecase.dart';
import '../../features/admin/domain/usecases/reorder_lessons_usecase.dart';
import '../../features/admin/domain/usecases/save_lesson_usecase.dart';
import '../../features/admin/domain/usecases/watch_admin_lessons_usecase.dart';
import '../../features/courses/data/datasources/courses_remote_datasource.dart';
import '../../features/courses/domain/usecases/get_user_currency_usecase.dart';
import '../../features/learning/data/datasources/learning_remote_datasource.dart';
import '../../features/learning/data/repositories/learning_preferences_repository_impl.dart';
import '../../features/learning/data/repositories/lessons_repository_impl.dart';
import '../../features/learning/domain/repositories/learning_preferences_repository.dart';
import '../../features/learning/domain/repositories/lessons_repository.dart';
import '../../features/learning/domain/usecases/get_course_lessons_usecase.dart';
import '../../features/my_learning/data/datasources/my_learning_remote_datasource.dart';
import '../../features/my_learning/domain/usecases/get_purchased_course_ids_usecase.dart';
import '../../features/support/data/datasources/support_remote_datasource.dart';
import '../../features/support/data/repositories/support_repository_impl.dart';
import '../../features/support/domain/repositories/support_repository.dart';
import '../../features/support/domain/usecases/support_usecases.dart';
import '../../features/account/data/datasources/account_remote_datasource.dart';
import '../../features/account/data/repositories/account_repository_impl.dart';
import '../../features/account/domain/repositories/account_repository.dart';
import '../../features/account/domain/usecases/delete_account_usecase.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Data sources
    Get.lazyPut<AuthRemoteDataSource>(
            () => AuthRemoteDataSourceImpl(FirebaseAuth.instance),
        fenix: true);
    Get.lazyPut<UserRemoteDataSource>(
            () => UserRemoteDataSourceImpl(FirebaseFirestore.instance),
        fenix: true);
    Get.lazyPut<CoursesRemoteDataSource>(
            () => CoursesRemoteDataSourceImpl(FirebaseFirestore.instance),
        fenix: true);
    Get.lazyPut<AdminCoursesRemoteDataSource>(
            () => AdminCoursesRemoteDataSourceImpl(FirebaseFirestore.instance),
        fenix: true);
    Get.lazyPut<AdminLessonsRemoteDataSource>(
            () => AdminLessonsRemoteDataSourceImpl(FirebaseFirestore.instance),
        fenix: true);
    Get.lazyPut<MyLearningRemoteDataSource>(
            () => MyLearningRemoteDataSourceImpl(
            FirebaseFirestore.instance, FirebaseAuth.instance),
        fenix: true);
    Get.lazyPut<LearningRemoteDataSource>(
            () => LearningRemoteDataSourceImpl(FirebaseFirestore.instance),
        fenix: true);
    Get.lazyPut<SupportRemoteDataSource>(
            () => SupportRemoteDataSourceImpl(FirebaseFirestore.instance),
        fenix: true);
    Get.lazyPut<AccountRemoteDataSource>(
            () => AccountRemoteDataSourceImpl(
            FirebaseFirestore.instance, FirebaseAuth.instance),
        fenix: true);

    // Repositories
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()),
        fenix: true);
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl(Get.find()),
        fenix: true);
    Get.lazyPut<CoursesRepository>(() => CoursesRepositoryImpl(Get.find()),
        fenix: true);
    Get.lazyPut<MyLearningRepository>(
            () => MyLearningRepositoryImpl(Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut<AdminCoursesRepository>(
            () => AdminCoursesRepositoryImpl(Get.find()),
        fenix: true);
    Get.lazyPut<AdminStorageRepository>(
            () => AdminStorageRepositoryImpl(FirebaseStorage.instance),
        fenix: true);
    Get.lazyPut<AdminLessonsRepository>(
            () => AdminLessonsRepositoryImpl(Get.find()),
        fenix: true);
    Get.lazyPut<VideoInfoRepository>(() => VideoInfoRepositoryImpl(),
        fenix: true);
    Get.lazyPut<LessonsRepository>(() => LessonsRepositoryImpl(Get.find()),
        fenix: true);
    Get.lazyPut<LearningPreferencesRepository>(
            () => LearningPreferencesRepositoryImpl(),
        fenix: true);
    Get.lazyPut<SupportRepository>(() => SupportRepositoryImpl(Get.find()),
        fenix: true);
    Get.lazyPut<AccountRepository>(() => AccountRepositoryImpl(Get.find()),
        fenix: true);

    // Use cases
    Get.lazyPut(() => GetCurrentAuthUserUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => SendOtpUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => VerifyOtpUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetUserProfileUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => SaveUserProfileUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetCoursesUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetPurchasedCoursesUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => SignOutUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetPostAuthDestinationUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => WatchAdminCoursesUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => SaveCourseUseCase(Get.find(), Get.find()), fenix: true);
    Get.lazyPut(() => SetCourseStatusUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => DeleteCourseUseCase(Get.find(), Get.find()), fenix: true);
    Get.lazyPut(() => WatchAdminLessonsUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => SaveLessonUseCase(Get.find(), Get.find()), fenix: true);
    Get.lazyPut(() => DeleteLessonUseCase(Get.find(), Get.find()), fenix: true);
    Get.lazyPut(() => ReorderLessonsUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetVideoDurationUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetUserCurrencyUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetCourseLessonsUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetAutoPlayNextUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => SetAutoPlayNextUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetPurchasedCourseIdsUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => SubmitSupportQueryUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => WatchSupportQueriesUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => WatchPendingQueriesCountUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => ResolveSupportQueryUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => DeleteSupportQueryUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => DeleteAccountUseCase(Get.find()), fenix: true);
  }
}