import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/pages/chapter_detail/chapter_detail_page.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/data/model/chapter.dart';
import 'package:academic/widgets/empty_state_widget.dart';
import 'package:academic/widgets/error_state_widget.dart';
import '../../gen/assets.gen.dart';
import 'logic/public_chapters_cubit.dart';

class PublicChaptersPage extends StatelessWidget {
  const PublicChaptersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PublicChaptersCubit, PublicChaptersState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (chapters) {
                if (chapters.isEmpty) {
                  return EmptyStateWidget(
                    title: 'سرفصلی وجود ندارد',
                    message: 'هنوز هیچ سرفصل عمومی‌ای ایجاد نشده است',
                    iconAsset: Assets.icFolder,
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.s20),
                  itemCount: chapters.length,
                  itemBuilder: (context, index) {
                    final chapter = chapters[index];
                    return PublicChapterCard(
                      chapter: chapter,
                      onTap: () {
                        ChapterDetailRoute(chapterId: chapter.id).push(context);
                      },
                    );
                  },
                );
              },
              error: (message) => ErrorStateWidget(
                error: message,
                onRetry: () => context.read<PublicChaptersCubit>().loadPublicChapters(),
              ),
            );
          },
        
    );
  }
}

class PublicChapterCard extends StatelessWidget {
  final Chapter chapter;
  final VoidCallback onTap;

  const PublicChapterCard({
    super.key,
    required this.chapter,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.s16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.corner20),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.corner20),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chapter.title,
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (chapter.description != null && chapter.description!.isNotEmpty) ...[
                          const SizedBox(height: AppSpacing.s8),
                          Text(
                            chapter.description!,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.s12),
              Row(
                children: [
                  // User info
                  if (chapter.userAvatar != null && chapter.userAvatar!.isNotEmpty)
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(chapter.userAvatar!),
                      onBackgroundImageError: (exception, stackTrace) {
                        // Silently handle 404 errors
                      },
                      child: const Icon(Icons.person, size: 16),
                    )
                  else
                    const CircleAvatar(
                      radius: 16,
                      child: Icon(Icons.person, size: 16),
                    ),
                  const SizedBox(width: AppSpacing.s8),
                  Text(
                    chapter.userName,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.note_outlined,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: AppSpacing.s4),
                  Text(
                    '${chapter.notesCount ?? 0} یادداشت',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
