import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/formatters.dart';
import '../../../../../core/widgets/app_network_image.dart';
import '../../../../../core/widgets/expandable_text.dart';
import '../../domain/entities/lesson_entity.dart';
import '../controllers/lesson_player_controller.dart';

class LessonPlayerView extends GetView<LessonPlayerController> {
  const LessonPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    // NOTE: do not set onEnterFullScreen / onExitFullScreen or any
    // SystemChrome orientation here. The package rotates to landscape for
    // full screen and back to portrait on its own.
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller.player,
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppColors.primary,
        progressColors: const ProgressBarColors(
          playedColor: AppColors.primary,
          handleColor: AppColors.primary,
        ),
        onEnded: (_) => controller.onVideoEnded(),
        topActions: [
          GestureDetector(
            onTap: controller.onBack,
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.arrow_back, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
      builder: (context, player) {
        final size = MediaQuery.of(context).size;
        final isLandscape = size.width > size.height;
        // Portrait: 16:9 box. Landscape (full screen): the whole screen.
        final videoHeight = isLandscape ? size.height : size.width * 9 / 16;

        return Scaffold(
          backgroundColor: isLandscape ? Colors.black : AppColors.background,
          body: SafeArea(
            top: !isLandscape,
            bottom: !isLandscape,
            left: !isLandscape,
            right: !isLandscape,
            child: Column(
              children: [
                // The player stays the first child in both orientations.
                SizedBox(
                  width: double.infinity,
                  height: videoHeight,
                  child: player,
                ),
                if (!isLandscape) ...[
                  Obx(() => controller.playbackFailed.value
                      ? _ErrorBanner(onRetry: controller.retry)
                      : const SizedBox.shrink()),
                  Expanded(
                    child: Obx(() {
                      final index = controller.currentIndex.value;
                      final lesson = controller.lessons[index];
                      final upNext = controller.upNext;

                      return SingleChildScrollView(
                        controller: controller.scrollController,
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${index + 1}. ${lesson.title}',
                                style: AppTextStyles.heading(26)),
                            if (lesson.description.isNotEmpty) ...[
                              const SizedBox(height: 14),
                              // The key resets "show more" for each lesson.
                              ExpandableText(
                                key: ValueKey(lesson.id),
                                text: lesson.description,
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.6,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                            const SizedBox(height: 28),
                            _PrevNextBar(
                              hasPrevious: controller.hasPrevious,
                              hasNext: controller.hasNext,
                              onPrevious: controller.previous,
                              onNext: controller.next,
                            ),
                            const SizedBox(height: 32),
                            if (upNext.isNotEmpty) ...[
                              Text('Up Next', style: AppTextStyles.heading(24)),
                              const SizedBox(height: 16),
                              for (var i = 0; i < upNext.length; i++)
                                _UpNextTile(
                                  number: index + 2 + i,
                                  lesson: upNext[i],
                                  onTap: () => controller.goTo(index + 1 + i),
                                ),
                            ] else
                              const _LastLessonNote(),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final VoidCallback onRetry;
  const _ErrorBanner({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFFF7ED),
      padding: const EdgeInsets.fromLTRB(24, 10, 12, 10),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded,
              size: 18, color: Color(0xFFD97706)),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              "This video couldn't be played. Check your connection.",
              style: TextStyle(fontSize: 13),
            ),
          ),
          TextButton(
            onPressed: onRetry,
            child: const Text('Retry',
                style: TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

class _PrevNextBar extends StatelessWidget {
  final bool hasPrevious;
  final bool hasNext;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _PrevNextBar({
    required this.hasPrevious,
    required this.hasNext,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    Color color(bool enabled) =>
        enabled ? AppColors.textPrimary : AppColors.hint;
    const label = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 1,
    );

    return Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.border),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: hasPrevious ? onPrevious : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Row(
                    children: [
                      Icon(Icons.chevron_left_rounded,
                          color: color(hasPrevious)),
                      Flexible(
                        child: Text('PREVIOUS LESSON',
                            overflow: TextOverflow.ellipsis,
                            style: label.copyWith(color: color(hasPrevious))),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const VerticalDivider(width: 1, color: AppColors.border),
            Expanded(
              child: InkWell(
                onTap: hasNext ? onNext : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text('NEXT LESSON',
                            overflow: TextOverflow.ellipsis,
                            style: label.copyWith(color: color(hasNext))),
                      ),
                      Icon(Icons.chevron_right_rounded, color: color(hasNext)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UpNextTile extends StatelessWidget {
  final int number;
  final LessonEntity lesson;
  final VoidCallback onTap;

  const _UpNextTile({
    required this.number,
    required this.lesson,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AppNetworkImage(lesson.displayThumbnail),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.play_arrow_rounded,
                            color: Colors.white, size: 22),
                      ),
                    ),
                    if (lesson.durationSeconds > 0)
                      Positioned(
                        right: 6,
                        bottom: 6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            Formatters.clock(lesson.durationSeconds),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$number. ${lesson.title}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.heading(16)),
                  const SizedBox(height: 6),
                  Text(
                    'LESSON $number',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LastLessonNote extends StatelessWidget {
  const _LastLessonNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Row(
        children: [
          Icon(Icons.emoji_events_outlined, color: AppColors.primary),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "You've reached the last lesson of this course.",
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}