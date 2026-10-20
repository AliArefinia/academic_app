import 'package:academic/l10n/l10n.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/data/model/chapter.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/data/api/categories/model/category_model.dart';
import 'package:academic/widgets/category_tree_bottom_sheet.dart';

Future<void> showCreateChapterBottomSheet({
  required BuildContext context,
  Chapter? chapter,
  required Function(String title, String? description, File? image, int? categoryId) onSave,
}) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    enableDrag: true,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => _CreateChapterBottomSheetContent(
        chapter: chapter,
        onSave: onSave,
        scrollController: scrollController,
      ),
    ),
  );
}

class _CreateChapterBottomSheetContent extends StatefulWidget {
  final Chapter? chapter;
  final Function(String title, String? description, File? image, int? categoryId) onSave;
  final ScrollController scrollController;

  const _CreateChapterBottomSheetContent({
    required this.chapter,
    required this.onSave,
    required this.scrollController,
  });

  @override
  State<_CreateChapterBottomSheetContent> createState() => _CreateChapterBottomSheetContentState();
}

class _CreateChapterBottomSheetContentState extends State<_CreateChapterBottomSheetContent> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  CategoryModel? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.chapter?.title ?? '');
    _descriptionController = TextEditingController(text: widget.chapter?.description ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      if (image != null && mounted) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorSelectingImageWithMessage(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handleSave() {
    if (widget.chapter == null) {
      // Create mode - validate title and category
      if (_formKey.currentState!.validate()) {
        if (_selectedCategory == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.pleaseSelectCategoryFormal),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
        Navigator.pop(context);
        widget.onSave(
          _titleController.text.trim(),
          _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          _selectedImage,
          _selectedCategory?.id,
        );
      }
    } else {
      // Update mode - only description
      Navigator.pop(context);
      widget.onSave(
        '', // Title not used in update
        _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        null, // Image not used in update
        null, // Category not used in update
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCreateMode = widget.chapter == null;

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
                  isCreateMode ? Icons.add_circle_outline : Icons.edit_outlined,
                  color: context.colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(width: AppSpacing.s12),
                Expanded(
                  child: Text(
                    isCreateMode ? l10n.createNewChapter : l10n.editChapter,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                  tooltip: l10n.close,
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
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isCreateMode) ...[
                      // Title field only for create
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: l10n.chapterTitle,
                          hintText: l10n.chapterTitleExample,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.title_rounded),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.titleRequired;
                          }
                          if (value.trim().length < 3) {
                            return l10n.titleMinLength;
                          }
                          return null;
                        },
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppSpacing.s20),
                    ],

                    // Description field
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: isCreateMode ? l10n.descriptionOptional : l10n.description,
                        hintText: l10n.chapterDescriptionHint,
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.description_outlined),
                      ),
                      maxLines: 4,
                      textInputAction: TextInputAction.newline,
                    ),

                    if (isCreateMode) ...[
                      const SizedBox(height: AppSpacing.s20),

                      // Category selector
                      Text(
                        l10n.category,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s12),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => CategoryTreeBottomSheet(
                              selectedCategory: _selectedCategory,
                              onCategorySelected: (category) {
                                setState(() {
                                  _selectedCategory = category;
                                });
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.s16,
                            vertical: AppSpacing.s16,
                          ),
                          decoration: BoxDecoration(
                            color: _selectedCategory != null
                                ? context.colorScheme.primaryContainer.withOpacity(0.15)
                                : context.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(AppRadius.corner12),
                            border: Border.all(
                              color: _selectedCategory != null
                                  ? context.colorScheme.primary
                                  : context.colorScheme.outline.withOpacity(0.2),
                              width: _selectedCategory != null ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.category_rounded,
                                color: _selectedCategory != null
                                    ? context.colorScheme.primary
                                    : context.colorScheme.onSurfaceVariant,
                                size: 24,
                              ),
                              const SizedBox(width: AppSpacing.s12),
                              Expanded(
                                child: Text(
                                  _selectedCategory?.name ?? l10n.selectCategory,
                                  style: context.textTheme.bodyLarge?.copyWith(
                                    color: _selectedCategory != null
                                        ? context.colorScheme.primary
                                        : context.colorScheme.onSurfaceVariant,
                                    fontWeight: _selectedCategory != null
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: context.colorScheme.onSurfaceVariant,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.s20),

                      // Image picker
                      Text(
                        l10n.imageOptional,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s12),
                      InkWell(
                        onTap: _pickImage,
                        child: Container(
                          padding: const EdgeInsets.all(AppSpacing.s16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: context.colorScheme.outline.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(AppRadius.corner12),
                          ),
                          child: _selectedImage != null
                              ? Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(AppRadius.corner8),
                                      child: Image.file(
                                        _selectedImage!,
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: AppSpacing.s12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton.icon(
                                          onPressed: _pickImage,
                                          icon: const Icon(Icons.edit),
                                          label: Text(l10n.changeImage),
                                        ),
                                        const SizedBox(width: AppSpacing.s16),
                                        TextButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              _selectedImage = null;
                                            });
                                          },
                                          icon: const Icon(Icons.delete),
                                          label: Text(l10n.delete),
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate_outlined,
                                      color: context.colorScheme.onSurfaceVariant,
                                      size: 28,
                                    ),
                                    const SizedBox(width: AppSpacing.s8),
                                    Text(
                                      l10n.selectImage,
                                      style: TextStyle(
                                        color: context.colorScheme.onSurfaceVariant,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
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
                      child: Text(l10n.cancel),
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
                      child: Text(l10n.save),
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
