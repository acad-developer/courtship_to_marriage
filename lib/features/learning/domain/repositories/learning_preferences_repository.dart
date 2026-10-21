abstract class LearningPreferencesRepository {
  Future<bool> getAutoPlayNext();
  Future<void> setAutoPlayNext(bool value);
}