import 'package:courtship_to_marriage/model/recommendation_model/recommendation_model.dart';
import 'package:courtship_to_marriage/model/success_story_model/success_story_model.dart';
import 'package:courtship_to_marriage/utils/appwrite.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  Future<List<Recommendation>> getRecommendationData() async{
    try{
      final documentList = await AppWrite.databases.listDocuments(
            // databaseId: '652d6c685c3cb93b433a',
            // collectionId: '652d6c7818cc67842494',
            databaseId: AppWrite.userDatabaseID,
            collectionId: AppWrite.recommendationCollectionID,
        );
        return documentList.documents.map((d) => Recommendation.fromMap(d.data)).toList();
    } catch (e){
      throw Exception(e);
    }
  }

  Future<List<SuccessStory>> getSuccessStoryData() async{
        try {
          final documentList = await AppWrite.databases.listDocuments(
            // databaseId: '652d6c685c3cb93b433a',
            // collectionId: '652d956628971b3c4d19',
            databaseId: AppWrite.userDatabaseID,
            collectionId: AppWrite.successStoryCollectionID,
          );
          return documentList.documents.map((d) => SuccessStory.fromMap(d.data)).toList();
        } catch (e){
          throw Exception(e);
        }
  }
}