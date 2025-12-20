import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/core/helper/error_helper.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/data/api/auth/model/auth_response_model.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'logic/profile_management_cubit.dart';

class UserInfoSection extends StatefulWidget {
  final UserModel user;

  const UserInfoSection({
    super.key,
    required this.user,
  });

  @override
  State<UserInfoSection> createState() => _UserInfoSectionState();
}

class _UserInfoSectionState extends State<UserInfoSection> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _passwordController;
  late TextEditingController _aboutController;
  String _selectedGender = 'male';
  DateTime? _selectedDate;
  File? _selectedImage;
  final ImagePicker _imagePicker = ImagePicker();

  DateTime get _minDate => DateTime.now().subtract(const Duration(days: 365 * 100)); // 100 years ago
  DateTime get _maxDate => DateTime.now().subtract(const Duration(days: 365 * 10)); // 10 years ago

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name ?? '');
    _lastNameController = TextEditingController(text: widget.user.lastName ?? '');
    _passwordController = TextEditingController();
    _aboutController = TextEditingController(text: widget.user.about ?? '');
    _selectedGender = widget.user.gender ?? 'male';

    // Parse Persian date format (e.g., "1348/10/11") to DateTime
    if (widget.user.dateOfBirth != null && widget.user.dateOfBirth!.isNotEmpty) {
      _selectedDate = _parsePersianDate(widget.user.dateOfBirth!);
    }
  }

  DateTime? _parsePersianDate(String persianDate) {
    try {
      // Parse Persian date format: "1348/10/11"
      final parts = persianDate.split('/');
      if (parts.length == 3) {
        final year = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final day = int.parse(parts[2]);
        
        // Convert Persian year to Gregorian (approximate)
        final gregorianYear = year + 621;
        return DateTime(gregorianYear, month, day);
      }
    } catch (e) {
      // If parsing fails, try to parse as ISO format
      return DateTime.tryParse(persianDate);
    }
    return null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  Future<void> _pickAndCropImage() async {
    try {
      // Show source selection dialog
      final ImageSource? source = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('انتخاب منبع تصویر'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('دوربین'),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('گالری'),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          ),
        ),
      );

      if (source == null) return;

      final XFile? image = await _imagePicker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      
      if (image == null) return;

      // Validate image file
      final imageFile = File(image.path);
      if (!await imageFile.exists()) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('فایل تصویر یافت نشد'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      // Check file size (max 10MB)
      final fileSize = await imageFile.length();
      if (fileSize > 10 * 1024 * 1024) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('حجم فایل تصویر نباید بیشتر از ۱۰ مگابایت باشد'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      try {
        // Set status bar style before opening cropper
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).colorScheme.primary,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        );

        final croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 80,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'ویرایش تصویر',
              toolbarColor: Theme.of(context).colorScheme.primary,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
              hideBottomControls: false,
              showCropGrid: true,
              statusBarColor: Theme.of(context).colorScheme.primary,
              activeControlsWidgetColor: Theme.of(context).colorScheme.primary,
              cropFrameColor: Theme.of(context).colorScheme.primary,
              cropGridColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              cropGridStrokeWidth: 2,
              backgroundColor: Colors.black,
              dimmedLayerColor: Colors.black.withOpacity(0.8),
            ),
            IOSUiSettings(
              title: 'ویرایش تصویر',
              aspectRatioLockEnabled: true,
              resetAspectRatioEnabled: false,
            ),
          ],
        );

        // Reset status bar style after cropper closes
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        );

        if (croppedFile != null && mounted) {
          setState(() {
            _selectedImage = File(croppedFile.path);
          });
        }
      } catch (cropError) {
        // If cropping fails, use original image
        if (mounted) {
          setState(() {
            _selectedImage = File(image.path);
          });
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تصویر بدون ویرایش انتخاب شد'),
              backgroundColor: Colors.orange,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = 'خطا در انتخاب تصویر';
        
        if (e.toString().contains('UCropActivity')) {
          errorMessage = 'خطا در ویرایش تصویر. لطفا تصویر دیگری انتخاب کنید';
        } else if (e.toString().contains('Permission')) {
          errorMessage = 'دسترسی به گالری یا دوربین داده نشده است';
        } else if (e.toString().contains('Bounds')) {
          errorMessage = 'فرمت تصویر پشتیبانی نمی‌شود. لطفا تصویر JPG یا PNG انتخاب کنید';
        } else if (e.toString().contains('FileSystemException')) {
          errorMessage = 'خطا در خواندن فایل تصویر. لطفا تصویر دیگری انتخاب کنید';
        } else if (e.toString().contains('FormatException')) {
          errorMessage = 'فرمت تصویر نامعتبر است. لطفا تصویر معتبری انتخاب کنید';
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Theme.of(context).colorScheme.error,
            duration: const Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final locale = Localizations.localeOf(context);
    final isPersian = locale.languageCode == 'fa';

    // For Persian, we'll show a custom dialog with Jalali dates
    if (isPersian) {
      await _showPersianDatePicker(context);
    } else {
      // Gregorian date picker
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? _maxDate,
        firstDate: _minDate,
        lastDate: _maxDate,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Theme.of(context).colorScheme.primary,
                onPrimary: Colors.white,
                surface: Theme.of(context).colorScheme.surface,
                onSurface: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            child: child!,
          );
        },
      );
      
      if (picked != null && mounted) {
        setState(() {
          _selectedDate = picked;
        });
      }
    }
  }

  Future<void> _showPersianDatePicker(BuildContext context) async {
    // Convert current date to Jalali for initial values
    final initialJalali = _selectedDate != null 
        ? Jalali.fromDateTime(_selectedDate!)
        : Jalali.fromDateTime(_maxDate);
    
    final minJalali = Jalali.fromDateTime(_minDate);
    final maxJalali = Jalali.fromDateTime(_maxDate);
    
    // Show custom dialog for Jalali date selection
    final Jalali? picked = await showDialog<Jalali>(
      context: context,
      builder: (context) => _JalaliDatePickerDialog(
        initialDate: initialJalali,
        minDate: minJalali,
        maxDate: maxJalali,
      ),
    );
    
    if (picked != null && mounted) {
      setState(() {
        _selectedDate = picked.toDateTime();
      });
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(context.appTranslate?.pleaseSelectBirthDate ?? 'لطفا تاریخ تولد را انتخاب کنید'),
                backgroundColor: Colors.red,
              ),
            );
          }
        });
        return;
      }

      if (_selectedDate!.isAfter(_maxDate)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(context.appTranslate?.birthDateMustBeBeforeToday ?? 'سن شما باید حداقل ۱۰ سال باشد'),
                backgroundColor: Colors.red,
              ),
            );
          }
        });
        return;
      }

      if (_selectedDate!.isBefore(_minDate)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تاریخ تولد نامعتبر است'),
                backgroundColor: Colors.red,
              ),
            );
          }
        });
        return;
      }

      // Convert image to base64 if selected
      String? avatarImage;
      if (_selectedImage != null) {
        try {
          final bytes = await _selectedImage!.readAsBytes();
          // Validate image size (max 5MB for base64)
          if (bytes.length > 5 * 1024 * 1024) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('حجم تصویر بسیار بزرگ است. لطفا تصویر کوچکتری انتخاب کنید'),
                  backgroundColor: Colors.red,
                ),
              );
            }
            return;
          }
          avatarImage = base64Encode(bytes);
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('خطا در پردازش تصویر. لطفا تصویر دیگری انتخاب کنید'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }
      }

      await context.read<ProfilemanagementCubit>().updateProfile(
        name: _nameController.text.isNotEmpty ? _nameController.text : 'کاربر',
        lastName: _lastNameController.text,
        password: _passwordController.text.isEmpty ? null : _passwordController.text,
        gender: _selectedGender,
        dateOfBirth: _selectedDate!.toIso8601String().split('T')[0], // Send only date part
        about: _aboutController.text,
        avatarImage: avatarImage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfilemanagementCubit, ProfilemanagementState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            ErrorHelper.showErrorSnackBar(context, message);
          },
          success: (message) {
            final localizedMessage = message == 'profileUpdatedSuccessfully'
                ? (context.appTranslate?.profileUpdatedSuccessfully ?? 'پروفایل با موفقیت بروزرسانی شد')
                : message;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(localizedMessage),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          loaded: (user, updateError) {
            if (updateError != null && updateError.isNotEmpty) {
              ErrorHelper.showErrorSnackBar(context, updateError);
            }
          },
        );
      },
      child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile Image Section
              Center(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: _pickAndCropImage,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: _selectedImage != null
                              ? Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 120,
                                )
                              : (widget.user.avatar != null &&
                                      widget.user.avatar!.isNotEmpty)
                                  ? Image.network(
                                      widget.user.avatar!.startsWith('http') 
                                          ? widget.user.avatar!
                                          : 'https://demo.halalread.ir${widget.user.avatar!}',
                                      fit: BoxFit.cover,
                                      width: 120,
                                      height: 120,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(
                                          Icons.person,
                                          size: 60,
                                          color: Colors.grey,
                                        );
                                      },
                                    )
                                  : const Icon(
                                      Icons.person,
                                      size: 60,
                                      color: Colors.grey,
                                    ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickAndCropImage,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.s24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'نام',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.appTranslate?.pleaseEnterName ?? 'لطفا نام را وارد کنید';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.s16),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'نام خانوادگی',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.appTranslate?.pleaseEnterLastName ?? 'لطفا نام خانوادگی را وارد کنید';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.s16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'رمز عبور (اختیاری)',
                  border: OutlineInputBorder(),
                  helperText: 'برای تغییر رمز عبور، رمز جدید را وارد کنید',
                ),
                obscureText: true,
                validator: (value) {
                  if (value != null && value.isNotEmpty && value.length < 8) {
                    return context.appTranslate?.passwordMustBeAtLeast8Chars ?? 'رمز عبور باید حداقل ۸ کاراکتر باشد';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.s16),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: const InputDecoration(
                  labelText: 'جنسیت',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'male', child: Text('مرد')),
                  DropdownMenuItem(value: 'female', child: Text('زن')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedGender = value;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.appTranslate?.pleaseSelectGender ?? 'لطفا جنسیت را انتخاب کنید';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.s16),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'تاریخ تولد',
                    border: const OutlineInputBorder(),
                    errorText: _selectedDate != null && _selectedDate!.isAfter(_maxDate)
                        ? 'سن شما باید حداقل ۱۰ سال باشد'
                        : null,
                  ),
                  child: Builder(
                    builder: (context) {
                      if (_selectedDate == null) {
                        return const Text('انتخاب تاریخ');
                      }
                      
                      final locale = Localizations.localeOf(context);
                      final isPersian = locale.languageCode == 'fa';
                      
                      if (isPersian) {
                        final jalali = Jalali.fromDateTime(_selectedDate!);
                        return Text('${jalali.formatter.yyyy}/${jalali.formatter.mm}/${jalali.formatter.dd}');
                      } else {
                        return Text('${_selectedDate!.year}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.day.toString().padLeft(2, '0')}');
                      }
                    },
                  ),
                ),
              ),
              if (_selectedDate == null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    context.appTranslate?.pleaseSelectBirthDate ?? 'لطفا تاریخ تولد را انتخاب کنید',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                ),
              const SizedBox(height: AppSpacing.s16),
              TextFormField(
                controller: _aboutController,
                decoration: const InputDecoration(
                  labelText: 'درباره من (اختیاری)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: AppSpacing.s24),
              BlocBuilder<ProfilemanagementCubit, ProfilemanagementState>(
                builder: (context, state) {
                  final isLoading = state.when(
                    initial: () => false,
                    loading: () => true,
                    loaded: (user, updateError) => false,
                    error: (message) => false,
                    success: (message) => false,
                  );
                  return ElevatedButton(
                    onPressed: isLoading ? null : _updateProfile,
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('ذخیره اطلاعات'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Simple Jalali Date Picker Dialog
class _JalaliDatePickerDialog extends StatefulWidget {
  final Jalali initialDate;
  final Jalali minDate;
  final Jalali maxDate;

  const _JalaliDatePickerDialog({
    required this.initialDate,
    required this.minDate,
    required this.maxDate,
  });

  @override
  State<_JalaliDatePickerDialog> createState() => _JalaliDatePickerDialogState();
}

class _JalaliDatePickerDialogState extends State<_JalaliDatePickerDialog> {
  late int selectedYear;
  late int selectedMonth;
  late int selectedDay;

  @override
  void initState() {
    super.initState();
    selectedYear = widget.initialDate.year;
    selectedMonth = widget.initialDate.month;
    selectedDay = widget.initialDate.day;
  }

  List<int> get years {
    final List<int> yearList = [];
    for (int i = widget.minDate.year; i <= widget.maxDate.year; i++) {
      yearList.add(i);
    }
    return yearList;
  }

  List<int> get months => List.generate(12, (index) => index + 1);

  List<int> get days {
    int maxDay = 31;
    if (selectedMonth <= 6) {
      maxDay = 31;
    } else if (selectedMonth <= 11) {
      maxDay = 30;
    } else {
      maxDay = Jalali(selectedYear, 12, 1).monthLength;
    }
    return List.generate(maxDay, (index) => index + 1);
  }

  String getMonthName(int month) {
    const months = [
      'فروردین', 'اردیبهشت', 'خرداد', 'تیر', 'مرداد', 'شهریور',
      'مهر', 'آبان', 'آذر', 'دی', 'بهمن', 'اسفند'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('انتخاب تاریخ تولد'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Year picker
            DropdownButtonFormField<int>(
              value: selectedYear,
              decoration: const InputDecoration(
                labelText: 'سال',
                border: OutlineInputBorder(),
              ),
              items: years.map((year) {
                return DropdownMenuItem(
                  value: year,
                  child: Text('$year'),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedYear = value;
                    // Adjust day if needed
                    if (selectedDay > days.length) {
                      selectedDay = days.length;
                    }
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            // Month picker
            DropdownButtonFormField<int>(
              value: selectedMonth,
              decoration: const InputDecoration(
                labelText: 'ماه',
                border: OutlineInputBorder(),
              ),
              items: months.map((month) {
                return DropdownMenuItem(
                  value: month,
                  child: Text(getMonthName(month)),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedMonth = value;
                    // Adjust day if needed
                    if (selectedDay > days.length) {
                      selectedDay = days.length;
                    }
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            // Day picker
            DropdownButtonFormField<int>(
              value: selectedDay <= days.length ? selectedDay : days.length,
              decoration: const InputDecoration(
                labelText: 'روز',
                border: OutlineInputBorder(),
              ),
              items: days.map((day) {
                return DropdownMenuItem(
                  value: day,
                  child: Text('$day'),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedDay = value;
                  });
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('لغو'),
        ),
        ElevatedButton(
          onPressed: () {
            final selected = Jalali(selectedYear, selectedMonth, selectedDay);
            Navigator.pop(context, selected);
          },
          child: const Text('تایید'),
        ),
      ],
    );
  }
}

