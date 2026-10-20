import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import '../../../core/helper/app_helper.dart';
import '../../../core/helper/error_helper.dart';
import '../../../core/theme/const.dart';
import '../../../widgets/custom_button.dart';
import '../widgets/header_widget.dart';
import 'logic/password_cubit.dart';

class PasswordPage extends StatefulWidget {
  final String phone;
  final bool? isInvited;
  const PasswordPage({super.key, required this.phone, this.isInvited});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _inviteCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showInviteCode = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _inviteCodeController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      final inviteCode = _inviteCodeController.text.trim();
      // Convert Persian digits to English digits
      final convertedInviteCode = inviteCode.isNotEmpty 
          ? _convertPersianToEnglish(inviteCode) 
          : null;
      
      await context.read<PasswordCubit>().submitPasswordLogin(
        _passwordController.text,
        inviteCode: convertedInviteCode,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasswordCubit, PasswordState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            ErrorHelper.showErrorSnackBar(context, message);
          },
          success: () {
            const HomeRouteData().go(context);
          },
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

        return GestureDetector(
          onTap: () => MyAppHelper().hideKeyboard(context),
          child: Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    authHeaderWidget(context),
                    const SizedBox(height: AppSpacing.s12),
                    Text(
                      l10n.loginToApp,
                      style: context.textTheme.titleLarge,
                    ).addVerticalSpacing(AppSpacing.s12),
                    Text(
                      l10n.enterYourPassword,
                      style: context.textTheme.bodyLarge,
                    ).addVerticalSpacing(AppSpacing.s12),
                    // Phone number display with edit button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.phoneNumberLabel(widget.phone.toString()),
                          style: context.textTheme.bodyLarge,
                        ),
                        const SizedBox(width: AppSpacing.s16),
                        TextButton(
                          onPressed: () {
                            // Navigate back to login page
                            const LoginRoute().go(context);
                          },
                          child: Text(
                            l10n.editPhoneNumber,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ).addVerticalSpacing(AppSpacing.s24),

                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: l10n.password,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(AppRadius.corner8)),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.pleaseEnterPassword;
                        }
                        return null;
                      },
                    ).addVerticalSpacing(AppSpacing.s8),

                    // Invite Code Section - only show if user is not invited
                    if (widget.isInvited != true)
                      _buildInviteCodeSection(context)
                          .addVerticalSpacing(AppSpacing.s16),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        style: const ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.zero),
                        ),
                        onPressed: isLoading ? null : () {
                          VerificationRoute(widget.phone, widget.isInvited, true, false).go(context);
                        },
                        child: Text(l10n.loginWithOtp),
                      ).addVerticalSpacing(AppSpacing.s32),
                    ),

                    CustomButton(
                      onPressed: isLoading ? null : _handleLogin,
                      child: Text(l10n.login),
                    ).addVerticalSpacing(AppSpacing.s32),

                    Text.rich(TextSpan(
                      text: l10n.terms,
                      style: context.textTheme.bodyMedium
                          ?.copyWith(color: context.colorScheme.tertiary),
                      children: [
                        TextSpan(
                          text: l10n.ofUsingApp,
                          style: context.textTheme.bodyMedium,
                        ),
                      ],
                    )).addVerticalSpacing(AppSpacing.s32),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInviteCodeSection(BuildContext context) {
    return Column(
      children: [
        // Toggle button for invite code
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
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16, vertical: AppSpacing.s12),
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
                      l10n.haveInviteCodeOptional,
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
        
        // Invite code input field (animated)
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
                        l10n.sixDigitInviteCode,
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
          counterText: '', // Hide character counter
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          // Auto-format as user types
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
