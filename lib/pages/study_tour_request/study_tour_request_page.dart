import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/helper/error_helper.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/data/api/categories/model/category_model.dart';
import 'logic/study_tour_request_cubit.dart';

class StudyTourRequestPage extends StatefulWidget {
  const StudyTourRequestPage({super.key});

  @override
  State<StudyTourRequestPage> createState() => _StudyTourRequestPageState();
}

class _StudyTourRequestPageState extends State<StudyTourRequestPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  CategoryModel? _selectedCategory;

  // برای مدیریت state validation
  bool _isTitleValid = false;
  bool _isDescriptionValid = false;

  // ذخیره دسته‌بندی‌ها برای نمایش در تمام حالات
  List<CategoryModel>? _loadedCategories;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));

    _fadeController.forward();
    _slideController.forward();

    // تنظیم وضعیت اولیه validation
    _isTitleValid = _titleController.text.trim().isNotEmpty;
    _isDescriptionValid = _descriptionController.text.trim().isNotEmpty;

    // اضافه کردن listener برای validation
    _titleController.addListener(_onTitleChanged);
    _descriptionController.addListener(_onDescriptionChanged);

    context.read<StudyTourRequestCubit>().loadCategories();
  }

  void _onTitleChanged() {
    setState(() {
      _isTitleValid = _titleController.text.trim().isNotEmpty;
    });
  }

  void _onDescriptionChanged() {
    setState(() {
      _isDescriptionValid = _descriptionController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _titleController.removeListener(_onTitleChanged);
    _descriptionController.removeListener(_onDescriptionChanged);
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudyTourRequestCubit, StudyTourRequestState>(
      listener: (context, state) {
        state.maybeWhen(
          categoriesLoaded: (categories) {
            // ذخیره دسته‌بندی‌ها برای استفاده در تمام حالات
            setState(() {
              _loadedCategories = categories;
            });
          },
          success: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
            // ارسال نتیجه true برای نشان دادن اینکه لیست باید رفرش شود
            context.pop(true);
          },
          error: (message) {
            ErrorHelper.showErrorSnackBar(context, message);
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        appBar: AppBar(
          title: const Text(
            'درخواست سیر مطالعاتی',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocBuilder<StudyTourRequestCubit, StudyTourRequestState>(
          builder: (context, state) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.all(20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(),
                            SizedBox(height: 32.h),
                            _buildCategorySection(context, state),
                            SizedBox(height: 24.h),
                            _buildTitleSection(),
                            SizedBox(height: 24.h),
                            _buildDescriptionSection(),
                            SizedBox(height: 40.h),
                          ],
                        ),
                      ),
                    ),
                    // دکمه ثابت در پایین صفحه
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surface,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, -5),
                          ),
                        ],
                      ),
                      child: _buildSubmitButton(context, state),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colorScheme.primary.withOpacity(0.1),
            context.colorScheme.secondary.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: context.colorScheme.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: context.colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.school_outlined,
              size: 32.w,
              color: context.colorScheme.primary,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'سیر مطالعاتی خود را طراحی کنید',
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'موضوع مورد نظر خود را انتخاب کنید و درخواست سیر مطالعاتی خود را ثبت کنید',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context, StudyTourRequestState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'انتخاب دسته‌بندی',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 12.h),
        Builder(
          builder: (context) {
            // اگر دسته‌بندی‌ها بارگذاری شده‌اند، نمایش بده
            if (_loadedCategories != null) {
              return _buildCategoryGrid(_loadedCategories!);
            } else {
              // در غیر این صورت، فقط هنگام بارگذاری دسته‌بندی‌ها لودینگ نشان بده
              return state.maybeWhen(
                loadingCategories: () => _buildCategoryLoading(),
                orElse: () => const SizedBox(), // برای سایر حالات چیزی نشان نده
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildCategoryGrid(List<CategoryModel> categories) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory?.id == category.id;
          
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
                HapticFeedback.lightImpact();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? context.colorScheme.primary
                      : context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: isSelected
                        ? context.colorScheme.primary
                        : context.colorScheme.outline.withOpacity(0.3),
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: context.colorScheme.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    category.name,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? context.colorScheme.onPrimary
                          : context.colorScheme.onSurface,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryLoading() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: context.colorScheme.outline.withOpacity(0.3),
            ),
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'عنوان سیر مطالعاتی',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: context.colorScheme.outline.withOpacity(0.3),
            ),
          ),
          child: TextField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: 'مثال: سیر مطالعاتی تاریخ ایران',
              hintStyle: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.5),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16.w),
            ),
            style: context.textTheme.bodyLarge,
            textDirection: TextDirection.rtl,
            onTap: () {
              // وقتی روی فیلد کلیک می‌شود، کمی صبر کن تا کیبورد باز شود
              Future.delayed(const Duration(milliseconds: 300), () {
                // اسکرول کن تا دکمه قابل دسترسی باشد
                if (mounted) {
                  // این کار باعث می‌شود صفحه کمی اسکرول شود
                }
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'توضیحات',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: context.colorScheme.outline.withOpacity(0.3),
            ),
          ),
          child: TextField(
            controller: _descriptionController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'توضیحات خود را در مورد سیر مطالعاتی مورد نظر بنویسید...',
              hintStyle: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.5),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16.w),
            ),
            style: context.textTheme.bodyLarge,
            textDirection: TextDirection.rtl,
            onTap: () {
              // وقتی روی فیلد کلیک می‌شود، کمی صبر کن تا کیبورد باز شود
              Future.delayed(const Duration(milliseconds: 300), () {
                // اسکرول کن تا دکمه قابل دسترسی باشد
                if (mounted) {
                  // این کار باعث می‌شود صفحه کمی اسکرول شود
                }
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context, StudyTourRequestState state) {
    final isLoading = state.maybeWhen(
      loadingSubmission: () => true,
      orElse: () => false,
    );

    final canSubmit = _selectedCategory != null && _isTitleValid && _isDescriptionValid;

    print('🔍 Button state check:');
    print('  - Selected category: ${_selectedCategory != null} (${_selectedCategory?.name})');
    print('  - Title not empty: $_isTitleValid (${_titleController.text.trim()})');
    print('  - Description not empty: $_isDescriptionValid (${_descriptionController.text.trim()})');
    print('  - Can submit: $canSubmit');
    print('  - Is loading: $isLoading');

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: canSubmit && !isLoading
            ? () {
                print('🔘 Submit button clicked!');
                print('📝 Selected category: ${_selectedCategory?.name} (ID: ${_selectedCategory?.id})');
                print('📝 Title: ${_titleController.text.trim()}');
                print('📝 Description: ${_descriptionController.text.trim()}');
                print('📝 Can submit: $canSubmit');
                print('📝 Is loading: $isLoading');
                
                context.read<StudyTourRequestCubit>().submitRequest(
                      categoryId: _selectedCategory!.id,
                      title: _titleController.text.trim(),
                      description: _descriptionController.text.trim(),
                    );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: canSubmit
              ? context.colorScheme.primary
              : context.colorScheme.outline.withOpacity(0.3),
          foregroundColor: canSubmit
              ? context.colorScheme.onPrimary
              : context.colorScheme.onSurface.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: canSubmit ? 4 : 0,
        ),
        child: isLoading
            ? SizedBox(
                width: 24.w,
                height: 24.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    context.colorScheme.onPrimary,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.send, size: 20.w),
                  SizedBox(width: 8.w),
                  Text(
                    'ثبت درخواست',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
