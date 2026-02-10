import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/data/model/chapter.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import 'package:academic/widgets/empty_state_widget.dart';
import 'package:academic/widgets/error_state_widget.dart';
import 'package:academic/pages/create_chapter/create_chapter_bottom_sheet.dart';
import '../../gen/assets.gen.dart';
import 'logic/my_chapters_cubit.dart';

class MyChaptersPage extends StatefulWidget {
  const MyChaptersPage({super.key});

  @override
  State<MyChaptersPage> createState() => _MyChaptersPageState();
}

class _MyChaptersPageState extends State<MyChaptersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'فیش‌های من',
        icon: Icons.folder_rounded,
      ),
      body: BlocBuilder<MyChaptersCubit, MyChaptersState>(
        builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (chapters) {
                if (chapters.isEmpty) {
                  return EmptyStateWidget(
                    title: 'سرفصلی وجود ندارد',
                    message: 'هنوز هیچ سرفصلی ایجاد نکرده‌اید',
                    iconAsset: Assets.icFolder,
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<MyChaptersCubit>().loadChapters();
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.s20),
                    itemCount: chapters.length,
                    itemBuilder: (context, index) {
                    final chapter = chapters[index];
                    return ChapterCard(
                      chapter: chapter,
                      onTap: () {
                        // Navigate to chapter detail page
                        ChapterDetailRoute(chapterId: chapter.id).push(context);
                      },
                      onEdit: () {
                        // Capture the context that has access to MyChaptersCubit
                        final cubitContext = context;
                        showCreateChapterBottomSheet(
                          context: context,
                          chapter: chapter,
                          onSave: (title, description, image, categoryId) {
                            cubitContext.read<MyChaptersCubit>().updateChapter(
                                  chapterId: chapter.id,
                                  description: description,
                                );
                          },
                        );
                      },
                      onDelete: () {
                        // Capture the context that has access to MyChaptersCubit
                        final cubitContext = context;
                        showDialog(
                          context: context,
                          builder: (dialogContext) => AlertDialog(
                            title: const Text('حذف سرفصل'),
                            content: Text('آیا از حذف "${chapter.title}" اطمینان دارید؟'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(dialogContext),
                                child: const Text('انصراف'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(dialogContext);
                                  cubitContext.read<MyChaptersCubit>().deleteChapter(chapter.id);
                                },
                                child: const Text('حذف', style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  ),
                );
              },
              error: (message) => ErrorStateWidget(
                error: message,
                onRetry: () => context.read<MyChaptersCubit>().loadChapters(),
              ),
            );
          },
        ),
      floatingActionButton: BlocBuilder<MyChaptersCubit, MyChaptersState>(
        builder: (cubitContext, state) {
          return FloatingActionButton(
            onPressed: () {
              showCreateChapterBottomSheet(
                context: cubitContext,
                onSave: (title, description, image, categoryId) {
                  cubitContext.read<MyChaptersCubit>().createChapter(
                        title: title,
                        description: description,
                        image: image,
                        categoryId: categoryId,
                      );
                },
              );
            },
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}

class ChapterCard extends StatelessWidget {
  final Chapter chapter;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ChapterCard({
    super.key,
    required this.chapter,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
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
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: const Row(
                          children: [
                            Icon(Icons.edit, size: 20),
                            SizedBox(width: AppSpacing.s8),
                            Text('ویرایش'),
                          ],
                        ),
                        onTap: () => Future.delayed(
                          const Duration(milliseconds: 100),
                          onEdit,
                        ),
                      ),
                      PopupMenuItem(
                        child: const Row(
                          children: [
                            Icon(Icons.delete, size: 20, color: Colors.red),
                            SizedBox(width: AppSpacing.s8),
                            Text('حذف', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        onTap: () => Future.delayed(
                          const Duration(milliseconds: 100),
                          onDelete,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.s12),
              Row(
                children: [
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
                  const Spacer(),
                  if (chapter.updatedAt != null)
                    Text(
                      _formatDate(chapter.updatedAt!),
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

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        return 'امروز';
      } else if (difference.inDays == 1) {
        return 'دیروز';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} روز پیش';
      } else {
        return '${date.year}/${date.month}/${date.day}';
      }
    } catch (e) {
      return dateString;
    }
  }
}
