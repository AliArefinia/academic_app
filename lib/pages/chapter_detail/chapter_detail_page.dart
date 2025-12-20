import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/helper/image_ur_handler.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/data/model/note.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import 'package:academic/widgets/empty_state_widget.dart';
import 'package:academic/widgets/error_state_widget.dart';
import 'package:readmore/readmore.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';
import '../../gen/assets.gen.dart';
import 'logic/chapter_detail_cubit.dart';

class ChapterDetailPage extends StatelessWidget {
  final int chapterId;

  const ChapterDetailPage({
    super.key,
    required this.chapterId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'جزئیات سرفصل',
          icon: Icons.folder_rounded,
        ),
        body: BlocBuilder<ChapterDetailCubit, ChapterDetailState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (chapter, notes) {
                return CustomScrollView(
                  slivers: [
                    // Chapter header
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.s20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chapter.title,
                              style: context.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (chapter.description != null &&
                                chapter.description!.isNotEmpty) ...[
                              const SizedBox(height: AppSpacing.s12),
                              Text(
                                chapter.description!,
                                style: context.textTheme.bodyLarge,
                              ),
                            ],
                            const SizedBox(height: AppSpacing.s16),
                            Text(
                              '${notes.length} یادداشت',
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Notes list
                    if (notes.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: EmptyStateWidget(
                          title: 'یادداشتی وجود ندارد',
                          message: 'هنوز هیچ یادداشتی در این سرفصل ثبت نشده است',
                          iconAsset: Assets.icSave,
                        ),
                      )
                    else
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final note = notes[index];
                            return NoteCard(
                              note: note,
                              chapterId: chapterId,
                            );
                          },
                          childCount: notes.length,
                        ),
                      ),
                  ],
                );
              },
              error: (message) => ErrorStateWidget(
                error: message,
                onRetry: () =>
                    context.read<ChapterDetailCubit>().loadChapterDetail(chapterId),
              ),
            );
          },
        ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final Note note;
  final int chapterId;

  const NoteCard({
    super.key,
    required this.note,
    required this.chapterId,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = buildImageUrl(note.bookImage);
    
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s16,
        vertical: AppSpacing.s8,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.s16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Book info with iOS-like design
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Book cover with shadow
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: imageUrl != null && imageUrl.isNotEmpty
                              ? UniversalImageLoader(
                                  path: imageUrl,
                                  option: UniversalImageLoaderOption(
                                    width: 70,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  width: 70,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.surfaceVariant,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 32,
                                    color: context.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.s12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              note.bookName,
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (note.authorName != null) ...[
                              const SizedBox(height: AppSpacing.s4),
                              Text(
                                note.authorName!,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.colorScheme.onSurfaceVariant,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s16),
                  // Divider with iOS style
                  Divider(
                    height: 1,
                    thickness: 0.5,
                    color: context.colorScheme.outline.withOpacity(0.2),
                  ),
                  const SizedBox(height: AppSpacing.s16),
                  // Excerpt with better typography
                  ReadMoreText(
                    note.excerptText,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 15,
                      height: 1.5,
                      letterSpacing: 0.2,
                    ),
                    trimMode: TrimMode.Line,
                    trimLines: 4,
                    trimCollapsedText: 'بیشتر بخوانید',
                    trimExpandedText: 'کمتر',
                    moreStyle: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.primary,
                      fontSize: 15,
                    ),
                    lessStyle: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.primary,
                      fontSize: 15,
                    ),
                  ),
                  // Analytical note with iOS-like card
                  if (note.userNote != null && note.userNote!.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.s16),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.s12),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primaryContainer.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: context.colorScheme.primary.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.auto_awesome_outlined,
                                size: 18,
                                color: context.colorScheme.primary,
                              ),
                              const SizedBox(width: AppSpacing.s6),
                              Text(
                                'تحلیل',
                                style: context.textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: context.colorScheme.primary,
                                  fontSize: 13,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.s8),
                          Text(
                            note.userNote!,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontSize: 14,
                              height: 1.5,
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  // Action buttons
                  const SizedBox(height: AppSpacing.s16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () => _showEditNoteDialog(context, note),
                        icon: const Icon(Icons.edit_outlined, size: 18),
                        label: const Text('ویرایش'),
                        style: TextButton.styleFrom(
                          foregroundColor: context.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.s8),
                      TextButton.icon(
                        onPressed: () => _showDeleteNoteDialog(context, note),
                        icon: const Icon(Icons.delete_outline, size: 18),
                        label: const Text('حذف'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showEditNoteDialog(BuildContext context, Note note) {
    final controller = TextEditingController(text: note.userNote ?? '');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ویرایش یادداشت'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'یادداشت شما',
            hintText: 'یادداشت یا توضیحی درباره این بریده...',
            border: OutlineInputBorder(),
          ),
          maxLines: 4,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('انصراف'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ChapterDetailCubit>().updateNote(
                    noteId: note.id,
                    userNote: controller.text.trim(),
                    chapterId: chapterId,
                  );
            },
            child: const Text('ذخیره'),
          ),
        ],
      ),
    );
  }

  void _showDeleteNoteDialog(BuildContext context, Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف یادداشت'),
        content: const Text('آیا از حذف این یادداشت اطمینان دارید؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('انصراف'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ChapterDetailCubit>().deleteNote(
                    noteId: note.id,
                    chapterId: chapterId,
                  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }
}
