import 'package:flutter/material.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/data/repo/chapters_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:academic/pages/create_chapter/create_chapter_bottom_sheet.dart';

Future<void> showAddNoteDialog({
  required BuildContext context,
  required String excerpt,
  required int bookId,
  required String bookName,
  required String bookImage,
  String? authorName,
  String? authorAvatar,
  required Function(List<int> chapterIds, String? userNote) onSave,
}) async {
  final chaptersRepository = GetIt.I<ChaptersRepository>();
  final chapters = await chaptersRepository.getMyChapters();
  final selectedChapters = <int>{};
  final noteController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  if (chapters.isEmpty) {
    // Show dialog with option to create a new chapter
    if (context.mounted) {
      final shouldCreate = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('سرفصلی وجود ندارد'),
          content: const Text('برای افزودن یادداشت، ابتدا باید یک سرفصل ایجاد کنید.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('انصراف'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('ایجاد سرفصل جدید'),
            ),
          ],
        ),
      );
      
      if (shouldCreate == true && context.mounted) {
        // Show create chapter bottom sheet
        await showCreateChapterBottomSheet(
          context: context,
          onSave: (title, description, image, categoryId) async {
            // Create chapter directly via repository
            await chaptersRepository.createChapter(
              title: title,
              description: description,
              image: image,
              categoryId: categoryId,
            );
            
            // Reload chapters and show the dialog again
            if (context.mounted) {
              await chaptersRepository.getMyChapters();
              if (context.mounted) {
                // Recursively call showAddNoteDialog with updated chapters
                await showAddNoteDialog(
                  context: context,
                  excerpt: excerpt,
                  bookId: bookId,
                  bookName: bookName,
                  bookImage: bookImage,
                  authorName: authorName,
                  authorAvatar: authorAvatar,
                  onSave: onSave,
                );
              }
            }
          },
        );
      }
    }
    return;
  }

  if (context.mounted) {
    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('افزودن به فیش‌نویسی'),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Excerpt preview
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.s12),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(AppRadius.corner12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'بریده انتخاب شده:',
                            style: context.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.s8),
                          Text(
                            excerpt,
                            style: context.textTheme.bodyMedium,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s20),
                    // Chapters list
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'انتخاب سرفصل:',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () async {
                            // Close current dialog
                            Navigator.pop(context);
                            
                            // Show create chapter bottom sheet
                            await showCreateChapterBottomSheet(
                              context: context,
                              onSave: (title, description, image, categoryId) async {
                                // Create chapter directly via repository
                                await chaptersRepository.createChapter(
                                  title: title,
                                  description: description,
                                  image: image,
                                  categoryId: categoryId,
                                );
                                
                                // Reload chapters and show the dialog again
                                if (context.mounted) {
                                  await chaptersRepository.getMyChapters();
                                  if (context.mounted) {
                                    // Recursively call showAddNoteDialog with updated chapters
                                    await showAddNoteDialog(
                                      context: context,
                                      excerpt: excerpt,
                                      bookId: bookId,
                                      bookName: bookName,
                                      bookImage: bookImage,
                                      authorName: authorName,
                                      authorAvatar: authorAvatar,
                                      onSave: onSave,
                                    );
                                  }
                                }
                              },
                            );
                          },
                          icon: const Icon(Icons.add_circle_outline, size: 20),
                          label: const Text('ایجاد سرفصل جدید'),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.s12),
                    ...chapters.map((chapter) => CheckboxListTile(
                          title: Text(chapter.title),
                          subtitle: chapter.description != null &&
                                  chapter.description!.isNotEmpty
                              ? Text(
                                  chapter.description!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme.bodySmall,
                                )
                              : null,
                          value: selectedChapters.contains(chapter.id),
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                selectedChapters.add(chapter.id);
                              } else {
                                selectedChapters.remove(chapter.id);
                              }
                            });
                          },
                          contentPadding: EdgeInsets.zero,
                        )),
                    const SizedBox(height: AppSpacing.s20),
                    // User note field
                    TextFormField(
                      controller: noteController,
                      decoration: const InputDecoration(
                        labelText: 'یادداشت شما (اختیاری)',
                        hintText: 'یادداشت یا توضیحی درباره این بریده...',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('انصراف'),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedChapters.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('لطفاً حداقل یک سرفصل انتخاب کنید'),
                    ),
                  );
                  return;
                }
                Navigator.pop(context);
                onSave(
                  selectedChapters.toList(),
                  noteController.text.trim().isEmpty
                      ? null
                      : noteController.text.trim(),
                );
              },
              child: const Text('ذخیره'),
            ),
          ],
        ),
      ),
    );
  }
}
