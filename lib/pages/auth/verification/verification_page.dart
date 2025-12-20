import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:pinput/pinput.dart';
import '../../../core/helper/app_helper.dart';
import '../../../core/helper/error_helper.dart';
import '../../../core/router/router.dart';
import '../../../core/theme/const.dart';
import '../../../widgets/custom_button.dart';
import '../widgets/header_widget.dart';
import 'logic/verification_cubit.dart';
import '../../../data/api/categories/model/category_model.dart';

class VerificationPage extends StatefulWidget {
  final String phone;
  final bool? isInvited;
  final bool? hasPassword;
  final bool newUser;

  const VerificationPage(this.phone, this.isInvited, this.hasPassword, this.newUser, {super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _inviteCodeController = TextEditingController();
  
  bool _showInviteCode = false;
  int _currentStep = 1; // 1: OTP, 2: Type & Category
  String? _selectedType; // "1" or "2"
  CategoryModel? _selectedCategory;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pinController.dispose();
    _inviteCodeController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _moveToStep2() {
    setState(() {
      _currentStep = 2;
    });
    _animationController.forward();
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerificationCubit, VerificationState>(
      listener: (context, state) {
        state.whenOrNull(
          otpVerified: () {
            // Move to step 2 after OTP verification only for new users
            if (widget.newUser) {
              _moveToStep2();
            }
          },
          success: (user) {
            const HomeRouteData().go(context);
          },
          error: (msg) {
            ErrorHelper.showErrorSnackBar(context, msg);
          },
        );
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => MyAppHelper().hideKeyboard(context),
          child: Scaffold(
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: _currentStep == 1
                  ? _buildStep1OTP(state)
                  : widget.newUser
                      ? _buildStep2TypeAndCategory(state)
                      : _buildStep1OTP(state),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStep1OTP(VerificationState state) {
    return SingleChildScrollView(
      key: const ValueKey('step1'),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          authHeaderWidget(context),
          const SizedBox(height: AppSpacing.s12),
          Text(
            'ورود به دانشگاه امام صادق (ع)',
            style: context.textTheme.titleLarge,
          ).addVerticalSpacing(AppSpacing.s12),
          Text(
            'کد یکبار مصرف ارسال شده به شماره زیر را وارد کنید:',
            style: context.textTheme.bodyLarge,
          ).addVerticalSpacing(AppSpacing.s12),
          // Phone number display with edit button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'شماره: ${widget.phone}',
                style: context.textTheme.bodyLarge,
              ),
              const SizedBox(width: AppSpacing.s16),
              TextButton(
                onPressed: () {
                  const LoginRoute().go(context);
                },
                child: Text(
                  'ویرایش شماره همراه',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ).addVerticalSpacing(AppSpacing.s24),
          VerificationField(controller: _pinController)
              .addVerticalSpacing(AppSpacing.s24),

          // Invite Code Section
          if (widget.isInvited != true)
            _buildInviteCodeSection(context).addVerticalSpacing(AppSpacing.s32),

          // Password login button
          if (widget.hasPassword == true)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                onPressed: () {
                  PasswordRoute(widget.phone, widget.isInvited).go(context);
                },
                child: const Text('ورود با رمز عبور'),
              ).addVerticalSpacing(AppSpacing.s32),
            ),
          CustomButton(
            child: Text(
              state.maybeWhen(loading: () => 'در حال بررسی...', orElse: () => 'ادامه'),
            ),
            onPressed: state.maybeWhen(
              loading: () => null,
              orElse: () => () async {
                final code = _pinController.text.trim();
                if (code.length == 5) {
                  final convertedCode = _convertPersianToEnglish(code);
                  final inviteCode = _inviteCodeController.text.trim();
                  final convertedInviteCode =
                      inviteCode.isNotEmpty ? _convertPersianToEnglish(inviteCode) : null;

                  await context.read<VerificationCubit>().verifyPhoneOtp(
                        widget.phone,
                        convertedCode,
                        inviteCode: convertedInviteCode,
                        newUser: widget.newUser,
                      );
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("کد ۵ رقمی را وارد کنید")),
                    );
                  }
                }
              },
            ) as Future<void> Function()?,
          ).addVerticalSpacing(AppSpacing.s32),
          Text.rich(
            TextSpan(
              text: 'قوانین',
              style: context.textTheme.bodyMedium
                  ?.copyWith(color: context.colorScheme.tertiary),
              children: [
                TextSpan(
                  text: ' استفاده از دانشگاه امام صادق (ع)',
                  style: context.textTheme.bodyMedium,
                )
              ],
            ),
          ).addVerticalSpacing(AppSpacing.s32),
        ],
      ),
    );
  }

  Widget _buildStep2TypeAndCategory(VerificationState state) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: SingleChildScrollView(
          key: const ValueKey('step2'),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpacing.s40),
              // Progress indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildProgressDot(1, true),
                  Container(
                    width: 40,
                    height: 2,
                    color: context.colorScheme.primary,
                  ),
                  _buildProgressDot(2, true),
                ],
              ).addVerticalSpacing(AppSpacing.s32),
              Text(
                'تکمیل اطلاعات',
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ).addVerticalSpacing(AppSpacing.s8),
              Text(
                'لطفاً نقش و دسته‌بندی خود را انتخاب کنید',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface.withOpacity(0.7),
                ),
              ).addVerticalSpacing(AppSpacing.s32),

              // Type Selection
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'نقش شما:',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
              ).addVerticalSpacing(AppSpacing.s12),
              Row(
                children: [
                  Expanded(
                    child: _buildTypeCard(
                      context,
                      title: 'دانشجو',
                      subtitle: 'Student',
                      icon: Icons.school_outlined,
                      value: '1',
                      isSelected: _selectedType == '1',
                      onTap: () {
                        setState(() {
                          _selectedType = '1';
                          _selectedCategory = null;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s12),
                  Expanded(
                    child: _buildTypeCard(
                      context,
                      title: 'استاد',
                      subtitle: 'Master',
                      icon: Icons.person_outline,
                      value: '2',
                      isSelected: _selectedType == '2',
                      onTap: () {
                        setState(() {
                          _selectedType = '2';
                          _selectedCategory = null;
                        });
                      },
                    ),
                  ),
                ],
              ).addVerticalSpacing(AppSpacing.s32),

              // Category Selection
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'دسته‌بندی:',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
              ).addVerticalSpacing(AppSpacing.s12),
              state.whenOrNull(
                categoriesLoaded: (categories) => _buildCategorySelector(
                  context,
                  categories,
                  state.maybeWhen(loadingCategories: () => true, orElse: () => false),
                ),
                loadingCategories: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.s32),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ) ?? const SizedBox.shrink(),

              if (_selectedCategory != null)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.s12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: context.colorScheme.primary,
                        size: 18,
                      ),
                      const SizedBox(width: AppSpacing.s8),
                      Expanded(
                        child: Text(
                          _selectedCategory!.name,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: AppSpacing.s40),

              CustomButton(
                child: Text(
                  state.maybeWhen(
                    loading: () => 'در حال ورود...',
                    orElse: () => 'تأیید و ورود',
                  ),
                ),
                onPressed: (_selectedType != null && _selectedCategory != null &&
                        !state.maybeWhen(loading: () => true, orElse: () => false))
                    ? () async {
                        await context.read<VerificationCubit>().completeVerification(
                              type: _selectedType!,
                              categoryId: _selectedCategory!.id,
                            );
                      }
                    : null,
              ).addVerticalSpacing(AppSpacing.s32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressDot(int step, bool isCompleted) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted
            ? context.colorScheme.primary
            : context.colorScheme.outline.withOpacity(0.3),
      ),
      child: Center(
        child: isCompleted
            ? Icon(
                Icons.check,
                color: context.colorScheme.onPrimary,
                size: 20,
              )
            : Text(
                '$step',
                style: TextStyle(
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildTypeCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s12,
          vertical: AppSpacing.s20,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colorScheme.primaryContainer.withOpacity(0.15)
              : context.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(AppRadius.corner12),
          border: Border.all(
            color: isSelected
                ? context.colorScheme.primary
                : context.colorScheme.outline.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isSelected
                    ? context.colorScheme.primary.withOpacity(0.1)
                    : context.colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: isSelected
                    ? context.colorScheme.primary
                    : context.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: AppSpacing.s12),
            Text(
              title,
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.s4),
            Text(
              subtitle,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.5),
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.s8),
                child: Icon(
                  Icons.check_circle,
                  color: context.colorScheme.primary,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelector(
    BuildContext context,
    List<CategoryModel> categories,
    bool isLoading,
  ) {
    return GestureDetector(
      onTap: () => _showCategoryBottomSheet(context, categories),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s16,
          vertical: AppSpacing.s16,
        ),
        decoration: BoxDecoration(
          color: _selectedCategory != null
              ? context.colorScheme.primaryContainer.withOpacity(0.15)
              : context.colorScheme.surfaceContainer,
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
              Icons.category_outlined,
              color: _selectedCategory != null
                  ? context.colorScheme.primary
                  : context.colorScheme.onSurface.withOpacity(0.5),
              size: 20,
            ),
            const SizedBox(width: AppSpacing.s12),
            Expanded(
              child: Text(
                _selectedCategory?.name ?? 'انتخاب دسته‌بندی',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: _selectedCategory != null
                      ? context.colorScheme.onSurface
                      : context.colorScheme.onSurface.withOpacity(0.5),
                  fontWeight: _selectedCategory != null ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: context.colorScheme.onSurface.withOpacity(0.4),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryBottomSheet(
    BuildContext context,
    List<CategoryModel> categories,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CategoryBottomSheet(
        categories: categories,
        selectedCategory: _selectedCategory,
        onCategorySelected: (category) {
          setState(() {
            _selectedCategory = category;
          });
          // Note: Sub-categories loading can be added if needed
          Navigator.pop(context);
        },
        onSearch: (query) {
          context.read<VerificationCubit>().loadCategories(query: query);
        },
      ),
    );
  }

  Widget _buildInviteCodeSection(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _showInviteCode = !_showInviteCode;
              if (!_showInviteCode) {
                _inviteCodeController.clear();
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s16, vertical: AppSpacing.s12),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(AppRadius.corner12),
              border: Border.all(
                color: _showInviteCode
                    ? context.colorScheme.primary
                    : context.colorScheme.outline.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.card_giftcard_outlined,
                      color: _showInviteCode
                          ? context.colorScheme.primary
                          : context.colorScheme.onSurface.withOpacity(0.6),
                      size: 20,
                    ),
                    const SizedBox(width: AppSpacing.s8),
                    Text(
                      'کد دعوت دارم (اختیاری)',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: _showInviteCode
                            ? context.colorScheme.primary
                            : context.colorScheme.onSurface.withOpacity(0.7),
                        fontWeight: _showInviteCode ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                AnimatedRotation(
                  turns: _showInviteCode ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: _showInviteCode
                        ? context.colorScheme.primary
                        : context.colorScheme.onSurface.withOpacity(0.6),
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _showInviteCode ? null : 0,
          child: _showInviteCode
              ? Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.s16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'کد دعوت ۶ رقمی',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurface.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s8),
                      _buildInviteCodeField(context),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildInviteCodeField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppRadius.corner12),
        border: Border.all(
          color: context.colorScheme.outline.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: _inviteCodeController,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 6,
        style: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 2,
        ),
        decoration: InputDecoration(
          hintText: '123456',
          hintStyle: context.textTheme.titleMedium?.copyWith(
            color: context.colorScheme.onSurface.withOpacity(0.4),
            letterSpacing: 2,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s16,
            vertical: AppSpacing.s16,
          ),
          counterText: '',
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          if (value.length > 6) {
            _inviteCodeController.text = value.substring(0, 6);
            _inviteCodeController.selection = TextSelection.fromPosition(
              TextPosition(offset: _inviteCodeController.text.length),
            );
          }
        },
      ),
    );
  }
}

class VerificationField extends StatelessWidget {
  final TextEditingController controller;

  const VerificationField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    var focusedBorderColor = context.colorScheme.outlineVariant;
    var fillColor = context.colorScheme.surfaceContainer;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 22),
      decoration: BoxDecoration(
        color: fillColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(19),
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        controller: controller,
        defaultPinTheme: defaultPinTheme,
        separatorBuilder: (index) => const SizedBox(width: 8),
        hapticFeedbackType: HapticFeedbackType.lightImpact,
        cursor: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 9),
              width: 22,
              height: 1,
              color: focusedBorderColor,
            ),
          ],
        ),
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: focusedBorderColor),
          ),
        ),
        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            color: fillColor,
            borderRadius: BorderRadius.circular(19),
            border: Border.all(color: focusedBorderColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyBorderWith(
          border: Border.all(color: Colors.redAccent),
        ),
        length: 5,
      ),
    );
  }
}

