import '../repositories/video_info_repository.dart';

class GetVideoDurationUseCase {
  final VideoInfoRepository _repository;
  GetVideoDurationUseCase(this._repository);

  Future<int?> call(String url) => _repository.getDurationSeconds(url);
}