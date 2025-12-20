import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/data/model/chapter.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/data/api/categories/model/category_model.dart';
import 'package:academic/widgets/category_tree_bottom_sheet.dart';

void showChapterDialog({
  required BuildContext context,
  Chapter? chapter,
  required Function(String title, String? description, File? image, int? categoryId) onSave,
}) async {
  final titleController = TextEditingController(text: chapter?.title ?? '');
  final descriptionController = TextEditingController(text: chapter?.description ?? '');
  final formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  CategoryModel? selectedCategory;

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(chapter == null ? 'ایجاد سرفصل جدید' : 'ویرایش سرفصل'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (chapter == null) ...[
                  // Title field only for create
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'عنوان سرفصل',
                      hintText: 'مثلاً: هوش مصنوعی',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'عنوان الزامی است';
                      }
                      if (value.trim().length < 3) {
                        return 'عنوان باید حداقل ۳ کاراکتر باشد';
                      }
                      return null;
                    },
                    autofocus: true,
                  ),
                  const SizedBox(height: AppSpacing.s16),
                ],
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: chapter == null ? 'توضیحات (اختیاری)' : 'توضیحات',
                    hintText: 'توضیح کوتاه درباره این سرفصل',
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                if (chapter == null) ...[
                  // Category selector only for create
                  const SizedBox(height: AppSpacing.s16),
                  const Text(
                    'دسته‌بندی (اختیاری)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s8),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => CategoryTreeBottomSheet(
                          selectedCategory: selectedCategory,
                          onCategorySelected: (category) {
                            setState(() {
                              selectedCategory = category;
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
                        color: selectedCategory != null
                            ? context.colorScheme.primaryContainer.withOpacity(0.15)
                            : context.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(AppRadius.corner12),
                        border: Border.all(
                          color: selectedCategory != null
                              ? context.colorScheme.primary
                              : context.colorScheme.outline.withOpacity(0.2),
                          width: selectedCategory != null ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.category_rounded,
                            color: selectedCategory != null
                                ? context.colorScheme.primary
                                : context.colorScheme.onSurfaceVariant,
                            size: 24,
                          ),
                          const SizedBox(width: AppSpacing.s12),
                          Expanded(
                            child: Text(
                              selectedCategory?.name ?? 'انتخاب دسته‌بندی',
                              style: context.textTheme.bodyLarge?.copyWith(
                                color: selectedCategory != null
                                    ? context.colorScheme.primary
                                    : context.colorScheme.onSurfaceVariant,
                                fontWeight: selectedCategory != null
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
                  // Image picker only for create
                  const SizedBox(height: AppSpacing.s16),
                  const Text(
                    'تصویر (اختیاری)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s8),
                  InkWell(
                    onTap: () async {
                      try {
                        final XFile? image = await _imagePicker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 80,
                          maxWidth: 1920,
                          maxHeight: 1920,
                        );
                        if (image != null) {
                          setState(() {
                            _selectedImage = File(image.path);
                          });
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('خطا در انتخاب تصویر: ${e.toString()}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.s16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: context.colorScheme.outline,
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
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.s12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton.icon(
                                      onPressed: () async {
                                        try {
                                          final XFile? image = await _imagePicker.pickImage(
                                            source: ImageSource.gallery,
                                            imageQuality: 80,
                                            maxWidth: 1920,
                                            maxHeight: 1920,
                                          );
                                          if (image != null) {
                                            setState(() {
                                              _selectedImage = File(image.path);
                                            });
                                          }
                                        } catch (e) {
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('خطا در انتخاب تصویر: ${e.toString()}'),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      icon: const Icon(Icons.edit),
                                      label: const Text('تغییر تصویر'),
                                    ),
                                    const SizedBox(width: AppSpacing.s16),
                                    TextButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          _selectedImage = null;
                                        });
                                      },
                                      icon: const Icon(Icons.delete),
                                      label: const Text('حذف'),
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
                                ),
                                const SizedBox(width: AppSpacing.s8),
                                Text(
                                  'انتخاب تصویر',
                                  style: TextStyle(
                                    color: context.colorScheme.onSurfaceVariant,
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
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('انصراف'),
          ),
          ElevatedButton(
            onPressed: () {
              if (chapter == null) {
                // Create mode - validate title
                if (formKey.currentState!.validate()) {
                  Navigator.pop(context);
                  onSave(
                    titleController.text.trim(),
                    descriptionController.text.trim().isEmpty
                        ? null
                        : descriptionController.text.trim(),
                    _selectedImage,
                    selectedCategory?.id,
                  );
                }
              } else {
                // Update mode - only description
                Navigator.pop(context);
                onSave(
                  '', // Title not used in update
                  descriptionController.text.trim().isEmpty
                      ? null
                      : descriptionController.text.trim(),
                  null, // Image not used in update
                  null, // Category not used in update
                );
              }
            },
            child: const Text('ذخیره'),
          ),
        ],
      ),
    ),
  );
}