class CategoryBottomSheet extends StatefulWidget {
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;
  final Function(CategoryModel) onCategorySelected;
  final Function(String) onSearch;

  const CategoryBottomSheet({
    super.key,
    required this.categories,
    this.selectedCategory,
    required this.onCategorySelected,
    required this.onSearch,
  });

  @override
  State<CategoryBottomSheet> createState() => _CategoryBottomSheetState();
}

class _CategoryBottomSheetState extends State<CategoryBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<CategoryModel> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    _filteredCategories = widget.categories;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    widget.onSearch(_searchController.text);
    // Filter locally as well
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCategories = widget.categories
          .where((cat) => cat.name.toLowerCase().contains(query))
          .toList();
    });
  }

  void _selectCategory(CategoryModel category) {
    // Select the category (we only show main categories)
    widget.onCategorySelected(category);
  }

  @override
  Widget build(BuildContext context) {
    // Only show main categories (parent_id is null or 0)
    final displayCategories = _filteredCategories;

    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: AppSpacing.s12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: context.colorScheme.outline.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.s20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'انتخاب دسته‌بندی',
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.s16),
                // Search field
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'جستجوی دسته‌بندی...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: context.colorScheme.surfaceContainer,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.s16),
                // Categories list
                if (displayCategories.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.s32),
                    child: Center(
                      child: Text(
                        'دسته‌بندی یافت نشد',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    ),
                  )
                else
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.5,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: displayCategories.length,
                      itemBuilder: (context, index) {
                        final category = displayCategories[index];
                        final isSelected = widget.selectedCategory?.id == category.id;
                        return ListTile(
                          leading: category.image != null
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(category.image!),
                                )
                              : CircleAvatar(
                                  backgroundColor:
                                      context.colorScheme.primaryContainer,
                                  child: Icon(
                                    Icons.category,
                                    color: context.colorScheme.primary,
                                  ),
                                ),
                          title: Text(category.name),
                          trailing: isSelected
                              ? Icon(
                                  Icons.check_circle,
                                  color: context.colorScheme.primary,
                                )
                              : null,
                          selected: isSelected,
                          selectedTileColor:
                              context.colorScheme.primaryContainer.withOpacity(0.3),
                          onTap: () => _selectCategory(category),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
