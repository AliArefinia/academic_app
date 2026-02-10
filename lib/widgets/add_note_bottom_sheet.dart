import 'package:flutter/material.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/data/repo/chapters_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:academic/pages/create_chapter/create_chapter_bottom_sheet.dart';
import 'package:academic/data/model/chapter.dart';

Future<void> showAddNoteBottomSheet({
  required BuildContext context,
  required String excerpt,
  required int bookId,
  required String bookName,
  required String bookImage,
  String? authorName,
  String? authorAvatar,
  required Function(List<int> chapterIds, String? userNote) onSave,
}) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    enableDrag: true,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) => _AddNoteBottomSheetContent(
        excerpt: excerpt,
        bookId: bookId,
        bookName: bookName,
        bookImage: bookImage,
        authorName: authorName,
        authorAvatar: authorAvatar,
        onSave: onSave,
        scrollController: scrollController,
      ),
    ),
  );
}

class _AddNoteBottomSheetContent extends StatefulWidget {
  final String excerpt;
  final int bookId;
  final String bookName;
  final String bookImage;
  final String? authorName;
  final String? authorAvatar;
  final Function(List<int> chapterIds, String? userNote) onSave;
  final ScrollController scrollController;

  const _AddNoteBottomSheetContent({
    required this.excerpt,
    required this.bookId,
    required this.bookName,
    required this.bookImage,
    this.authorName,
    this.authorAvatar,
    required this.onSave,
    required this.scrollController,
  });

  @override
  State<_AddNoteBottomSheetContent> createState() => _AddNoteBottomSheetContentState();
}

class _AddNoteBottomSheetContentState extends State<_AddNoteBottomSheetContent> {
  final noteController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  final Set<int> _selectedChapters = {};

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  Future<void> _selectChapters() async {
    final result = await showChapterSelectionBottomSheet(
      context: context,
      initiallySelected: _selectedChapters.toList(),
    );
    
    if (result != null && mounted) {
      setState(() {
        _selectedChapters.clear();
        _selectedChapters.addAll(result);
      });
    }
  }

