import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/core/helper/app_helper.dart';
import 'package:academic/core/helper/error_helper.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/widgets/custom_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';
import '../../../gen/assets.gen.dart';
import '../widgets/header_widget.dart';
import 'logic/login_cubit.dart';

/// LoginPage is now a stateful widget to manage input state, form validation, and API integration.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

/// _LoginPageState handles API integration via the LoginCubit and updates the UI accordingly.
class _LoginPageState extends State<LoginPage> {
  // Variable to store the entered phone number in local format.
  String _phoneNumber = '';
  // Controllers for email and password input fields.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // Global key for form validation.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Boolean to store the current input mode. False: phone mode, True: email mode.
  bool _isEmailMode = false;
  // Flag to prevent duplicate button presses
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      // Listener for handling error or success events.
      listener: (context, state) {
        state.maybeWhen(
          error: (message) {
            ErrorHelper.showErrorSnackBar(context, message);
          },
          success: () {
            // On successful login (email/password), navigate to the home page.
            const HomeRouteData().go(context);
          },
          navigateToPassword: (phone, isInvited) {
            // Navigate to the password entry page, passing the phone number and invite status.
            PasswordRoute(phone, isInvited).go(context);
          },
          navigateToVerification: (phone, isInvited, hasPassword, newUser) {
            // Navigate to the verification code page, passing the phone number, invite status, password status, and new user flag.
            VerificationRoute(phone, isInvited, hasPassword, newUser).go(context);
          },
          orElse: () {},
        );
      },
      // No global loading overlay; loading is handled on the button.
      builder: (context, state) {
        return _buildLoginContent(context, state);
      },
    );
  }

  /// Builds the main login UI including header, inputs, and buttons.
  Widget _buildLoginContent(BuildContext context, LoginState state) {
    return GestureDetector(
      onTap: () {
        // Hide keyboard when tapping outside input fields.
        MyAppHelper().hideKeyboard(context);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s32),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                // Header with logo and title.
                authHeaderWidget(context),
                const SizedBox(height: AppSpacing.s12),
                Text(
                  l10n.loginToApp,
                  style: context.textTheme.titleLarge,
                ).addVerticalSpacing(AppSpacing.s12),
                Text(
                  _isEmailMode ? l10n.loginWithEmail : l10n.loginWithPhone,
                  style: context.textTheme.bodyLarge,
                ).addVerticalSpacing(AppSpacing.s24),
                // Display input field based on the current mode.
                _isEmailMode ? _emailInput(context) : _phoneInput(context),
                // Login button calls the cubit's submitPhoneLogin method.
                CustomButton(
                  child: Text(l10n.login),
                  onPressed: _isSubmitting ? null : () async {
                    if (_isSubmitting) return;
                    
                    setState(() {
                      _isSubmitting = true;
                    });
                    
                    try {
                      if (_isEmailMode) {
                        // TODO: Add email validation if needed.
                        await context.read<LoginCubit>().submitEmailLogin(
                          _emailController.text,
                          _passwordController.text,
                        );
                      } else {
                        // Validate the form (only for phone mode) before submitting.
                        if (!(_formKey.currentState?.validate() ?? false)) {
                          return;
                        }
                        await context.read<LoginCubit>().submitPhoneLogin(_phoneNumber);
                      }
                    } finally {
                      if (mounted) {
                        setState(() {
                          _isSubmitting = false;
                        });
                      }
                    }
                    // Await the API call so that CustomButton's loading state is visible.
                  },
                ).addVerticalSpacing(AppSpacing.s32),
                // Divider between login methods.
                Row(
                  children: [
                    Expanded(child: Divider(color: Theme.of(context).colorScheme.outline)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
                      child: Text(
                        l10n.or,
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                    Expanded(child: Divider(color: Theme.of(context).colorScheme.outline)),
                  ],
                ).addVerticalSpacing(AppSpacing.s32),
                // Social login buttons for toggling input type or using Google.
                _socialLoginButtons(context, state),
                // Terms and conditions.
                Text.rich(
                  TextSpan(
                    text: l10n.terms,
                    style: context.textTheme.bodyMedium
                        ?.copyWith(color: Theme.of(context).colorScheme.primary),
                    children: [
                      TextSpan(
                        text: l10n.ofUsingApp,
                        style: context.textTheme.bodyMedium
                            ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                      )
                    ],
                  ),
                ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the phone input field with validation and phone number transformation.
  Widget _phoneInput(BuildContext context) {
    return Column(
      children: [
        InputPhoneField(
          onChanged: (phone) {
            // Convert Persian digits to English digits
            String convertedNumber = _convertPersianToEnglish(phone.completeNumber);
            
            // Transform the phone number from international format to local format.
            String localPhone = convertedNumber;
            if (localPhone.startsWith('+98')) {
              localPhone = '0' + localPhone.substring(3);
            }
            setState(() {
              _phoneNumber = localPhone;
            });
          },
        ).addVerticalSpacing(AppSpacing.s24),
      ],
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

  /// Builds the email input field.
  Widget _emailInput(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: l10n.email,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppRadius.corner8)),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
        ).addVerticalSpacing(AppSpacing.s16),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: l10n.password,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppRadius.corner8)),
            ),
          ),
          obscureText: true,
        ).addVerticalSpacing(AppSpacing.s24),
      ],
    );
  }

  /// Builds social login buttons to toggle between phone and email login or use Google.
  Widget _socialLoginButtons(BuildContext context, LoginState state) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: OutlinedButton.icon(
            style: ButtonStyle(
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(vertical: AppSpacing.s16),
              ),
              foregroundColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.onSurface,
              ),
              side: WidgetStatePropertyAll(
                BorderSide(color: Theme.of(context).colorScheme.outline),
              ),
            ),
            onPressed: () {
              setState(() {
                // Toggle the input mode.
                _isEmailMode = !_isEmailMode;
              });
              // Update the cubit state accordingly.
              if (_isEmailMode) {
                context.read<LoginCubit>().toggleToEmail();
              } else {
                context.read<LoginCubit>().toggleToPhone();
              }
            },
            label: Text(
              _isEmailMode ? l10n.withPhoneNumber : l10n.withEmail,
            ),
            icon: UniversalImageLoader(
              path: _isEmailMode ? Assets.phone : Assets.email,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.s24),
        Expanded(
          flex: 1,
          child: OutlinedButton.icon(
            style: ButtonStyle(
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(vertical: AppSpacing.s16),
              ),
              foregroundColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.onSurface,
              ),
              side: WidgetStatePropertyAll(
                BorderSide(color: Theme.of(context).colorScheme.outline),
              ),
            ),
            onPressed: () {
              // TODO: Implement Google sign-in action.
            },
            label: Text(l10n.withGoogleAccount),
            icon: const UniversalImageLoader(
              path: Assets.google,
            ),
          ),
        ),
      ],
    ).addVerticalSpacing(AppSpacing.s16);
  }
}

