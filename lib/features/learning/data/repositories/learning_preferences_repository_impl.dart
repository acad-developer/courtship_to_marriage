import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/learning_preferences_repository.dart';

class LearningPreferencesRepositoryImpl
    implements LearningPreferencesRepository {
  static const _autoPlayKey = 'auto_play_next';

  @override
  Future<bool> getAutoPlayNext() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_autoPlayKey) ?? true;
  }

  @override
  Future<void> setAutoPlayNext(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_autoPlayKey, value);
  }
}