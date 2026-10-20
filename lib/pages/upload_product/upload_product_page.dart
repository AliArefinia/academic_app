import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import 'package:academic/pages/upload_product/logic/upload_product_cubit.dart';
import 'package:academic/pages/upload_product/logic/upload_product_state.dart';
import 'package:intl/intl.dart';
import 'dart:io';

/// TextInputFormatter that converts Persian digits to English and formats with commas
class PriceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    const Map<String, String> persianToEnglish = {
      '۰': '0',
      '۱': '1',
      '۲': '2',
      '۳': '3',
      '۴': '4',
      '۵': '5',
      '۶': '6',
      '۷': '7',
      '۸': '8',
      '۹': '9',
    };

    // Convert Persian digits to English
    String convertedText = newValue.text;
    persianToEnglish.forEach((persian, english) {
      convertedText = convertedText.replaceAll(persian, english);
    });

    // Remove all non-digit characters
    String digitsOnly = convertedText.replaceAll(RegExp(r'[^\d]'), '');

    // If empty, return empty
    if (digitsOnly.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // Parse the number and format with commas
    final number = int.tryParse(digitsOnly);
    if (number == null) {
      return oldValue;
    }

    final formatter = NumberFormat('#,###', 'en_US');
    final formattedText = formatter.format(number);

    // Calculate cursor position
    // If user is typing (text is growing), place cursor at the end
    // If user is deleting, try to maintain relative position
    final oldText = oldValue.text.replaceAll(RegExp(r'[^\d]'), '');
    final newText = digitsOnly;
    
    int cursorPosition = formattedText.length;
    
    // If text is growing (user is typing), always put cursor at end
    if (newText.length > oldText.length) {
      cursorPosition = formattedText.length;
    } else if (newText.length < oldText.length) {
      // User is deleting - try to maintain position
      final oldCursorPos = oldValue.selection.baseOffset;
      int digitsBeforeCursor = 0;
      for (int i = 0; i < oldCursorPos && i < oldValue.text.length; i++) {
        if (RegExp(r'\d').hasMatch(oldValue.text[i])) {
          digitsBeforeCursor++;
        }
      }
      
      // Find position in formatted text
      if (digitsBeforeCursor > 0) {
        int digitCount = 0;
        for (int i = 0; i < formattedText.length; i++) {
          if (RegExp(r'\d').hasMatch(formattedText[i])) {
            digitCount++;
            if (digitCount >= digitsBeforeCursor) {
              cursorPosition = i + 1;
              break;
            }
          }
        }
      }
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: cursorPosition.clamp(0, formattedText.length),
      ),
    );
  }
}

class UploadProductPage extends StatefulWidget {
  const UploadProductPage({super.key});

  @override
  State<UploadProductPage> createState() => _UploadProductPageState();
}