/// Widget for phone input using [IntlPhoneField] with built-in validation.
class InputPhoneField extends StatelessWidget {
  final ValueChanged<PhoneNumber>? onChanged;

  const InputPhoneField({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: IntlPhoneField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        invalidNumberMessage: l10n.enteredNumberIncorrect,
        showCursor: true,
        decoration: const InputDecoration(
          labelText: '',
          counter: SizedBox(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppRadius.corner8)),
            borderSide: BorderSide(
              style: BorderStyle.none,
              color: Colors.transparent,
              strokeAlign: 0,
              width: 0,
            ),
          ),
        ),
        languageCode: context.appTranslate?.localeName ?? 'en',
        initialCountryCode: 'IR',
        // Add validation to ensure correct phone format.
        validator: (phone) {
          if (phone == null || phone.number.isEmpty) {
            return l10n.numberNotEntered;
          }
          // For Iranian mobile numbers, the local number (without country code) should be 10 digits.
          if (phone.number.length != 10) {
            return l10n.numberFormatIncorrect;
          }
          return null;
        },
        onChanged: (phone) {
          if (onChanged != null) {
            onChanged!(phone);
          }
        },
        onCountryChanged: (country) {
          print('Country changed to: ' + country.name);
        },
      ),
    );
  }
}

/// Widget for email input.
class InputEmailField extends StatelessWidget {
  final TextEditingController? controller;

  const InputEmailField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: l10n.email,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.corner8)),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}

/// Widget for password input.
class InputPasswordField extends StatelessWidget {
   final TextEditingController? controller;
   const InputPasswordField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
       controller: controller,
       decoration: InputDecoration(
         labelText: l10n.password,
         border: OutlineInputBorder(
           borderRadius: BorderRadius.all(Radius.circular(AppRadius.corner8)),
         ),
       ),
       obscureText: true,
     );
  }
}

/// Widget for inputting a verification code if needed.
class InputCodeField extends StatelessWidget {
  const InputCodeField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: l10n.verificationCode,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.corner8)),
        ),
      ),
    );
  }
}