import 'package:appwrite/appwrite.dart';
import 'package:courtship_to_marriage/main.dart';

class AppWrite {
  static const String endpoint = "https://cloud.appwrite.io/v1";
  static const String projectID = "652d16db69cab7ed16d5";
  static const String userDatabaseID = "652d6c685c3cb93b433a";

  static const String recommendationCollectionID = "652d6c7818cc67842494";
  static const String successStoryCollectionID = "652d956628971b3c4d19";
  static const String loginCollectionID = "652eb637e0c843b5126f";

  static final databases = Databases(client);
}