class _UploadProductPageState extends State<UploadProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberOfPagesController = TextEditingController();
  final _publishYearController = TextEditingController();
  final _priceController = TextEditingController();
  final _contentController = TextEditingController();

  File? _file;
  File? _sample;
  File? _image;
  int? _selectedCategoryId;
  String _selectedType = '1'; // 1 = جزوه

  @override
  void initState() {
    super.initState();
    context.read<UploadProductCubit>().loadCategories();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberOfPagesController.dispose();
    _publishYearController.dispose();
    _priceController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _file = File(result.files.single.path!);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorSelectingFileWithMessage(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _pickSample() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _sample = File(result.files.single.path!);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorSelectingSampleFileWithMessage(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (image != null) {
        setState(() {
          _image = File(image.path);
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

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.pleaseSelectMainFile),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.pleaseSelectCategory),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.pleaseSelectProductImage),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<UploadProductCubit>().uploadProduct(
          name: _nameController.text.trim(),
          numberOfPages: int.tryParse(_numberOfPagesController.text) ?? 0,
          publishYear: _publishYearController.text.trim(),
          type: _selectedType,
          price: _convertPersianToEnglish(
            _priceController.text.trim().replaceAll(',', '').replaceAll(' ', ''),
          ),
          content: _contentController.text.trim(),
          categoryId: _selectedCategoryId!,
          file: _file!,
          sample: _sample,
          image: _image,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadProductCubit, UploadProductState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {},
          success: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 3),
              ),
            );
            Navigator.of(context).pop(true);
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 4),
              ),
            );
          },
        );
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: l10n.uploadAnswerSheetOrHandout,
          icon: Icons.upload_file_rounded,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: BlocBuilder<UploadProductCubit, UploadProductState>(
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );

            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.s20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Type Selection
                    _buildSectionTitle(l10n.contentType),
                    const SizedBox(height: AppSpacing.s12),
                    _buildTypeSelector(),
                    const SizedBox(height: AppSpacing.s24),

                    // Category Selection
                    _buildSectionTitle(l10n.category),
                    const SizedBox(height: AppSpacing.s12),
                    _buildCategorySelector(),
                    const SizedBox(height: AppSpacing.s24),

                    // Name
                    _buildSectionTitle(l10n.productName),
                    const SizedBox(height: AppSpacing.s12),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: l10n.productNameExample,
                        labelText: l10n.firstName,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.pleaseEnterProductName;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.s24),

                    // Number of Pages
                    _buildSectionTitle(l10n.pageCount),
                    const SizedBox(height: AppSpacing.s12),
                    TextFormField(
                      controller: _numberOfPagesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: l10n.pageCountExample,
                        labelText: l10n.pageCount,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.pleaseEnterPageCount;
                        }
                        if (int.tryParse(value) == null) {
                          return l10n.pleaseEnterValidNumber;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.s24),

                    // Publish Year
                    _buildSectionTitle(l10n.publishYear),
                    const SizedBox(height: AppSpacing.s12),
                    TextFormField(
                      controller: _publishYearController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: l10n.publishYearExample,
                        labelText: l10n.publishYear,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.pleaseEnterPublishYear;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.s24),

                    // Price
                    _buildSectionTitle(l10n.priceInToman),
                    const SizedBox(height: AppSpacing.s12),
                    TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        PriceFormatter(),
                      ],
                      decoration: InputDecoration(
                        hintText: l10n.priceExample,
                        labelText: l10n.price,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.pleaseEnterPrice;
                        }
                        // Remove commas and convert Persian digits to English before validation
                        final cleanValue = value.replaceAll(',', '').replaceAll(' ', '');
                        final convertedValue = _convertPersianToEnglish(cleanValue);
                        if (int.tryParse(convertedValue) == null) {
                          return l10n.pleaseEnterValidNumber;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.s24),

                    // Content/Description
                    _buildSectionTitle(l10n.description),
                    const SizedBox(height: AppSpacing.s12),
                    TextFormField(
                      controller: _contentController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: l10n.enterProductDescription,
                        labelText: l10n.description,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.pleaseEnterDescription;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSpacing.s24),

                    // File Selection
                    _buildSectionTitle(l10n.mainFileRequired),
                    const SizedBox(height: AppSpacing.s12),
                    _buildFileSelector(
                      file: _file,
                      onTap: _pickFile,
                      label: l10n.selectFilePdfDoc,
                    ),
                    const SizedBox(height: AppSpacing.s24),

                    // Sample File (Optional)
                    _buildSectionTitle(l10n.sampleFileOptional),
                    const SizedBox(height: AppSpacing.s12),
                    _buildFileSelector(
                      file: _sample,
                      onTap: _pickSample,
                      label: l10n.selectSampleFile,
                    ),
                    const SizedBox(height: AppSpacing.s24),

                    // Image (Required)
                    _buildSectionTitle(l10n.productImageRequired),
                    const SizedBox(height: AppSpacing.s12),
                    _buildImageSelector(),
                    const SizedBox(height: AppSpacing.s32),

                    // Submit Button
                    ElevatedButton(
                      onPressed: isLoading ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.s16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.corner12),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              l10n.uploadProduct,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                    const SizedBox(height: AppSpacing.s20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: context.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colorScheme.outline,
        ),
        borderRadius: BorderRadius.circular(AppRadius.corner12),
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedType,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSpacing.s16,
            vertical: AppSpacing.s12,
          ),
          border: InputBorder.none,
        ),
        items: [
          DropdownMenuItem(
            value: '1',
            child: Text(l10n.handout),
          ),
        ],
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _selectedType = value;
            });
          }
        },
      ),
    );
  }

  Widget _buildCategorySelector() {
    final cubit = context.read<UploadProductCubit>();
    final categories = cubit.categories;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colorScheme.outline,
        ),
        borderRadius: BorderRadius.circular(AppRadius.corner12),
      ),
      child: DropdownButtonFormField<int>(
        value: _selectedCategoryId,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSpacing.s16,
            vertical: AppSpacing.s12,
          ),
          border: InputBorder.none,
          hintText: l10n.selectCategory,
        ),
        items: categories.map((category) {
          return DropdownMenuItem<int>(
            value: category.id,
            child: Text(category.name),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedCategoryId = value;
          });
        },
        validator: (value) {
          if (value == null) {
            return l10n.pleaseSelectCategory;
          }
          return null;
        },
      ),
    );
  }

  Widget _buildFileSelector({
    required File? file,
    required VoidCallback onTap,
    required String label,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.corner12),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.s16),
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(AppRadius.corner12),
        ),
        child: Row(
          children: [
            Icon(
              Icons.attach_file,
              color: context.colorScheme.primary,
            ),
            const SizedBox(width: AppSpacing.s12),
            Expanded(
              child: Text(
                file?.path.split('/').last ?? label,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: file != null
                      ? context.colorScheme.onSurface
                      : context.colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (file != null)
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    if (file == _file) {
                      _file = null;
                    } else if (file == _sample) {
                      _sample = null;
                    }
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSelector() {
    return InkWell(
      onTap: _pickImage,
      borderRadius: BorderRadius.circular(AppRadius.corner12),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.s16),
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(AppRadius.corner12),
        ),
        child: _image != null
            ? Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.corner8),
                    child: Image.file(
                      _image!,
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
                        onPressed: _pickImage,
                        icon: const Icon(Icons.edit),
                        label: Text(l10n.changeImage),
                      ),
                      const SizedBox(width: AppSpacing.s16),
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _image = null;
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
                    Icons.image,
                    color: context.colorScheme.primary,
                  ),
                  const SizedBox(width: AppSpacing.s12),
                  Text(
                    l10n.selectImage,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  /// Converts Persian digits to English digits
  String _convertPersianToEnglish(String input) {
    const Map<String, String> persianToEnglish = {
      '۰': '0',
      '۱': '1',
      '۲': '2',
      '۳': '3',
      '۴': '4',
      '۵': '5',
      '۶': '6',
      '۷': '7',
      '۸': '8',
      '۹': '9',
    };

    String result = input;
    persianToEnglish.forEach((persian, english) {
      result = result.replaceAll(persian, english);
    });

    return result;
  }
}

