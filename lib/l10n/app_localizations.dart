import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa')
  ];

  /// No description provided for @exampleText.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get exampleText;

  /// No description provided for @getStartedPageText.
  ///
  /// In en, this message translates to:
  /// **'Here, every click begins a new journey; a journey that takes you into the heart of stories, secrets and the mysterious world of books.'**
  String get getStartedPageText;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Imam Sadiq University'**
  String get appTitle;

  /// No description provided for @shareQuote.
  ///
  /// In en, this message translates to:
  /// **'Share Quote'**
  String get shareQuote;

  /// No description provided for @savingQuote.
  ///
  /// In en, this message translates to:
  /// **'Saving quote...'**
  String get savingQuote;

  /// No description provided for @quoteSaved.
  ///
  /// In en, this message translates to:
  /// **'Quote saved successfully'**
  String get quoteSaved;

  /// No description provided for @errorSavingQuote.
  ///
  /// In en, this message translates to:
  /// **'Error saving quote: {error}'**
  String errorSavingQuote(String error);

  /// No description provided for @pleaseSelectBirthDate.
  ///
  /// In en, this message translates to:
  /// **'Please select birth date'**
  String get pleaseSelectBirthDate;

  /// No description provided for @birthDateMustBeBeforeToday.
  ///
  /// In en, this message translates to:
  /// **'Birth date must be before today'**
  String get birthDateMustBeBeforeToday;

  /// No description provided for @pleaseSelectGender.
  ///
  /// In en, this message translates to:
  /// **'Please select gender'**
  String get pleaseSelectGender;

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter name'**
  String get pleaseEnterName;

  /// No description provided for @pleaseEnterLastName.
  ///
  /// In en, this message translates to:
  /// **'Please enter last name'**
  String get pleaseEnterLastName;

  /// No description provided for @passwordMustBeAtLeast8Chars.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordMustBeAtLeast8Chars;

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedSuccessfully;

  /// No description provided for @errorUpdatingProfile.
  ///
  /// In en, this message translates to:
  /// **'Error updating profile'**
  String get errorUpdatingProfile;

  /// No description provided for @validationError.
  ///
  /// In en, this message translates to:
  /// **'Validation error'**
  String get validationError;

  /// No description provided for @errorSomethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again'**
  String get errorSomethingWentWrong;

  /// No description provided for @errorNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get errorNoInternet;

  /// No description provided for @errorServerTryAgain.
  ///
  /// In en, this message translates to:
  /// **'A server error occurred. Please try again'**
  String get errorServerTryAgain;

  /// No description provided for @errorConnectionTimeout.
  ///
  /// In en, this message translates to:
  /// **'Connection timed out. Please try again'**
  String get errorConnectionTimeout;

  /// No description provided for @errorPleaseLoginAgain.
  ///
  /// In en, this message translates to:
  /// **'Please log in again'**
  String get errorPleaseLoginAgain;

  /// No description provided for @errorUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized access'**
  String get errorUnauthorized;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'The requested information was not found'**
  String get errorNotFound;

  /// No description provided for @errorInvalidInput.
  ///
  /// In en, this message translates to:
  /// **'The entered information is invalid'**
  String get errorInvalidInput;

  /// No description provided for @errorServiceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Service unavailable. Please try again later'**
  String get errorServiceUnavailable;

  /// No description provided for @errorOperationCancelled.
  ///
  /// In en, this message translates to:
  /// **'Operation cancelled'**
  String get errorOperationCancelled;

  /// No description provided for @errorInvalidRequestData.
  ///
  /// In en, this message translates to:
  /// **'The submitted data is invalid. Please try again'**
  String get errorInvalidRequestData;

  /// No description provided for @errorFileTooLarge.
  ///
  /// In en, this message translates to:
  /// **'The file is too large'**
  String get errorFileTooLarge;

  /// No description provided for @errorUnsupportedFileFormat.
  ///
  /// In en, this message translates to:
  /// **'File format is not supported'**
  String get errorUnsupportedFileFormat;

  /// No description provided for @errorTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Please wait a moment'**
  String get errorTooManyRequests;

  /// No description provided for @errorProcessingData.
  ///
  /// In en, this message translates to:
  /// **'Error processing data'**
  String get errorProcessingData;

  /// No description provided for @errorWrongPasswordOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password or phone number'**
  String get errorWrongPasswordOrPhone;

  /// No description provided for @errorUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'No user found with this information'**
  String get errorUserNotFound;

  /// No description provided for @errorInvalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get errorInvalidPhone;

  /// No description provided for @errorWrongVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Incorrect verification code. Please enter the correct code'**
  String get errorWrongVerificationCode;

  /// No description provided for @errorVerificationCodeExpired.
  ///
  /// In en, this message translates to:
  /// **'Verification code has expired. Please request a new code'**
  String get errorVerificationCodeExpired;

  /// No description provided for @errorWrongInput.
  ///
  /// In en, this message translates to:
  /// **'The entered information is incorrect'**
  String get errorWrongInput;

  /// No description provided for @errorAlreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'This information has already been registered'**
  String get errorAlreadyRegistered;

  /// No description provided for @errorInsufficientBalance.
  ///
  /// In en, this message translates to:
  /// **'Insufficient balance'**
  String get errorInsufficientBalance;

  /// No description provided for @errorPaymentProcessing.
  ///
  /// In en, this message translates to:
  /// **'Error processing payment'**
  String get errorPaymentProcessing;

  /// No description provided for @errorServerTryLater.
  ///
  /// In en, this message translates to:
  /// **'A server error occurred. Please try again later'**
  String get errorServerTryLater;

  /// No description provided for @authorBooks.
  ///
  /// In en, this message translates to:
  /// **'Author's books'**
  String get authorBooks;

  /// No description provided for @publisherBooks.
  ///
  /// In en, this message translates to:
  /// **'Publisher's books'**
  String get publisherBooks;

  /// No description provided for @unknownLinkReceived.
  ///
  /// In en, this message translates to:
  /// **'Unknown link received: {link}'**
  String unknownLinkReceived(Object link);

  /// No description provided for @verifyingPayment.
  ///
  /// In en, this message translates to:
  /// **'Verifying payment...'**
  String get verifyingPayment;

  /// No description provided for @paymentVerifiedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Payment verified successfully!'**
  String get paymentVerifiedSuccessfully;

  /// No description provided for @errorVerifyingPaymentWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error verifying payment: {error}'**
  String errorVerifyingPaymentWithMessage(Object error);

  /// No description provided for @paymentFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Payment failed'**
  String get paymentFailedMessage;

  /// No description provided for @paymentCancelledByUser.
  ///
  /// In en, this message translates to:
  /// **'Payment was cancelled by the user'**
  String get paymentCancelledByUser;

  /// No description provided for @invalidBookLink.
  ///
  /// In en, this message translates to:
  /// **'Invalid book link'**
  String get invalidBookLink;

  /// No description provided for @invalidBookId.
  ///
  /// In en, this message translates to:
  /// **'Invalid book ID'**
  String get invalidBookId;

  /// No description provided for @loadingBook.
  ///
  /// In en, this message translates to:
  /// **'Loading book...'**
  String get loadingBook;

  /// No description provided for @errorOpeningBook.
  ///
  /// In en, this message translates to:
  /// **'Error opening book'**
  String get errorOpeningBook;

  /// No description provided for @errorLoadingBookWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error loading book: {error}'**
  String errorLoadingBookWithMessage(Object error);

  /// No description provided for @invalidClippingLink.
  ///
  /// In en, this message translates to:
  /// **'Invalid clipping link'**
  String get invalidClippingLink;

  /// No description provided for @errorOpeningClipping.
  ///
  /// In en, this message translates to:
  /// **'Error opening clipping'**
  String get errorOpeningClipping;

  /// No description provided for @invalidPaymentParameters.
  ///
  /// In en, this message translates to:
  /// **'Invalid payment parameters'**
  String get invalidPaymentParameters;

  /// No description provided for @paymentCompletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Payment completed successfully!'**
  String get paymentCompletedSuccessfully;

  /// No description provided for @paymentNotVerified.
  ///
  /// In en, this message translates to:
  /// **'Payment was not verified'**
  String get paymentNotVerified;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @processingError.
  ///
  /// In en, this message translates to:
  /// **'Processing error'**
  String get processingError;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get unknownError;

  /// No description provided for @errorFetchingProfile.
  ///
  /// In en, this message translates to:
  /// **'Error fetching profile information'**
  String get errorFetchingProfile;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @expiredStatus.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expiredStatus;

  /// No description provided for @daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get daily;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @yearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get yearly;

  /// No description provided for @reserved.
  ///
  /// In en, this message translates to:
  /// **'Reserved'**
  String get reserved;

  /// No description provided for @amountMillionToman.
  ///
  /// In en, this message translates to:
  /// **'{amount}M Toman'**
  String amountMillionToman(Object amount);

  /// No description provided for @amountThousandToman.
  ///
  /// In en, this message translates to:
  /// **'{amount}K Toman'**
  String amountThousandToman(Object amount);

  /// No description provided for @amountToman.
  ///
  /// In en, this message translates to:
  /// **'{amount} Toman'**
  String amountToman(Object amount);

  /// No description provided for @used.
  ///
  /// In en, this message translates to:
  /// **'Used'**
  String get used;

  /// No description provided for @errorSavingNote.
  ///
  /// In en, this message translates to:
  /// **'Error saving note'**
  String get errorSavingNote;

  /// No description provided for @errorFetchingShop.
  ///
  /// In en, this message translates to:
  /// **'Error fetching marketplace information'**
  String get errorFetchingShop;

  /// No description provided for @unexpectedErrorWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error: {error}'**
  String unexpectedErrorWithMessage(Object error);

  /// No description provided for @errorServerReturnedError.
  ///
  /// In en, this message translates to:
  /// **'Server response error: the server returned an error'**
  String get errorServerReturnedError;

  /// No description provided for @errorUploadingProduct.
  ///
  /// In en, this message translates to:
  /// **'Error uploading product'**
  String get errorUploadingProduct;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Imam Sadiq University'**
  String get appName;

  /// No description provided for @loginToApp.
  ///
  /// In en, this message translates to:
  /// **'Log in to Imam Sadiq University'**
  String get loginToApp;

  /// No description provided for @loginWithEmail.
  ///
  /// In en, this message translates to:
  /// **'Log in with your email:'**
  String get loginWithEmail;

  /// No description provided for @loginWithPhone.
  ///
  /// In en, this message translates to:
  /// **'Log in with your mobile number:'**
  String get loginWithPhone;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get terms;

  /// No description provided for @ofUsingApp.
  ///
  /// In en, this message translates to:
  /// **' of using Imam Sadiq University'**
  String get ofUsingApp;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @withPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'With phone number'**
  String get withPhoneNumber;

  /// No description provided for @withEmail.
  ///
  /// In en, this message translates to:
  /// **'With email'**
  String get withEmail;

  /// No description provided for @withGoogleAccount.
  ///
  /// In en, this message translates to:
  /// **'With Google account'**
  String get withGoogleAccount;

  /// No description provided for @enteredNumberIncorrect.
  ///
  /// In en, this message translates to:
  /// **'The entered number is incorrect'**
  String get enteredNumberIncorrect;

  /// No description provided for @numberNotEntered.
  ///
  /// In en, this message translates to:
  /// **'Number has not been entered'**
  String get numberNotEntered;

  /// No description provided for @numberFormatIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Number format is incorrect'**
  String get numberFormatIncorrect;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get verificationCode;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// No description provided for @phoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Number: {phone}'**
  String phoneNumberLabel(Object phone);

  /// No description provided for @editPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Edit phone number'**
  String get editPhoneNumber;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter the password'**
  String get pleaseEnterPassword;

  /// No description provided for @loginWithOtp.
  ///
  /// In en, this message translates to:
  /// **'Log in with one-time password'**
  String get loginWithOtp;

  /// No description provided for @haveInviteCodeOptional.
  ///
  /// In en, this message translates to:
  /// **'I have an invite code (optional)'**
  String get haveInviteCodeOptional;

  /// No description provided for @sixDigitInviteCode.
  ///
  /// In en, this message translates to:
  /// **'6-digit invite code'**
  String get sixDigitInviteCode;

  /// No description provided for @errorInInputData.
  ///
  /// In en, this message translates to:
  /// **'Error in input data'**
  String get errorInInputData;

  /// No description provided for @enterOtpSentToNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter the one-time code sent to the number below:'**
  String get enterOtpSentToNumber;

  /// No description provided for @loginWithPassword.
  ///
  /// In en, this message translates to:
  /// **'Log in with password'**
  String get loginWithPassword;

  /// No description provided for @checking.
  ///
  /// In en, this message translates to:
  /// **'Checking...'**
  String get checking;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @enterFiveDigitCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the 5-digit code'**
  String get enterFiveDigitCode;

  /// No description provided for @completeInformation.
  ///
  /// In en, this message translates to:
  /// **'Complete information'**
  String get completeInformation;

  /// No description provided for @pleaseSelectRoleAndCategory.
  ///
  /// In en, this message translates to:
  /// **'Please select your role and category'**
  String get pleaseSelectRoleAndCategory;

  /// No description provided for @yourRole.
  ///
  /// In en, this message translates to:
  /// **'Your role:'**
  String get yourRole;

  /// No description provided for @student.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get student;

  /// No description provided for @professor.
  ///
  /// In en, this message translates to:
  /// **'Professor'**
  String get professor;

  /// No description provided for @categoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category:'**
  String get categoryLabel;

  /// No description provided for @loggingIn.
  ///
  /// In en, this message translates to:
  /// **'Logging in...'**
  String get loggingIn;

  /// No description provided for @confirmAndLogin.
  ///
  /// In en, this message translates to:
  /// **'Confirm and log in'**
  String get confirmAndLogin;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select category'**
  String get selectCategory;

  /// No description provided for @searchCategory.
  ///
  /// In en, this message translates to:
  /// **'Search categories...'**
  String get searchCategory;

  /// No description provided for @categoryNotFound.
  ///
  /// In en, this message translates to:
  /// **'Category not found'**
  String get categoryNotFound;

  /// No description provided for @author.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get author;

  /// No description provided for @searchAuthorTranslatorNarrator.
  ///
  /// In en, this message translates to:
  /// **'Search author, translator or narrator'**
  String get searchAuthorTranslatorNarrator;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @clearFilter.
  ///
  /// In en, this message translates to:
  /// **'Clear filter'**
  String get clearFilter;

  /// No description provided for @categoriesShort.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categoriesShort;

  /// No description provided for @searchInApp.
  ///
  /// In en, this message translates to:
  /// **'Search in Imam Sadiq University'**
  String get searchInApp;

  /// No description provided for @mostPopularAudioBookCategories.
  ///
  /// In en, this message translates to:
  /// **'Most popular audiobook categories'**
  String get mostPopularAudioBookCategories;

  /// No description provided for @sizeInMegabytes.
  ///
  /// In en, this message translates to:
  /// **'{size} MB'**
  String sizeInMegabytes(Object size);

  /// No description provided for @identifier.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get identifier;

  /// No description provided for @format.
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get format;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @listSeparator.
  ///
  /// In en, this message translates to:
  /// **','**
  String get listSeparator;

  /// No description provided for @translator.
  ///
  /// In en, this message translates to:
  /// **'Translator'**
  String get translator;

  /// No description provided for @narrator.
  ///
  /// In en, this message translates to:
  /// **'Narrator'**
  String get narrator;

  /// No description provided for @publisher.
  ///
  /// In en, this message translates to:
  /// **'Publisher'**
  String get publisher;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @persian.
  ///
  /// In en, this message translates to:
  /// **'Persian'**
  String get persian;

  /// No description provided for @publishDate.
  ///
  /// In en, this message translates to:
  /// **'Publication date'**
  String get publishDate;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @readAndDownloadFile.
  ///
  /// In en, this message translates to:
  /// **'Read and download file'**
  String get readAndDownloadFile;

  /// No description provided for @inTheAppName.
  ///
  /// In en, this message translates to:
  /// **'in the Imam Sadiq University app'**
  String get inTheAppName;

  /// No description provided for @searchPublisher.
  ///
  /// In en, this message translates to:
  /// **'Search publishers'**
  String get searchPublisher;

  /// No description provided for @clippingFromBook.
  ///
  /// In en, this message translates to:
  /// **'A clipping from the book {bookName}'**
  String clippingFromBook(Object bookName);

  /// No description provided for @errorSharingWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error sharing: {error}'**
  String errorSharingWithMessage(Object error);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @mostPopular.
  ///
  /// In en, this message translates to:
  /// **'Most popular'**
  String get mostPopular;

  /// No description provided for @hashtagSuccess.
  ///
  /// In en, this message translates to:
  /// **'#Success'**
  String get hashtagSuccess;

  /// No description provided for @hashtagPsychology.
  ///
  /// In en, this message translates to:
  /// **'#Psychology'**
  String get hashtagPsychology;

  /// No description provided for @bookTour.
  ///
  /// In en, this message translates to:
  /// **'Book tour'**
  String get bookTour;

  /// No description provided for @noClippings.
  ///
  /// In en, this message translates to:
  /// **'No clippings'**
  String get noClippings;

  /// No description provided for @noClippingsToShow.
  ///
  /// In en, this message translates to:
  /// **'There are currently no clippings to show'**
  String get noClippingsToShow;

  /// No description provided for @newLabel.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newLabel;

  /// No description provided for @bookWithName.
  ///
  /// In en, this message translates to:
  /// **'Book {bookName}'**
  String bookWithName(Object bookName);

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @less.
  ///
  /// In en, this message translates to:
  /// **'Less'**
  String get less;

  /// No description provided for @bookmarked.
  ///
  /// In en, this message translates to:
  /// **'Bookmarked'**
  String get bookmarked;

  /// No description provided for @errorWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorWithMessage(Object error);

  /// No description provided for @noBookmarkedBooks.
  ///
  /// In en, this message translates to:
  /// **'No bookmarked books!'**
  String get noBookmarkedBooks;

  /// No description provided for @noBookmarkedBooksYet.
  ///
  /// In en, this message translates to:
  /// **'You haven't bookmarked any books yet'**
  String get noBookmarkedBooksYet;

  /// No description provided for @untitled.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get untitled;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @marketplace.
  ///
  /// In en, this message translates to:
  /// **'Marketplace'**
  String get marketplace;

  /// No description provided for @categoriesTab.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categoriesTab;

  /// No description provided for @myBooks.
  ///
  /// In en, this message translates to:
  /// **'My books'**
  String get myBooks;

  /// No description provided for @buySubscription.
  ///
  /// In en, this message translates to:
  /// **'Buy subscription'**
  String get buySubscription;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'Frequently asked questions'**
  String get faq;

  /// No description provided for @faqPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Answers to frequently asked questions go here...'**
  String get faqPlaceholder;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and conditions'**
  String get termsAndConditions;

  /// No description provided for @subscriptionTermsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Subscription terms and conditions go here...'**
  String get subscriptionTermsPlaceholder;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get termsOfUse;

  /// No description provided for @subscriptionTermsOfUsePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Subscription terms of use go here...'**
  String get subscriptionTermsOfUsePlaceholder;

  /// No description provided for @errorProcessingPaymentWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error processing payment: {error}'**
  String errorProcessingPaymentWithMessage(Object error);

  /// No description provided for @toman.
  ///
  /// In en, this message translates to:
  /// **'Toman'**
  String get toman;

  /// No description provided for @daysCount.
  ///
  /// In en, this message translates to:
  /// **'{days} days'**
  String daysCount(Object days);

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Shopping cart'**
  String get cart;

  /// No description provided for @paymentGatewayOpened.
  ///
  /// In en, this message translates to:
  /// **'Payment gateway opened successfully'**
  String get paymentGatewayOpened;

  /// No description provided for @cartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your shopping cart is empty'**
  String get cartEmpty;

  /// No description provided for @goHomeToBuyBooks.
  ///
  /// In en, this message translates to:
  /// **'Go to the home page to buy books'**
  String get goHomeToBuyBooks;

  /// No description provided for @goToHome.
  ///
  /// In en, this message translates to:
  /// **'Go to home page'**
  String get goToHome;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get paymentMethod;

  /// No description provided for @onlinePaymentGateway.
  ///
  /// In en, this message translates to:
  /// **'Online payment gateway'**
  String get onlinePaymentGateway;

  /// No description provided for @payWithShetabCards.
  ///
  /// In en, this message translates to:
  /// **'Pay with all Shetab member cards'**
  String get payWithShetabCards;

  /// No description provided for @invoice.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get invoice;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @yourSavings.
  ///
  /// In en, this message translates to:
  /// **'Your savings on this purchase'**
  String get yourSavings;

  /// No description provided for @payableAmount.
  ///
  /// In en, this message translates to:
  /// **'Payable amount'**
  String get payableAmount;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// No description provided for @payAmountToman.
  ///
  /// In en, this message translates to:
  /// **'Pay - {amount} Toman'**
  String payAmountToman(Object amount);

  /// No description provided for @audioBook.
  ///
  /// In en, this message translates to:
  /// **'Audiobook'**
  String get audioBook;

  /// No description provided for @textBook.
  ///
  /// In en, this message translates to:
  /// **'Text book'**
  String get textBook;

  /// No description provided for @subjectWithValue.
  ///
  /// In en, this message translates to:
  /// **'Subject: {subject}'**
  String subjectWithValue(Object subject);

  /// No description provided for @useDiscountCode.
  ///
  /// In en, this message translates to:
  /// **'Use discount code'**
  String get useDiscountCode;

  /// No description provided for @enterDiscountCode.
  ///
  /// In en, this message translates to:
  /// **'Enter your discount code'**
  String get enterDiscountCode;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @discountCodeApplied.
  ///
  /// In en, this message translates to:
  /// **'Discount code applied successfully'**
  String get discountCodeApplied;

  /// No description provided for @filterLabel.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filterLabel;

  /// No description provided for @bestSelling.
  ///
  /// In en, this message translates to:
  /// **'Best selling'**
  String get bestSelling;

  /// No description provided for @noProductsFound.
  ///
  /// In en, this message translates to:
  /// **'No products found.'**
  String get noProductsFound;

  /// No description provided for @authorWithValue.
  ///
  /// In en, this message translates to:
  /// **'Author: {author}'**
  String authorWithValue(Object author);

  /// No description provided for @translatorWithValue.
  ///
  /// In en, this message translates to:
  /// **'Translator: {translator}'**
  String translatorWithValue(Object translator);

  /// No description provided for @narratorWithValue.
  ///
  /// In en, this message translates to:
  /// **'Narrator: {narrator}'**
  String narratorWithValue(Object narrator);

  /// No description provided for @speaker.
  ///
  /// In en, this message translates to:
  /// **'Narrator'**
  String get speaker;

  /// No description provided for @publisherWithValue.
  ///
  /// In en, this message translates to:
  /// **'Publisher: {publisher}'**
  String publisherWithValue(Object publisher);

  /// No description provided for @applyFilter.
  ///
  /// In en, this message translates to:
  /// **'Apply filter'**
  String get applyFilter;

  /// No description provided for @selectAuthor.
  ///
  /// In en, this message translates to:
  /// **'Select author'**
  String get selectAuthor;

  /// No description provided for @searchAuthors.
  ///
  /// In en, this message translates to:
  /// **'Search authors...'**
  String get searchAuthors;

  /// No description provided for @noAuthorFound.
  ///
  /// In en, this message translates to:
  /// **'No author found.'**
  String get noAuthorFound;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @searchInWithValue.
  ///
  /// In en, this message translates to:
  /// **'Search in {title}...'**
  String searchInWithValue(Object title);

  /// No description provided for @noneFoundWithValue.
  ///
  /// In en, this message translates to:
  /// **'No {title} found.'**
  String noneFoundWithValue(Object title);

  /// No description provided for @chapterDetails.
  ///
  /// In en, this message translates to:
  /// **'Chapter details'**
  String get chapterDetails;

  /// No description provided for @notesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} notes'**
  String notesCount(Object count);

  /// No description provided for @noNotes.
  ///
  /// In en, this message translates to:
  /// **'No notes'**
  String get noNotes;

  /// No description provided for @noNotesInChapter.
  ///
  /// In en, this message translates to:
  /// **'No notes have been added to this chapter yet'**
  String get noNotesInChapter;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get readMore;

  /// No description provided for @analysis.
  ///
  /// In en, this message translates to:
  /// **'Analysis'**
  String get analysis;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @editNote.
  ///
  /// In en, this message translates to:
  /// **'Edit note'**
  String get editNote;

  /// No description provided for @yourNote.
  ///
  /// In en, this message translates to:
  /// **'Your note'**
  String get yourNote;

  /// No description provided for @noteAboutClippingHint.
  ///
  /// In en, this message translates to:
  /// **'A note or comment about this clipping...'**
  String get noteAboutClippingHint;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @deleteNote.
  ///
  /// In en, this message translates to:
  /// **'Delete note'**
  String get deleteNote;

  /// No description provided for @confirmDeleteNote.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this note?'**
  String get confirmDeleteNote;

  /// No description provided for @chapterNotFound.
  ///
  /// In en, this message translates to:
  /// **'The chapter was not found. It may have been deleted or you may not have access to it.'**
  String get chapterNotFound;

  /// No description provided for @errorLoadingDetailsWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error loading details: {error}'**
  String errorLoadingDetailsWithMessage(Object error);

  /// No description provided for @errorUpdatingNoteWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error updating note: {error}'**
  String errorUpdatingNoteWithMessage(Object error);

  /// No description provided for @errorDeletingNoteWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error deleting note: {error}'**
  String errorDeletingNoteWithMessage(Object error);

  /// No description provided for @errorSelectingImageWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error selecting image: {error}'**
  String errorSelectingImageWithMessage(Object error);

  /// No description provided for @pleaseSelectCategoryFormal.
  ///
  /// In en, this message translates to:
  /// **'Please select a category'**
  String get pleaseSelectCategoryFormal;

  /// No description provided for @createNewChapter.
  ///
  /// In en, this message translates to:
  /// **'Create new chapter'**
  String get createNewChapter;

  /// No description provided for @editChapter.
  ///
  /// In en, this message translates to:
  /// **'Edit chapter'**
  String get editChapter;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @chapterTitle.
  ///
  /// In en, this message translates to:
  /// **'Chapter title'**
  String get chapterTitle;

  /// No description provided for @chapterTitleExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. Artificial intelligence'**
  String get chapterTitleExample;

  /// No description provided for @titleRequired.
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get titleRequired;

  /// No description provided for @titleMinLength.
  ///
  /// In en, this message translates to:
  /// **'Title must be at least 3 characters'**
  String get titleMinLength;

  /// No description provided for @descriptionOptional.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get descriptionOptional;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @chapterDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'A short description of this chapter'**
  String get chapterDescriptionHint;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @imageOptional.
  ///
  /// In en, this message translates to:
  /// **'Image (optional)'**
  String get imageOptional;

  /// No description provided for @changeImage.
  ///
  /// In en, this message translates to:
  /// **'Change image'**
  String get changeImage;

  /// No description provided for @selectImage.
  ///
  /// In en, this message translates to:
  /// **'Select image'**
  String get selectImage;

  /// No description provided for @enterApp.
  ///
  /// In en, this message translates to:
  /// **'Enter the app'**
  String get enterApp;

  /// No description provided for @giftCard.
  ///
  /// In en, this message translates to:
  /// **'Gift card'**
  String get giftCard;

  /// No description provided for @confirmAndPay.
  ///
  /// In en, this message translates to:
  /// **'Confirm and pay'**
  String get confirmAndPay;

  /// No description provided for @recipientPhoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Recipient mobile number*'**
  String get recipientPhoneRequired;

  /// No description provided for @amountInRial.
  ///
  /// In en, this message translates to:
  /// **'Amount in Rial'**
  String get amountInRial;

  /// No description provided for @sendGiftCardToOthers.
  ///
  /// In en, this message translates to:
  /// **'Send a gift card to others'**
  String get sendGiftCardToOthers;

  /// No description provided for @pleaseEnterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter the phone number'**
  String get pleaseEnterPhoneNumber;

  /// No description provided for @phoneMustStartWith09.
  ///
  /// In en, this message translates to:
  /// **'Number must start with 09'**
  String get phoneMustStartWith09;

  /// No description provided for @phoneNumberInvalid.
  ///
  /// In en, this message translates to:
  /// **'The entered number is not valid'**
  String get phoneNumberInvalid;

  /// No description provided for @rialArabic.
  ///
  /// In en, this message translates to:
  /// **'Rial'**
  String get rialArabic;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get mobileNumber;

  /// No description provided for @paymentAmount.
  ///
  /// In en, this message translates to:
  /// **'Payment amount'**
  String get paymentAmount;

  /// No description provided for @amountRial.
  ///
  /// In en, this message translates to:
  /// **'{amount} Rial'**
  String amountRial(Object amount);

  /// No description provided for @giftCardSentToNumber.
  ///
  /// In en, this message translates to:
  /// **'Your gift card was successfully\n sent to {phone}! 🤩'**
  String giftCardSentToNumber(Object phone);

  /// No description provided for @giftSentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Gift sent successfully!'**
  String get giftSentSuccessfully;

  /// No description provided for @giftToOthers.
  ///
  /// In en, this message translates to:
  /// **'Gift to others'**
  String get giftToOthers;

  /// No description provided for @bookName.
  ///
  /// In en, this message translates to:
  /// **'Book name'**
  String get bookName;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @classification.
  ///
  /// In en, this message translates to:
  /// **'Classification'**
  String get classification;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @successful.
  ///
  /// In en, this message translates to:
  /// **'Successful'**
  String get successful;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @bookByAuthorPublisher.
  ///
  /// In en, this message translates to:
  /// **'The book {bookName} by {author}, {publisher} Publications'**
  String bookByAuthorPublisher(Object bookName, Object author, Object publisher);

  /// No description provided for @bookClassificationWithValue.
  ///
  /// In en, this message translates to:
  /// **'Book classification: {classification}'**
  String bookClassificationWithValue(Object classification);

  /// No description provided for @tomanWithSpace.
  ///
  /// In en, this message translates to:
  /// **' Toman'**
  String get tomanWithSpace;

  /// No description provided for @friendMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Your friend's mobile number'**
  String get friendMobileNumber;

  /// No description provided for @noContent.
  ///
  /// In en, this message translates to:
  /// **'No content'**
  String get noContent;

  /// No description provided for @noContentToShow.
  ///
  /// In en, this message translates to:
  /// **'There is currently no content to show'**
  String get noContentToShow;

  /// No description provided for @currentlyReading.
  ///
  /// In en, this message translates to:
  /// **'Currently reading'**
  String get currentlyReading;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @newestProducts.
  ///
  /// In en, this message translates to:
  /// **'Newest products'**
  String get newestProducts;

  /// No description provided for @featuredProducts.
  ///
  /// In en, this message translates to:
  /// **'Featured products'**
  String get featuredProducts;

  /// No description provided for @suggestedProducts.
  ///
  /// In en, this message translates to:
  /// **'Suggested products'**
  String get suggestedProducts;

  /// No description provided for @weeklySuggestion.
  ///
  /// In en, this message translates to:
  /// **'Suggestion of the week'**
  String get weeklySuggestion;

  /// No description provided for @newTextBooks.
  ///
  /// In en, this message translates to:
  /// **'New text books'**
  String get newTextBooks;

  /// No description provided for @newAudioBooks.
  ///
  /// In en, this message translates to:
  /// **'New audiobooks'**
  String get newAudioBooks;

  /// No description provided for @pdfNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'PDF file is not available'**
  String get pdfNotAvailable;

  /// No description provided for @errorFetchingHome.
  ///
  /// In en, this message translates to:
  /// **'Error fetching home page information'**
  String get errorFetchingHome;

  /// No description provided for @introLoremIpsum.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'**
  String get introLoremIpsum;

  /// No description provided for @nextStep.
  ///
  /// In en, this message translates to:
  /// **'Next step'**
  String get nextStep;

  /// No description provided for @invited.
  ///
  /// In en, this message translates to:
  /// **'Invited'**
  String get invited;

  /// No description provided for @inviteFriends.
  ///
  /// In en, this message translates to:
  /// **'Invite friends'**
  String get inviteFriends;

  /// No description provided for @invite.
  ///
  /// In en, this message translates to:
  /// **'Invite'**
  String get invite;

  /// No description provided for @rewards.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewards;

  /// No description provided for @inviteCodeUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Invite code is not available'**
  String get inviteCodeUnavailable;

  /// No description provided for @invitedFriendsList.
  ///
  /// In en, this message translates to:
  /// **'List of invited friends'**
  String get invitedFriendsList;

  /// No description provided for @totalPeopleCount.
  ///
  /// In en, this message translates to:
  /// **'Total: {count} people'**
  String totalPeopleCount(Object count);

  /// No description provided for @noInvitations.
  ///
  /// In en, this message translates to:
  /// **'No invitations'**
  String get noInvitations;

  /// No description provided for @noFriendsInvitedYet.
  ///
  /// In en, this message translates to:
  /// **'You haven't invited any friends yet'**
  String get noFriendsInvitedYet;

  /// No description provided for @noRewards.
  ///
  /// In en, this message translates to:
  /// **'No rewards'**
  String get noRewards;

  /// No description provided for @noRewardsToShow.
  ///
  /// In en, this message translates to:
  /// **'There are no rewards to show yet'**
  String get noRewardsToShow;

  /// No description provided for @inviteFriendsReadFree.
  ///
  /// In en, this message translates to:
  /// **'📚 Invite your friends and\n read free for a month!'**
  String get inviteFriendsReadFree;

  /// No description provided for @inviteFriendsDescription.
  ///
  /// In en, this message translates to:
  /// **'Invite your friends to the book reader app and you and your friend will each get a free one-month subscription! Just send them your invite code so they can enter the fascinating world of books.'**
  String get inviteFriendsDescription;

  /// No description provided for @inviteCodeCopied.
  ///
  /// In en, this message translates to:
  /// **'Invite code copied!'**
  String get inviteCodeCopied;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @noFriendInvitedYet.
  ///
  /// In en, this message translates to:
  /// **'You haven't invited a friend yet'**
  String get noFriendInvitedYet;

  /// No description provided for @inviteFriendsBothGetFreeMonth.
  ///
  /// In en, this message translates to:
  /// **'By inviting your friends, both of you will receive a free one-month subscription!'**
  String get inviteFriendsBothGetFreeMonth;

  /// No description provided for @shareYourInviteCode.
  ///
  /// In en, this message translates to:
  /// **'Share your invite code'**
  String get shareYourInviteCode;

  /// No description provided for @invitationDateWithValue.
  ///
  /// In en, this message translates to:
  /// **'Invitation date: {date}'**
  String invitationDateWithValue(Object date);

  /// No description provided for @noRewardsReceivedYet.
  ///
  /// In en, this message translates to:
  /// **'You haven't received any rewards yet'**
  String get noRewardsReceivedYet;

  /// No description provided for @inviteFriendsGetRewards.
  ///
  /// In en, this message translates to:
  /// **'By inviting your friends and using the invite code, you will receive valuable rewards!'**
  String get inviteFriendsGetRewards;

  /// No description provided for @receivedRewards.
  ///
  /// In en, this message translates to:
  /// **'Received rewards'**
  String get receivedRewards;

  /// No description provided for @totalRewardsCount.
  ///
  /// In en, this message translates to:
  /// **'Total: {count} rewards'**
  String totalRewardsCount(Object count);

  /// No description provided for @trackingCodeWithValue.
  ///
  /// In en, this message translates to:
  /// **'Tracking code: {code}'**
  String trackingCodeWithValue(Object code);

  /// No description provided for @receivedDateWithValue.
  ///
  /// In en, this message translates to:
  /// **'Received date: {date}'**
  String receivedDateWithValue(Object date);

  /// No description provided for @errorLoadingShelf.
  ///
  /// In en, this message translates to:
  /// **'Error loading shelf'**
  String get errorLoadingShelf;

  /// No description provided for @shelfIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'This shelf is empty'**
  String get shelfIsEmpty;

  /// No description provided for @addFavoriteBooksToShelf.
  ///
  /// In en, this message translates to:
  /// **'Add your favorite books to this shelf'**
  String get addFavoriteBooksToShelf;

  /// No description provided for @shelfBooks.
  ///
  /// In en, this message translates to:
  /// **'Shelf books'**
  String get shelfBooks;

  /// No description provided for @booksCount.
  ///
  /// In en, this message translates to:
  /// **'{count} books'**
  String booksCount(Object count);

  /// No description provided for @audio.
  ///
  /// In en, this message translates to:
  /// **'Audio'**
  String get audio;

  /// No description provided for @text.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get text;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @bookClippingComments.
  ///
  /// In en, this message translates to:
  /// **'Book clipping comments'**
  String get bookClippingComments;

  /// No description provided for @errorLoadingComments.
  ///
  /// In en, this message translates to:
  /// **'Error loading comments'**
  String get errorLoadingComments;

  /// No description provided for @noCommentsYet.
  ///
  /// In en, this message translates to:
  /// **'No comments yet'**
  String get noCommentsYet;

  /// No description provided for @beFirstToComment.
  ///
  /// In en, this message translates to:
  /// **'Be the first to comment'**
  String get beFirstToComment;

  /// No description provided for @noBookFound.
  ///
  /// In en, this message translates to:
  /// **'No book found!'**
  String get noBookFound;

  /// No description provided for @noBooksInLibraryYet.
  ///
  /// In en, this message translates to:
  /// **'No books have been added to your library yet'**
  String get noBooksInLibraryYet;

  /// No description provided for @myShelves.
  ///
  /// In en, this message translates to:
  /// **'My shelves'**
  String get myShelves;

  /// No description provided for @appShelves.
  ///
  /// In en, this message translates to:
  /// **'Imam Sadiq University shelves'**
  String get appShelves;

  /// No description provided for @noTextBooksInLibrary.
  ///
  /// In en, this message translates to:
  /// **'There are no text books in your library'**
  String get noTextBooksInLibrary;

  /// No description provided for @noAudioBooksInLibrary.
  ///
  /// In en, this message translates to:
  /// **'There are no audiobooks in your library'**
  String get noAudioBooksInLibrary;

  /// No description provided for @noBooksFound.
  ///
  /// In en, this message translates to:
  /// **'No books found'**
  String get noBooksFound;

  /// No description provided for @electronic.
  ///
  /// In en, this message translates to:
  /// **'Electronic'**
  String get electronic;

  /// No description provided for @errorLoadingChaptersWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error loading chapters: {error}'**
  String errorLoadingChaptersWithMessage(Object error);

  /// No description provided for @errorCreatingChapterWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error creating chapter: {error}'**
  String errorCreatingChapterWithMessage(Object error);

  /// No description provided for @errorUpdatingChapterWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error updating chapter: {error}'**
  String errorUpdatingChapterWithMessage(Object error);

  /// No description provided for @errorDeletingChapterWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error deleting chapter: {error}'**
  String errorDeletingChapterWithMessage(Object error);

  /// No description provided for @myNoteCards.
  ///
  /// In en, this message translates to:
  /// **'My note cards'**
  String get myNoteCards;

  /// No description provided for @noChapters.
  ///
  /// In en, this message translates to:
  /// **'No chapters'**
  String get noChapters;

  /// No description provided for @noChaptersCreatedYet.
  ///
  /// In en, this message translates to:
  /// **'You haven't created any chapters yet'**
  String get noChaptersCreatedYet;

  /// No description provided for @deleteChapter.
  ///
  /// In en, this message translates to:
  /// **'Delete chapter'**
  String get deleteChapter;

  /// No description provided for @confirmDeleteItem.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete "{title}"?'**
  String confirmDeleteItem(Object title);

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String daysAgo(Object days);

  /// No description provided for @myClippings.
  ///
  /// In en, this message translates to:
  /// **'My clippings'**
  String get myClippings;

  /// No description provided for @noClippingsSavedYet.
  ///
  /// In en, this message translates to:
  /// **'You haven't saved any clippings from books yet'**
  String get noClippingsSavedYet;

  /// No description provided for @likedByUser.
  ///
  /// In en, this message translates to:
  /// **'  liked by user'**
  String get likedByUser;

  /// No description provided for @commentSubmittedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your comment was submitted successfully'**
  String get commentSubmittedSuccessfully;

  /// No description provided for @myComments.
  ///
  /// In en, this message translates to:
  /// **'My comments'**
  String get myComments;

  /// No description provided for @yourComment.
  ///
  /// In en, this message translates to:
  /// **'Your comment'**
  String get yourComment;

  /// No description provided for @pleaseEnterComment.
  ///
  /// In en, this message translates to:
  /// **'Please enter your comment'**
  String get pleaseEnterComment;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @sending.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get sending;

  /// No description provided for @submitComment.
  ///
  /// In en, this message translates to:
  /// **'Submit comment'**
  String get submitComment;

  /// No description provided for @howWasYourReadingExperience.
  ///
  /// In en, this message translates to:
  /// **'How was your experience\n reading this book?'**
  String get howWasYourReadingExperience;

  /// No description provided for @helpOthersReadBetter.
  ///
  /// In en, this message translates to:
  /// **'Help others read better'**
  String get helpOthersReadBetter;

  /// No description provided for @doYouRecommendBook.
  ///
  /// In en, this message translates to:
  /// **'Would you recommend this book to others?'**
  String get doYouRecommendBook;

  /// No description provided for @notSure.
  ///
  /// In en, this message translates to:
  /// **'Not sure'**
  String get notSure;

  /// No description provided for @pleaseEnterRating.
  ///
  /// In en, this message translates to:
  /// **'Please enter your rating'**
  String get pleaseEnterRating;

  /// No description provided for @iRecommend.
  ///
  /// In en, this message translates to:
  /// **'I recommend it'**
  String get iRecommend;

  /// No description provided for @iDontRecommend.
  ///
  /// In en, this message translates to:
  /// **'I don't recommend it'**
  String get iDontRecommend;

  /// No description provided for @noCommentSubmitted.
  ///
  /// In en, this message translates to:
  /// **'No comments submitted'**
  String get noCommentSubmitted;

  /// No description provided for @noCommentsForBooksYet.
  ///
  /// In en, this message translates to:
  /// **'You haven't commented on any books yet'**
  String get noCommentsForBooksYet;

  /// No description provided for @unknownBookName.
  ///
  /// In en, this message translates to:
  /// **'Unknown book name'**
  String get unknownBookName;

  /// No description provided for @myPurchases.
  ///
  /// In en, this message translates to:
  /// **'My purchases'**
  String get myPurchases;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @noPurchases.
  ///
  /// In en, this message translates to:
  /// **'No purchases'**
  String get noPurchases;

  /// No description provided for @trackingCode.
  ///
  /// In en, this message translates to:
  /// **'Tracking code'**
  String get trackingCode;

  /// No description provided for @purchaseDate.
  ///
  /// In en, this message translates to:
  /// **'Purchase date'**
  String get purchaseDate;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @myShelvesTitle.
  ///
  /// In en, this message translates to:
  /// **'My shelves'**
  String get myShelvesTitle;

  /// No description provided for @createNewShelf.
  ///
  /// In en, this message translates to:
  /// **'Create new shelf'**
  String get createNewShelf;

  /// No description provided for @errorLoadingShelves.
  ///
  /// In en, this message translates to:
  /// **'Error loading shelves'**
  String get errorLoadingShelves;

  /// No description provided for @noShelvesCreatedYet.
  ///
  /// In en, this message translates to:
  /// **'You haven't created a shelf yet'**
  String get noShelvesCreatedYet;

  /// No description provided for @createShelfFirstToAddBooks.
  ///
  /// In en, this message translates to:
  /// **'To add books to a shelf, first create a new shelf'**
  String get createShelfFirstToAddBooks;

  /// No description provided for @createShelf.
  ///
  /// In en, this message translates to:
  /// **'Create shelf'**
  String get createShelf;

  /// No description provided for @writeShelfName.
  ///
  /// In en, this message translates to:
  /// **'Write the shelf name'**
  String get writeShelfName;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @deleteShelf.
  ///
  /// In en, this message translates to:
  /// **'Delete shelf'**
  String get deleteShelf;

  /// No description provided for @confirmDeleteShelf.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the shelf "{name}"?'**
  String confirmDeleteShelf(Object name);

  /// No description provided for @latestBooks.
  ///
  /// In en, this message translates to:
  /// **'Latest books:'**
  String get latestBooks;

  /// No description provided for @moreBooksCount.
  ///
  /// In en, this message translates to:
  /// **'+{count} more books'**
  String moreBooksCount(Object count);

  /// No description provided for @shelfEmpty.
  ///
  /// In en, this message translates to:
  /// **'Shelf is empty'**
  String get shelfEmpty;

  /// No description provided for @subscriptionHistory.
  ///
  /// In en, this message translates to:
  /// **'Subscription history'**
  String get subscriptionHistory;

  /// No description provided for @activeSubscription.
  ///
  /// In en, this message translates to:
  /// **'Active subscription'**
  String get activeSubscription;

  /// No description provided for @appSubscription.
  ///
  /// In en, this message translates to:
  /// **'Imam Sadiq University subscription'**
  String get appSubscription;

  /// No description provided for @subscriptionDescription.
  ///
  /// In en, this message translates to:
  /// **'By buying a book reader subscription, get access to a world of e-books and audiobooks. A unique experience for book lovers, anywhere and anytime!'**
  String get subscriptionDescription;

  /// No description provided for @activeSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Active subscriptions'**
  String get activeSubscriptions;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start date:'**
  String get startDate;

  /// No description provided for @expiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry date:'**
  String get expiryDate;

  /// No description provided for @buyPremiumSubscription.
  ///
  /// In en, this message translates to:
  /// **'Buy premium subscription'**
  String get buyPremiumSubscription;

  /// No description provided for @expiredSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Expired subscriptions'**
  String get expiredSubscriptions;

  /// No description provided for @noExpiredSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'You have no expired subscriptions'**
  String get noExpiredSubscriptions;

  /// No description provided for @openLinkInBrowser.
  ///
  /// In en, this message translates to:
  /// **'Please open this link in your browser: {url}'**
  String openLinkInBrowser(Object url);

  /// No description provided for @paymentVerificationFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment verification failed. Please try again.'**
  String get paymentVerificationFailed;

  /// No description provided for @paymentType.
  ///
  /// In en, this message translates to:
  /// **'Payment type'**
  String get paymentType;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error message'**
  String get errorMessage;

  /// No description provided for @paymentSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Payment successful'**
  String get paymentSuccessful;

  /// No description provided for @paymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment failed'**
  String get paymentFailed;

  /// No description provided for @paymentExpired.
  ///
  /// In en, this message translates to:
  /// **'Payment time expired'**
  String get paymentExpired;

  /// No description provided for @paymentCancelled.
  ///
  /// In en, this message translates to:
  /// **'Payment cancelled'**
  String get paymentCancelled;

  /// No description provided for @paymentError.
  ///
  /// In en, this message translates to:
  /// **'Payment error'**
  String get paymentError;

  /// No description provided for @paymentSuccessDescription.
  ///
  /// In en, this message translates to:
  /// **'Your payment was successful and your purchase has been recorded'**
  String get paymentSuccessDescription;

  /// No description provided for @paymentFailedDescription.
  ///
  /// In en, this message translates to:
  /// **'Unfortunately your payment was not successful. Please try again'**
  String get paymentFailedDescription;

  /// No description provided for @paymentExpiredDescription.
  ///
  /// In en, this message translates to:
  /// **'Your payment time has expired. Please try again'**
  String get paymentExpiredDescription;

  /// No description provided for @paymentCancelledDescription.
  ///
  /// In en, this message translates to:
  /// **'The payment was cancelled by you'**
  String get paymentCancelledDescription;

  /// No description provided for @paymentErrorDescription.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while processing the payment'**
  String get paymentErrorDescription;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home page'**
  String get backToHome;

  /// No description provided for @bookPurchase.
  ///
  /// In en, this message translates to:
  /// **'Book purchase'**
  String get bookPurchase;

  /// No description provided for @giftCardPurchase.
  ///
  /// In en, this message translates to:
  /// **'Gift card purchase'**
  String get giftCardPurchase;

  /// No description provided for @walletCharge.
  ///
  /// In en, this message translates to:
  /// **'Wallet top-up'**
  String get walletCharge;

  /// No description provided for @viewMyBooks.
  ///
  /// In en, this message translates to:
  /// **'View my books'**
  String get viewMyBooks;

  /// No description provided for @viewMySubscriptions.
  ///
  /// In en, this message translates to:
  /// **'View my subscriptions'**
  String get viewMySubscriptions;

  /// No description provided for @viewGiftCards.
  ///
  /// In en, this message translates to:
  /// **'View gift cards'**
  String get viewGiftCards;

  /// No description provided for @viewWallet.
  ///
  /// In en, this message translates to:
  /// **'View wallet'**
  String get viewWallet;

  /// No description provided for @paymentDone.
  ///
  /// In en, this message translates to:
  /// **'Payment completed successfully'**
  String get paymentDone;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order number'**
  String get orderNumber;

  /// No description provided for @transactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get transactionId;

  /// No description provided for @purchasedItems.
  ///
  /// In en, this message translates to:
  /// **'Purchased items'**
  String get purchasedItems;

  /// No description provided for @itemsCountTapToView.
  ///
  /// In en, this message translates to:
  /// **'{count} items - tap to view'**
  String itemsCountTapToView(Object count);

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @productWithValue.
  ///
  /// In en, this message translates to:
  /// **'Product {productId}'**
  String productWithValue(Object productId);

  /// No description provided for @productIdWithValue.
  ///
  /// In en, this message translates to:
  /// **'Product ID: {productId}'**
  String productIdWithValue(Object productId);

  /// No description provided for @purchased.
  ///
  /// In en, this message translates to:
  /// **'Purchased'**
  String get purchased;

  /// No description provided for @totalPayment.
  ///
  /// In en, this message translates to:
  /// **'Total payment'**
  String get totalPayment;

  /// No description provided for @itemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String itemsCount(Object count);

  /// No description provided for @viewPaymentHistory.
  ///
  /// In en, this message translates to:
  /// **'View payment history'**
  String get viewPaymentHistory;

  /// No description provided for @paymentHistory.
  ///
  /// In en, this message translates to:
  /// **'Payment history'**
  String get paymentHistory;

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date:'**
  String get dateLabel;

  /// No description provided for @purchaseLabel.
  ///
  /// In en, this message translates to:
  /// **'Purchase:'**
  String get purchaseLabel;

  /// No description provided for @amountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount:'**
  String get amountLabel;

  /// No description provided for @amountTomanTrailing.
  ///
  /// In en, this message translates to:
  /// **'{amount} Toman'**
  String amountTomanTrailing(Object amount);

  /// No description provided for @viaLabel.
  ///
  /// In en, this message translates to:
  /// **'Via:'**
  String get viaLabel;

  /// No description provided for @statusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status:'**
  String get statusLabel;

  /// No description provided for @trackingCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Tracking code:'**
  String get trackingCodeLabel;

  /// No description provided for @discountLabel.
  ///
  /// In en, this message translates to:
  /// **'Discount:'**
  String get discountLabel;

  /// No description provided for @store.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get store;

  /// No description provided for @noPurchasesYet.
  ///
  /// In en, this message translates to:
  /// **'You haven't made any purchases yet.'**
  String get noPurchasesYet;

  /// No description provided for @paymentHistoryHint.
  ///
  /// In en, this message translates to:
  /// **'Here you can see your transaction history'**
  String get paymentHistoryHint;

  /// No description provided for @personalDevelopmentBooks.
  ///
  /// In en, this message translates to:
  /// **'Personal development books'**
  String get personalDevelopmentBooks;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @textBooks.
  ///
  /// In en, this message translates to:
  /// **'Text books'**
  String get textBooks;

  /// No description provided for @audioBooks.
  ///
  /// In en, this message translates to:
  /// **'Audiobooks'**
  String get audioBooks;

  /// No description provided for @authorTranslatorNarrator.
  ///
  /// In en, this message translates to:
  /// **'Author, translator or narrator'**
  String get authorTranslatorNarrator;

  /// No description provided for @drivingMode.
  ///
  /// In en, this message translates to:
  /// **'Driving mode'**
  String get drivingMode;

  /// No description provided for @stopPlaybackAfter.
  ///
  /// In en, this message translates to:
  /// **'Stop playback after...'**
  String get stopPlaybackAfter;

  /// No description provided for @oneMinuteTest.
  ///
  /// In en, this message translates to:
  /// **'1 minute (test)'**
  String get oneMinuteTest;

  /// No description provided for @fifteenMinutes.
  ///
  /// In en, this message translates to:
  /// **'15 minutes'**
  String get fifteenMinutes;

  /// No description provided for @twentyMinutes.
  ///
  /// In en, this message translates to:
  /// **'20 minutes'**
  String get twentyMinutes;

  /// No description provided for @thirtyMinutes.
  ///
  /// In en, this message translates to:
  /// **'30 minutes'**
  String get thirtyMinutes;

  /// No description provided for @fortyFiveMinutes.
  ///
  /// In en, this message translates to:
  /// **'45 minutes'**
  String get fortyFiveMinutes;

  /// No description provided for @oneHour.
  ///
  /// In en, this message translates to:
  /// **'1 hour'**
  String get oneHour;

  /// No description provided for @endOfThisSection.
  ///
  /// In en, this message translates to:
  /// **'End of this section'**
  String get endOfThisSection;

  /// No description provided for @playbackSpeed.
  ///
  /// In en, this message translates to:
  /// **'Playback speed'**
  String get playbackSpeed;

  /// No description provided for @normalSpeed.
  ///
  /// In en, this message translates to:
  /// **'{speed}.0X (normal)'**
  String normalSpeed(Object speed);

  /// No description provided for @someTracksNotDownloaded.
  ///
  /// In en, this message translates to:
  /// **'Some tracks were not downloaded.'**
  String get someTracksNotDownloaded;

  /// No description provided for @percentListened.
  ///
  /// In en, this message translates to:
  /// **'{percent}% listened'**
  String percentListened(Object percent);

  /// No description provided for @someTracksNotDownloadedColon.
  ///
  /// In en, this message translates to:
  /// **'Some tracks were not downloaded:'**
  String get someTracksNotDownloadedColon;

  /// No description provided for @retryFailedTracksOnly.
  ///
  /// In en, this message translates to:
  /// **'Retry only the failed tracks'**
  String get retryFailedTracksOnly;

  /// No description provided for @allTracksDownloaded.
  ///
  /// In en, this message translates to:
  /// **'All tracks downloaded successfully!'**
  String get allTracksDownloaded;

  /// No description provided for @downloadAll.
  ///
  /// In en, this message translates to:
  /// **'Download all'**
  String get downloadAll;

  /// No description provided for @noteSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Note saved successfully'**
  String get noteSavedSuccessfully;

  /// No description provided for @errorSavingNoteWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error saving note: {error}'**
  String errorSavingNoteWithMessage(Object error);

  /// No description provided for @bookAddedToBookmarks.
  ///
  /// In en, this message translates to:
  /// **'Book added to bookmarks'**
  String get bookAddedToBookmarks;

  /// No description provided for @bookRemovedFromBookmarks.
  ///
  /// In en, this message translates to:
  /// **'Book removed from bookmarks'**
  String get bookRemovedFromBookmarks;

  /// No description provided for @errorBookmarkingWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error bookmarking: {error}'**
  String errorBookmarkingWithMessage(Object error);

  /// No description provided for @clippingSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Book clipping saved successfully'**
  String get clippingSavedSuccessfully;

  /// No description provided for @errorSavingClippingWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error saving book clipping: {error}'**
  String errorSavingClippingWithMessage(Object error);

  /// No description provided for @errorDownloadingBookWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error downloading book: {error}'**
  String errorDownloadingBookWithMessage(Object error);

  /// No description provided for @errorSharing.
  ///
  /// In en, this message translates to:
  /// **'Error sharing'**
  String get errorSharing;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @productNotFound.
  ///
  /// In en, this message translates to:
  /// **'Product not found'**
  String get productNotFound;

  /// No description provided for @productNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'The requested product is not available'**
  String get productNotAvailable;

  /// No description provided for @shareBook.
  ///
  /// In en, this message translates to:
  /// **'Share book'**
  String get shareBook;

  /// No description provided for @aboutBook.
  ///
  /// In en, this message translates to:
  /// **'About the book'**
  String get aboutBook;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @tag.
  ///
  /// In en, this message translates to:
  /// **'Tag'**
  String get tag;

  /// No description provided for @userReviews.
  ///
  /// In en, this message translates to:
  /// **'User reviews'**
  String get userReviews;

  /// No description provided for @otherBooksByAuthor.
  ///
  /// In en, this message translates to:
  /// **'Other books by this author'**
  String get otherBooksByAuthor;

  /// No description provided for @otherBooksByPublisher.
  ///
  /// In en, this message translates to:
  /// **'Other books by this publisher'**
  String get otherBooksByPublisher;

  /// No description provided for @relatedBooks.
  ///
  /// In en, this message translates to:
  /// **'Related books'**
  String get relatedBooks;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// No description provided for @contentTypeUnknown.
  ///
  /// In en, this message translates to:
  /// **'Content type is unknown'**
  String get contentTypeUnknown;

  /// No description provided for @audioFileNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Audio file is not available'**
  String get audioFileNotAvailable;

  /// No description provided for @bookFileNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Book file is not available'**
  String get bookFileNotAvailable;

  /// No description provided for @productAlreadyInCart.
  ///
  /// In en, this message translates to:
  /// **'This product is already in your shopping cart'**
  String get productAlreadyInCart;

  /// No description provided for @addedToCartWithName.
  ///
  /// In en, this message translates to:
  /// **'{name} was added to the shopping cart'**
  String addedToCartWithName(Object name);

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @errorAddingToCart.
  ///
  /// In en, this message translates to:
  /// **'Error adding to shopping cart'**
  String get errorAddingToCart;

  /// No description provided for @fromReviewsCount.
  ///
  /// In en, this message translates to:
  /// **'from {count} reviews'**
  String fromReviewsCount(Object count);

  /// No description provided for @premiumAccess.
  ///
  /// In en, this message translates to:
  /// **'Premium access'**
  String get premiumAccess;

  /// No description provided for @addToShelf.
  ///
  /// In en, this message translates to:
  /// **'Add to shelf'**
  String get addToShelf;

  /// No description provided for @viewCart.
  ///
  /// In en, this message translates to:
  /// **'View shopping cart'**
  String get viewCart;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to shopping cart'**
  String get addToCart;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @readSample.
  ///
  /// In en, this message translates to:
  /// **'Read sample'**
  String get readSample;

  /// No description provided for @continueReading.
  ///
  /// In en, this message translates to:
  /// **'Continue reading'**
  String get continueReading;

  /// No description provided for @fullDescription.
  ///
  /// In en, this message translates to:
  /// **'Full description'**
  String get fullDescription;

  /// No description provided for @tableOfContents.
  ///
  /// In en, this message translates to:
  /// **'Table of contents'**
  String get tableOfContents;

  /// No description provided for @viewBookInfo.
  ///
  /// In en, this message translates to:
  /// **'View book information'**
  String get viewBookInfo;

  /// No description provided for @helpful.
  ///
  /// In en, this message translates to:
  /// **'Helpful'**
  String get helpful;

  /// No description provided for @notHelpful.
  ///
  /// In en, this message translates to:
  /// **'Not helpful'**
  String get notHelpful;

  /// No description provided for @whatIsYourOpinion.
  ///
  /// In en, this message translates to:
  /// **'What is your opinion?'**
  String get whatIsYourOpinion;

  /// No description provided for @bookAddedToShelf.
  ///
  /// In en, this message translates to:
  /// **'Book added to shelf successfully'**
  String get bookAddedToShelf;

  /// No description provided for @createNewShelfTitle.
  ///
  /// In en, this message translates to:
  /// **'Create new shelf'**
  String get createNewShelfTitle;

  /// No description provided for @enterShelfName.
  ///
  /// In en, this message translates to:
  /// **'Enter the shelf name'**
  String get enterShelfName;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @errorLoadingProfileCheckInternet.
  ///
  /// In en, this message translates to:
  /// **'Error loading profile information. Please check your internet connection.'**
  String get errorLoadingProfileCheckInternet;

  /// No description provided for @errorLoadingProfileWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error loading profile information: {error}'**
  String errorLoadingProfileWithMessage(Object error);

  /// No description provided for @profileManagement.
  ///
  /// In en, this message translates to:
  /// **'Profile management'**
  String get profileManagement;

  /// No description provided for @errorLoadingProfile.
  ///
  /// In en, this message translates to:
  /// **'Error loading profile'**
  String get errorLoadingProfile;

  /// No description provided for @selectImageSource.
  ///
  /// In en, this message translates to:
  /// **'Select image source'**
  String get selectImageSource;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @imageFileNotFound.
  ///
  /// In en, this message translates to:
  /// **'Image file not found'**
  String get imageFileNotFound;

  /// No description provided for @imageMaxSize10Mb.
  ///
  /// In en, this message translates to:
  /// **'Image file size must not exceed 10 MB'**
  String get imageMaxSize10Mb;

  /// No description provided for @editImage.
  ///
  /// In en, this message translates to:
  /// **'Edit image'**
  String get editImage;

  /// No description provided for @imageSelectedWithoutEditing.
  ///
  /// In en, this message translates to:
  /// **'Image selected without editing'**
  String get imageSelectedWithoutEditing;

  /// No description provided for @errorSelectingImage.
  ///
  /// In en, this message translates to:
  /// **'Error selecting image'**
  String get errorSelectingImage;

  /// No description provided for @errorEditingImage.
  ///
  /// In en, this message translates to:
  /// **'Error editing image. Please select another image'**
  String get errorEditingImage;

  /// No description provided for @galleryCameraPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Access to the gallery or camera was not granted'**
  String get galleryCameraPermissionDenied;

  /// No description provided for @unsupportedImageFormat.
  ///
  /// In en, this message translates to:
  /// **'Image format is not supported. Please select a JPG or PNG image'**
  String get unsupportedImageFormat;

  /// No description provided for @errorReadingImage.
  ///
  /// In en, this message translates to:
  /// **'Error reading image file. Please select another image'**
  String get errorReadingImage;

  /// No description provided for @invalidImageFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid image format. Please select a valid image'**
  String get invalidImageFormat;

  /// No description provided for @minimumAge10.
  ///
  /// In en, this message translates to:
  /// **'You must be at least 10 years old'**
  String get minimumAge10;

  /// No description provided for @invalidBirthDate.
  ///
  /// In en, this message translates to:
  /// **'Invalid birth date'**
  String get invalidBirthDate;

  /// No description provided for @imageTooLarge.
  ///
  /// In en, this message translates to:
  /// **'The image is too large. Please select a smaller image'**
  String get imageTooLarge;

  /// No description provided for @errorProcessingImage.
  ///
  /// In en, this message translates to:
  /// **'Error processing image. Please select another image'**
  String get errorProcessingImage;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @passwordOptional.
  ///
  /// In en, this message translates to:
  /// **'Password (optional)'**
  String get passwordOptional;

  /// No description provided for @enterNewPasswordToChange.
  ///
  /// In en, this message translates to:
  /// **'To change your password, enter a new password'**
  String get enterNewPasswordToChange;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @birthDate.
  ///
  /// In en, this message translates to:
  /// **'Birth date'**
  String get birthDate;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDate;

  /// No description provided for @aboutMeOptional.
  ///
  /// In en, this message translates to:
  /// **'About me (optional)'**
  String get aboutMeOptional;

  /// No description provided for @saveInformation.
  ///
  /// In en, this message translates to:
  /// **'Save information'**
  String get saveInformation;

  /// No description provided for @monthFarvardin.
  ///
  /// In en, this message translates to:
  /// **'Farvardin'**
  String get monthFarvardin;

  /// No description provided for @monthOrdibehesht.
  ///
  /// In en, this message translates to:
  /// **'Ordibehesht'**
  String get monthOrdibehesht;

  /// No description provided for @monthKhordad.
  ///
  /// In en, this message translates to:
  /// **'Khordad'**
  String get monthKhordad;

  /// No description provided for @monthTir.
  ///
  /// In en, this message translates to:
  /// **'Tir'**
  String get monthTir;

  /// No description provided for @monthMordad.
  ///
  /// In en, this message translates to:
  /// **'Mordad'**
  String get monthMordad;

  /// No description provided for @monthShahrivar.
  ///
  /// In en, this message translates to:
  /// **'Shahrivar'**
  String get monthShahrivar;

  /// No description provided for @monthMehr.
  ///
  /// In en, this message translates to:
  /// **'Mehr'**
  String get monthMehr;

  /// No description provided for @monthAban.
  ///
  /// In en, this message translates to:
  /// **'Aban'**
  String get monthAban;

  /// No description provided for @monthAzar.
  ///
  /// In en, this message translates to:
  /// **'Azar'**
  String get monthAzar;

  /// No description provided for @monthDey.
  ///
  /// In en, this message translates to:
  /// **'Dey'**
  String get monthDey;

  /// No description provided for @monthBahman.
  ///
  /// In en, this message translates to:
  /// **'Bahman'**
  String get monthBahman;

  /// No description provided for @monthEsfand.
  ///
  /// In en, this message translates to:
  /// **'Esfand'**
  String get monthEsfand;

  /// No description provided for @selectBirthDate.
  ///
  /// In en, this message translates to:
  /// **'Select birth date'**
  String get selectBirthDate;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @noPublicChaptersYet.
  ///
  /// In en, this message translates to:
  /// **'No public chapters have been created yet'**
  String get noPublicChaptersYet;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @replyToBookClipping.
  ///
  /// In en, this message translates to:
  /// **'Reply to book clipping'**
  String get replyToBookClipping;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @reviewsAndRatings.
  ///
  /// In en, this message translates to:
  /// **'Reviews and ratings'**
  String get reviewsAndRatings;

  /// No description provided for @submitReviewAndRating.
  ///
  /// In en, this message translates to:
  /// **'Submit review and rating'**
  String get submitReviewAndRating;

  /// No description provided for @shareOpinion.
  ///
  /// In en, this message translates to:
  /// **'Share opinion'**
  String get shareOpinion;

  /// No description provided for @uploadProduct.
  ///
  /// In en, this message translates to:
  /// **'Upload product'**
  String get uploadProduct;

  /// No description provided for @searchMarketplace.
  ///
  /// In en, this message translates to:
  /// **'Search the marketplace'**
  String get searchMarketplace;

  /// No description provided for @noProductsInMarketplace.
  ///
  /// In en, this message translates to:
  /// **'There are currently no products in the marketplace'**
  String get noProductsInMarketplace;

  /// No description provided for @handouts.
  ///
  /// In en, this message translates to:
  /// **'Handouts'**
  String get handouts;

  /// No description provided for @educationalContent.
  ///
  /// In en, this message translates to:
  /// **'Educational content'**
  String get educationalContent;

  /// No description provided for @questionBank.
  ///
  /// In en, this message translates to:
  /// **'Question bank'**
  String get questionBank;

  /// No description provided for @periodical.
  ///
  /// In en, this message translates to:
  /// **'Periodical'**
  String get periodical;

  /// No description provided for @quarterly.
  ///
  /// In en, this message translates to:
  /// **'Quarterly'**
  String get quarterly;

  /// No description provided for @monthlyMagazine.
  ///
  /// In en, this message translates to:
  /// **'Monthly magazine'**
  String get monthlyMagazine;

  /// No description provided for @yearbook.
  ///
  /// In en, this message translates to:
  /// **'Yearbook'**
  String get yearbook;

  /// No description provided for @productsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} products'**
  String productsCount(Object count);

  /// No description provided for @studyTourNotFound.
  ///
  /// In en, this message translates to:
  /// **'The requested study path was not found'**
  String get studyTourNotFound;

  /// No description provided for @errorLoadingStudyTourDetailsWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error loading study path details: {error}'**
  String errorLoadingStudyTourDetailsWithMessage(Object error);

  /// No description provided for @twoMonths.
  ///
  /// In en, this message translates to:
  /// **'2 months'**
  String get twoMonths;

  /// No description provided for @fourMonths.
  ///
  /// In en, this message translates to:
  /// **'4 months'**
  String get fourMonths;

  /// No description provided for @sixMonths.
  ///
  /// In en, this message translates to:
  /// **'6 months'**
  String get sixMonths;

  /// No description provided for @eightMonths.
  ///
  /// In en, this message translates to:
  /// **'8 months'**
  String get eightMonths;

  /// No description provided for @studyTour.
  ///
  /// In en, this message translates to:
  /// **'Study path'**
  String get studyTour;

  /// No description provided for @booksCountLabel.
  ///
  /// In en, this message translates to:
  /// **'Number of books'**
  String get booksCountLabel;

  /// No description provided for @studyRoute.
  ///
  /// In en, this message translates to:
  /// **'Study route'**
  String get studyRoute;

  /// No description provided for @errorLoadingStudyToursWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error loading study paths: {error}'**
  String errorLoadingStudyToursWithMessage(Object error);

  /// No description provided for @myStudyTours.
  ///
  /// In en, this message translates to:
  /// **'My study paths'**
  String get myStudyTours;

  /// No description provided for @noStudyToursYet.
  ///
  /// In en, this message translates to:
  /// **'You haven't submitted a study path yet'**
  String get noStudyToursYet;

  /// No description provided for @submitFirstStudyTour.
  ///
  /// In en, this message translates to:
  /// **'Submit your first study path'**
  String get submitFirstStudyTour;

  /// No description provided for @submitStudyTour.
  ///
  /// In en, this message translates to:
  /// **'Submit study path'**
  String get submitStudyTour;

  /// No description provided for @providedAnswer.
  ///
  /// In en, this message translates to:
  /// **'Provided answer:'**
  String get providedAnswer;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @errorLoadingCategories.
  ///
  /// In en, this message translates to:
  /// **'Error loading categories'**
  String get errorLoadingCategories;

  /// No description provided for @studyTourRequest.
  ///
  /// In en, this message translates to:
  /// **'Study path request'**
  String get studyTourRequest;

  /// No description provided for @designYourStudyTour.
  ///
  /// In en, this message translates to:
  /// **'Design your study path'**
  String get designYourStudyTour;

  /// No description provided for @studyTourRequestHint.
  ///
  /// In en, this message translates to:
  /// **'Choose your desired subject and submit your study path request'**
  String get studyTourRequestHint;

  /// No description provided for @studyTourTitle.
  ///
  /// In en, this message translates to:
  /// **'Study path title'**
  String get studyTourTitle;

  /// No description provided for @studyTourTitleExample.
  ///
  /// In en, this message translates to:
  /// **'Example: Iranian history study path'**
  String get studyTourTitleExample;

  /// No description provided for @studyTourDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Write your description of the desired study path...'**
  String get studyTourDescriptionHint;

  /// No description provided for @submitRequest.
  ///
  /// In en, this message translates to:
  /// **'Submit request'**
  String get submitRequest;

  /// No description provided for @noBookFoundPlain.
  ///
  /// In en, this message translates to:
  /// **'No book found'**
  String get noBookFoundPlain;

  /// No description provided for @textBooksTitle.
  ///
  /// In en, this message translates to:
  /// **'Text books'**
  String get textBooksTitle;

  /// No description provided for @productUploadedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Product uploaded successfully'**
  String get productUploadedSuccessfully;

  /// No description provided for @errorSelectingFileWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error selecting file: {error}'**
  String errorSelectingFileWithMessage(Object error);

  /// No description provided for @errorSelectingSampleFileWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error selecting sample file: {error}'**
  String errorSelectingSampleFileWithMessage(Object error);

  /// No description provided for @pleaseSelectMainFile.
  ///
  /// In en, this message translates to:
  /// **'Please select the main file'**
  String get pleaseSelectMainFile;

  /// No description provided for @pleaseSelectCategory.
  ///
  /// In en, this message translates to:
  /// **'Please select a category'**
  String get pleaseSelectCategory;

  /// No description provided for @pleaseSelectProductImage.
  ///
  /// In en, this message translates to:
  /// **'Please select the product image'**
  String get pleaseSelectProductImage;

  /// No description provided for @uploadAnswerSheetOrHandout.
  ///
  /// In en, this message translates to:
  /// **'Upload answer sheet or handout'**
  String get uploadAnswerSheetOrHandout;

  /// No description provided for @contentType.
  ///
  /// In en, this message translates to:
  /// **'Content type'**
  String get contentType;

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'Product name'**
  String get productName;

  /// No description provided for @productNameExample.
  ///
  /// In en, this message translates to:
  /// **'Example: 10th grade math handout'**
  String get productNameExample;

  /// No description provided for @pleaseEnterProductName.
  ///
  /// In en, this message translates to:
  /// **'Please enter the product name'**
  String get pleaseEnterProductName;

  /// No description provided for @pageCount.
  ///
  /// In en, this message translates to:
  /// **'Number of pages'**
  String get pageCount;

  /// No description provided for @pageCountExample.
  ///
  /// In en, this message translates to:
  /// **'Example: 30'**
  String get pageCountExample;

  /// No description provided for @pleaseEnterPageCount.
  ///
  /// In en, this message translates to:
  /// **'Please enter the number of pages'**
  String get pleaseEnterPageCount;

  /// No description provided for @pleaseEnterValidNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get pleaseEnterValidNumber;

  /// No description provided for @publishYear.
  ///
  /// In en, this message translates to:
  /// **'Publication year'**
  String get publishYear;

  /// No description provided for @publishYearExample.
  ///
  /// In en, this message translates to:
  /// **'Example: 1402'**
  String get publishYearExample;

  /// No description provided for @pleaseEnterPublishYear.
  ///
  /// In en, this message translates to:
  /// **'Please enter the publication year'**
  String get pleaseEnterPublishYear;

  /// No description provided for @priceInToman.
  ///
  /// In en, this message translates to:
  /// **'Price (Toman)'**
  String get priceInToman;

  /// No description provided for @priceExample.
  ///
  /// In en, this message translates to:
  /// **'Example: 250,000'**
  String get priceExample;

  /// No description provided for @pleaseEnterPrice.
  ///
  /// In en, this message translates to:
  /// **'Please enter the price'**
  String get pleaseEnterPrice;

  /// No description provided for @enterProductDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter the product description...'**
  String get enterProductDescription;

  /// No description provided for @pleaseEnterDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter the description'**
  String get pleaseEnterDescription;

  /// No description provided for @mainFileRequired.
  ///
  /// In en, this message translates to:
  /// **'Main file *'**
  String get mainFileRequired;

  /// No description provided for @selectFilePdfDoc.
  ///
  /// In en, this message translates to:
  /// **'Select file (PDF, DOC, DOCX)'**
  String get selectFilePdfDoc;

  /// No description provided for @sampleFileOptional.
  ///
  /// In en, this message translates to:
  /// **'Sample file (optional)'**
  String get sampleFileOptional;

  /// No description provided for @selectSampleFile.
  ///
  /// In en, this message translates to:
  /// **'Select sample file'**
  String get selectSampleFile;

  /// No description provided for @productImageRequired.
  ///
  /// In en, this message translates to:
  /// **'Product image *'**
  String get productImageRequired;

  /// No description provided for @handout.
  ///
  /// In en, this message translates to:
  /// **'Handout'**
  String get handout;

  /// No description provided for @mySubscriptions.
  ///
  /// In en, this message translates to:
  /// **'My subscriptions'**
  String get mySubscriptions;

  /// No description provided for @myCommentsMenu.
  ///
  /// In en, this message translates to:
  /// **'My comments'**
  String get myCommentsMenu;

  /// No description provided for @myClippingsMenu.
  ///
  /// In en, this message translates to:
  /// **'My clippings'**
  String get myClippingsMenu;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out of account'**
  String get logout;

  /// No description provided for @walletChargedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Wallet topped up successfully!'**
  String get walletChargedSuccessfully;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @customAmountToman.
  ///
  /// In en, this message translates to:
  /// **'Custom amount (Toman)'**
  String get customAmountToman;

  /// No description provided for @activateGiftCard.
  ///
  /// In en, this message translates to:
  /// **'Activate gift card'**
  String get activateGiftCard;

  /// No description provided for @currentBalanceToman.
  ///
  /// In en, this message translates to:
  /// **'Current balance\n {amount} Toman'**
  String currentBalanceToman(Object amount);

  /// No description provided for @setAmount.
  ///
  /// In en, this message translates to:
  /// **' Set amount'**
  String get setAmount;

  /// No description provided for @pleaseSelectAtLeastOneChapter.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one chapter'**
  String get pleaseSelectAtLeastOneChapter;

  /// No description provided for @addToNoteCards.
  ///
  /// In en, this message translates to:
  /// **'Add to note cards'**
  String get addToNoteCards;

  /// No description provided for @selectedClipping.
  ///
  /// In en, this message translates to:
  /// **'Selected clipping'**
  String get selectedClipping;

  /// No description provided for @selectChapter.
  ///
  /// In en, this message translates to:
  /// **'Select chapter'**
  String get selectChapter;

  /// No description provided for @chaptersSelectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} chapters selected'**
  String chaptersSelectedCount(Object count);

  /// No description provided for @noteOptional.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get noteOptional;

  /// No description provided for @confirmFormal.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmFormal;

  /// No description provided for @confirmWithCount.
  ///
  /// In en, this message translates to:
  /// **'Confirm ({count})'**
  String confirmWithCount(Object count);

  /// No description provided for @createChapterFirstToAddNote.
  ///
  /// In en, this message translates to:
  /// **'To add a note, you must first create a chapter.'**
  String get createChapterFirstToAddNote;

  /// No description provided for @selectedClippingColon.
  ///
  /// In en, this message translates to:
  /// **'Selected clipping:'**
  String get selectedClippingColon;

  /// No description provided for @selectChapterColon.
  ///
  /// In en, this message translates to:
  /// **'Select chapter:'**
  String get selectChapterColon;

  /// No description provided for @yourNoteOptional.
  ///
  /// In en, this message translates to:
  /// **'Your note (optional)'**
  String get yourNoteOptional;

  /// No description provided for @unknownAuthor.
  ///
  /// In en, this message translates to:
  /// **'Unknown author'**
  String get unknownAuthor;

  /// No description provided for @percentListenedSpaced.
  ///
  /// In en, this message translates to:
  /// **'{percent}% listened'**
  String percentListenedSpaced(Object percent);

  /// No description provided for @percentRead.
  ///
  /// In en, this message translates to:
  /// **'{percent}% read'**
  String percentRead(Object percent);

  /// No description provided for @noCategoryFound.
  ///
  /// In en, this message translates to:
  /// **'No category found'**
  String get noCategoryFound;

  /// No description provided for @fontYekanBakh.
  ///
  /// In en, this message translates to:
  /// **'Yekan Bakh'**
  String get fontYekanBakh;

  /// No description provided for @fontVazir.
  ///
  /// In en, this message translates to:
  /// **'Vazir'**
  String get fontVazir;

  /// No description provided for @fontAnjoman.
  ///
  /// In en, this message translates to:
  /// **'Anjoman'**
  String get fontAnjoman;

  /// No description provided for @fontIranYekan.
  ///
  /// In en, this message translates to:
  /// **'IRAN Yekan'**
  String get fontIranYekan;

  /// No description provided for @addToNoteCardsEmoji.
  ///
  /// In en, this message translates to:
  /// **'📝 Add to note cards'**
  String get addToNoteCardsEmoji;

  /// No description provided for @bookClippingEmoji.
  ///
  /// In en, this message translates to:
  /// **'📑 Book clipping'**
  String get bookClippingEmoji;

  /// No description provided for @highlightYellow.
  ///
  /// In en, this message translates to:
  /// **'🟡 Yellow highlight'**
  String get highlightYellow;

  /// No description provided for @highlightGreen.
  ///
  /// In en, this message translates to:
  /// **'🟢 Green highlight'**
  String get highlightGreen;

  /// No description provided for @highlightOrange.
  ///
  /// In en, this message translates to:
  /// **'🟠 Orange highlight'**
  String get highlightOrange;

  /// No description provided for @highlightBlue.
  ///
  /// In en, this message translates to:
  /// **'🔵 Blue highlight'**
  String get highlightBlue;

  /// No description provided for @textHighlightedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Text highlighted successfully'**
  String get textHighlightedSuccessfully;

  /// No description provided for @noReadableContent.
  ///
  /// In en, this message translates to:
  /// **'No readable content found.'**
  String get noReadableContent;

  /// No description provided for @chapters.
  ///
  /// In en, this message translates to:
  /// **'Chapters'**
  String get chapters;

  /// No description provided for @highlights.
  ///
  /// In en, this message translates to:
  /// **'Highlights'**
  String get highlights;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @deleteAllHighlights.
  ///
  /// In en, this message translates to:
  /// **'Delete all highlights'**
  String get deleteAllHighlights;

  /// No description provided for @pageNumber.
  ///
  /// In en, this message translates to:
  /// **'Page {page}'**
  String pageNumber(Object page);

  /// No description provided for @gridView.
  ///
  /// In en, this message translates to:
  /// **'Grid view'**
  String get gridView;

  /// No description provided for @previousPage.
  ///
  /// In en, this message translates to:
  /// **'Previous page'**
  String get previousPage;

  /// No description provided for @pageProgress.
  ///
  /// In en, this message translates to:
  /// **'{page} of {totalPages} pages - {percent}%'**
  String pageProgress(Object page, Object totalPages, Object percent);

  /// No description provided for @nextPage.
  ///
  /// In en, this message translates to:
  /// **'Next page'**
  String get nextPage;

  /// No description provided for @chaptersAndHighlights.
  ///
  /// In en, this message translates to:
  /// **'Chapters and highlights'**
  String get chaptersAndHighlights;

  /// No description provided for @book.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get book;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @fontType.
  ///
  /// In en, this message translates to:
  /// **'Font type'**
  String get fontType;

  /// No description provided for @fontSize.
  ///
  /// In en, this message translates to:
  /// **'Font size'**
  String get fontSize;

  /// No description provided for @lineSpacing.
  ///
  /// In en, this message translates to:
  /// **'Line spacing'**
  String get lineSpacing;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @fontWeight.
  ///
  /// In en, this message translates to:
  /// **'Font weight'**
  String get fontWeight;

  /// No description provided for @normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @bold.
  ///
  /// In en, this message translates to:
  /// **'Bold'**
  String get bold;

  /// No description provided for @extraBold.
  ///
  /// In en, this message translates to:
  /// **'Extra bold'**
  String get extraBold;

  /// No description provided for @displayMode.
  ///
  /// In en, this message translates to:
  /// **'Display mode'**
  String get displayMode;

  /// No description provided for @nightMode.
  ///
  /// In en, this message translates to:
  /// **'Night mode'**
  String get nightMode;

  /// No description provided for @readingDirection.
  ///
  /// In en, this message translates to:
  /// **'Reading direction'**
  String get readingDirection;

  /// No description provided for @vertical.
  ///
  /// In en, this message translates to:
  /// **'Vertical'**
  String get vertical;

  /// No description provided for @switchToVerticalReading.
  ///
  /// In en, this message translates to:
  /// **'Switch reading direction to vertical'**
  String get switchToVerticalReading;

  /// No description provided for @noReadableContentHtml.
  ///
  /// In en, this message translates to:
  /// **'<p>No readable content found.</p>'**
  String get noReadableContentHtml;

  /// No description provided for @emptyBookHtml.
  ///
  /// In en, this message translates to:
  /// **'<p>The book is empty.</p>'**
  String get emptyBookHtml;

  /// No description provided for @emptyBook.
  ///
  /// In en, this message translates to:
  /// **'The book is empty.'**
  String get emptyBook;

  /// No description provided for @pdfFileNotFound.
  ///
  /// In en, this message translates to:
  /// **'PDF file not found'**
  String get pdfFileNotFound;

  /// No description provided for @errorLoadingPdfWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error loading PDF: {error}'**
  String errorLoadingPdfWithMessage(Object error);

  /// No description provided for @errorDownloadingFileWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error downloading file: {error}'**
  String errorDownloadingFileWithMessage(Object error);

  /// No description provided for @downloading.
  ///
  /// In en, this message translates to:
  /// **'Downloading...'**
  String get downloading;

  /// No description provided for @pageOfTotal.
  ///
  /// In en, this message translates to:
  /// **'Page {page} of {totalPages}'**
  String pageOfTotal(Object page, Object totalPages);

  /// No description provided for @connectionProblem.
  ///
  /// In en, this message translates to:
  /// **'Connection problem'**
  String get connectionProblem;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error'**
  String get serverError;

  /// No description provided for @connectionTimedOut.
  ///
  /// In en, this message translates to:
  /// **'Connection timed out'**
  String get connectionTimedOut;

  /// No description provided for @notFound.
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get notFound;

  /// No description provided for @accessDenied.
  ///
  /// In en, this message translates to:
  /// **'Access denied'**
  String get accessDenied;

  /// No description provided for @invalidData.
  ///
  /// In en, this message translates to:
  /// **'Invalid data'**
  String get invalidData;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get errorOccurred;

  /// No description provided for @appTheme.
  ///
  /// In en, this message translates to:
  /// **'App theme'**
  String get appTheme;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get appLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @uncategorized.
  ///
  /// In en, this message translates to:
  /// **'Uncategorized'**
  String get uncategorized;

  /// No description provided for @unknownPublisher.
  ///
  /// In en, this message translates to:
  /// **'Unknown publisher'**
  String get unknownPublisher;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
