import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../courses/domain/entities/course_entity.dart';
import '../../domain/entities/lesson_entity.dart';
import '../../domain/usecases/learning_preferences_usecase.dart';
import 'lesson_player_args.dart';

class LessonPlayerController extends GetxController {
  final GetAutoPlayNextUseCase _getAutoPlay;
  LessonPlayerController(this._getAutoPlay);

  final LessonPlayerArgs args = Get.arguments as LessonPlayerArgs;

  CourseEntity get course => args.course;
  List<LessonEntity> get lessons => args.lessons;

  final currentIndex = 0.obs;
  final playbackFailed = false.obs;
  final scrollController = ScrollController();

  late final YoutubePlayerController player;
  bool _autoPlayNext = true;

  LessonEntity get current => lessons[currentIndex.value];
  bool get hasPrevious => currentIndex.value > 0;
  bool get hasNext => currentIndex.value < lessons.length - 1;
  List<LessonEntity> get upNext => lessons.sublist(currentIndex.value + 1);

  @override
  void onInit() {
    super.onInit();
    currentIndex.value = args.startIndex;

    final id = current.youtubeId;
    playbackFailed.value = id == null;

    player = YoutubePlayerController(
      initialVideoId: id ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        controlsVisibleAtStart: false,
        forceHD: true,
      ),
    )..addListener(_onPlayerChanged);

    _getAutoPlay().then((v) => _autoPlayNext = v);
  }

  void _onPlayerChanged() {
    if (player.value.hasError && !playbackFailed.value) {
      playbackFailed.value = true;
    }
  }

  /// Wired to YoutubePlayer.onEnded.
  void onVideoEnded() {
    if (_autoPlayNext && hasNext) goTo(currentIndex.value + 1);
  }

  void goTo(int index) {
    if (index < 0 || index >= lessons.length) return;

    currentIndex.value = index;
    args.onLessonChanged(index);

    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
    _playCurrent();
  }

  void previous() => goTo(currentIndex.value - 1);
  void next() => goTo(currentIndex.value + 1);
  void retry() => _playCurrent();

  void _playCurrent() {
    final id = current.youtubeId;
    if (id == null) {
      playbackFailed.value = true;
      return;
    }
    playbackFailed.value = false;
    player.load(id);
  }

  /// Back arrow on the player: leave full screen first, then the page.
  void onBack() {
    if (player.value.isFullScreen) {
      player.toggleFullScreenMode();
    } else {
      Get.back();
    }
  }

  @override
  void onClose() {
    player.removeListener(_onPlayerChanged);
    player.dispose();
    scrollController.dispose();
    super.onClose();
  }
}