  void _handleSave() {
    if (_selectedChapters.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('لطفاً حداقل یک سرفصل انتخاب کنید'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    Navigator.pop(context);
    widget.onSave(
      _selectedChapters.toList(),
      noteController.text.trim().isEmpty ? null : noteController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: context.colorScheme.onSurfaceVariant.withOpacity(0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s20,
              vertical: AppSpacing.s16,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.note_add_rounded,
                  color: context.colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(width: AppSpacing.s12),
                Expanded(
                  child: Text(
                    'افزودن به فیش‌نویسی',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                  tooltip: 'بستن',
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Content
          Expanded(
            child: SingleChildScrollView(
                        controller: widget.scrollController,
                        padding: const EdgeInsets.all(AppSpacing.s20),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Excerpt preview - simplified
                              Container(
                                padding: const EdgeInsets.all(AppSpacing.s16),
                                decoration: BoxDecoration(
                                  color: context.colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(AppRadius.corner12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.format_quote_rounded,
                                          size: 20,
                                          color: context.colorScheme.primary,
                                        ),
                                        const SizedBox(width: AppSpacing.s8),
                                        Text(
                                          'بریده انتخاب شده',
                                          style: context.textTheme.labelMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: context.colorScheme.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: AppSpacing.s12),
                                    Text(
                                      widget.excerpt,
                                      style: context.textTheme.bodyMedium,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: AppSpacing.s24),

                              // Chapter selection button
                              InkWell(
                                onTap: _selectChapters,
                                borderRadius: BorderRadius.circular(AppRadius.corner12),
                                child: Container(
                                  padding: const EdgeInsets.all(AppSpacing.s16),
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(AppRadius.corner12),
                                    border: Border.all(
                                      color: _selectedChapters.isNotEmpty
                                          ? context.colorScheme.primary
                                          : context.colorScheme.outline.withOpacity(0.2),
                                      width: _selectedChapters.isNotEmpty ? 2 : 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.folder_outlined,
                                        color: _selectedChapters.isNotEmpty
                                            ? context.colorScheme.primary
                                            : context.colorScheme.onSurfaceVariant,
                                      ),
                                      const SizedBox(width: AppSpacing.s12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'انتخاب سرفصل',
                                              style: context.textTheme.bodyLarge?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            if (_selectedChapters.isNotEmpty) ...[
                                              const SizedBox(height: AppSpacing.s4),
                                              Text(
                                                '${_selectedChapters.length} سرفصل انتخاب شده',
                                                style: context.textTheme.bodySmall?.copyWith(
                                                  color: context.colorScheme.primary,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 16,
                                        color: context.colorScheme.onSurfaceVariant,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: AppSpacing.s24),

                              // User note field - simplified
                              Text(
                                'یادداشت (اختیاری)',
                                style: context.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.s8),
                              TextFormField(
                                controller: noteController,
                                decoration: InputDecoration(
                                  hintText: 'یادداشت یا توضیحی درباره این بریده...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(AppRadius.corner12),
                                  ),
                                  filled: true,
                                  fillColor: context.colorScheme.surfaceContainerHighest,
                                  contentPadding: const EdgeInsets.all(AppSpacing.s16),
                                ),
                                maxLines: 3,
                                textInputAction: TextInputAction.newline,
                              ),
                            ],
                          ),
                        ),
                      ),
          ),

          // Bottom actions
          Container(
            padding: const EdgeInsets.all(AppSpacing.s20),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: context.colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.corner12),
                        ),
                      ),
                      child: const Text('انصراف'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _handleSave,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.corner12),
                        ),
                      ),
                      child: const Text('ذخیره'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}

// Separate bottom sheet for chapter selection
Future<List<int>?> showChapterSelectionBottomSheet({
  required BuildContext context,
  List<int> initiallySelected = const [],
}) async {
  return await showModalBottomSheet<List<int>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    enableDrag: true,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) => _ChapterSelectionBottomSheetContent(
        initiallySelected: initiallySelected,
        scrollController: scrollController,
      ),
    ),
  );
}

class _ChapterSelectionBottomSheetContent extends StatefulWidget {
  final List<int> initiallySelected;
  final ScrollController scrollController;

  const _ChapterSelectionBottomSheetContent({
    required this.initiallySelected,
    required this.scrollController,
  });

  @override
  State<_ChapterSelectionBottomSheetContent> createState() => _ChapterSelectionBottomSheetContentState();
}

class _ChapterSelectionBottomSheetContentState extends State<_ChapterSelectionBottomSheetContent> {
  final chaptersRepository = GetIt.I<ChaptersRepository>();
  List<Chapter> _chapters = [];
  final Set<int> _selectedChapters = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _selectedChapters.addAll(widget.initiallySelected);
    _loadChapters();
  }

  Future<void> _loadChapters() async {
    setState(() => _isLoading = true);
    try {
      final chapters = await chaptersRepository.getMyChapters();
      if (mounted) {
        setState(() {
          _chapters = chapters;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطا در بارگذاری سرفصل‌ها: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _createNewChapter() async {
    // Close current bottom sheet temporarily
    Navigator.pop(context);
    
    // Show create chapter bottom sheet
    await showCreateChapterBottomSheet(
      context: context,
      onSave: (title, description, image, categoryId) async {
        try {
          // Create chapter
          await chaptersRepository.createChapter(
            title: title,
            description: description,
            image: image,
            categoryId: categoryId,
          );
          
          // Reload chapters and show selection sheet again
          if (context.mounted) {
            await chaptersRepository.getMyChapters();
            if (context.mounted) {
              final result = await showChapterSelectionBottomSheet(
                context: context,
                initiallySelected: _selectedChapters.toList(),
              );
              if (result != null && mounted) {
                Navigator.pop(context, result);
              }
            }
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('خطا در ایجاد سرفصل: ${e.toString()}'),
                backgroundColor: Colors.red,
              ),
            );
            // Show selection sheet again even if error
            if (context.mounted) {
              final result = await showChapterSelectionBottomSheet(
                context: context,
                initiallySelected: _selectedChapters.toList(),
              );
              if (result != null && mounted) {
                Navigator.pop(context, result);
              }
            }
          }
        }
      },
    );
  }

  void _handleDone() {
    Navigator.pop(context, _selectedChapters.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: context.colorScheme.onSurfaceVariant.withOpacity(0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s20,
              vertical: AppSpacing.s16,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.folder_outlined,
                  color: context.colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(width: AppSpacing.s12),
                Expanded(
                  child: Text(
                    'انتخاب سرفصل',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                  tooltip: 'بستن',
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Content
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _chapters.isEmpty
                    ? _buildEmptyState()
                    : Column(
                        children: [
                          // Create new chapter button
                          Padding(
                            padding: const EdgeInsets.all(AppSpacing.s16),
                            child: OutlinedButton.icon(
                              onPressed: _createNewChapter,
                              icon: const Icon(Icons.add_circle_outline),
                              label: const Text('ایجاد سرفصل جدید'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.s16,
                                  vertical: AppSpacing.s12,
                                ),
                              ),
                            ),
                          ),
                          
                          // Chapters list
                          Expanded(
                            child: ListView.separated(
                              controller: widget.scrollController,
                              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
                              itemCount: _chapters.length,
                              separatorBuilder: (context, index) => Divider(
                                height: 1,
                                thickness: 1,
                                color: context.colorScheme.outline.withOpacity(0.1),
                              ),
                              itemBuilder: (context, index) {
                                final chapter = _chapters[index];
                                final isSelected = _selectedChapters.contains(chapter.id);
                                
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (isSelected) {
                                        _selectedChapters.remove(chapter.id);
                                      } else {
                                        _selectedChapters.add(chapter.id);
                                      }
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(AppRadius.corner12),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.s12),
                                    child: Row(
                                      children: [
                                        // Checkbox
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: isSelected
                                                  ? context.colorScheme.primary
                                                  : context.colorScheme.outline,
                                              width: 2,
                                            ),
                                            color: isSelected
                                                ? context.colorScheme.primary
                                                : Colors.transparent,
                                          ),
                                          child: isSelected
                                              ? Icon(
                                                  Icons.check,
                                                  size: 16,
                                                  color: context.colorScheme.onPrimary,
                                                )
                                              : null,
                                        ),
                                        const SizedBox(width: AppSpacing.s12),
                                        // Chapter info
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                chapter.title,
                                                style: context.textTheme.bodyLarge?.copyWith(
                                                  fontWeight: isSelected
                                                      ? FontWeight.w600
                                                      : FontWeight.normal,
                                                  color: isSelected
                                                      ? context.colorScheme.primary
                                                      : null,
                                                ),
                                              ),
                                              if (chapter.description != null &&
                                                  chapter.description!.isNotEmpty) ...[
                                                const SizedBox(height: AppSpacing.s4),
                                                Text(
                                                  chapter.description!,
                                                  style: context.textTheme.bodySmall?.copyWith(
                                                    color: context.colorScheme.onSurfaceVariant,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
          ),

          // Bottom actions
          Container(
            padding: const EdgeInsets.all(AppSpacing.s20),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: context.colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.corner12),
                        ),
                      ),
                      child: const Text('انصراف'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _handleDone,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.corner12),
                        ),
                      ),
                      child: Text(_selectedChapters.isEmpty ? 'تأیید' : 'تأیید (${_selectedChapters.length})'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.s32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_outlined,
            size: 64,
            color: context.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: AppSpacing.s16),
          Text(
            'سرفصلی وجود ندارد',
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.s8),
          Text(
            'برای افزودن یادداشت، ابتدا باید یک سرفصل ایجاد کنید.',
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.s24),
          ElevatedButton.icon(
            onPressed: _createNewChapter,
            icon: const Icon(Icons.add_circle_outline),
            label: const Text('ایجاد سرفصل جدید'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s24,
                vertical: AppSpacing.s16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

