// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get exampleText => 'Welcome';

  @override
  String get getStartedPageText => 'Test Test';

  @override
  String get appTitle => 'Halal Books';

  @override
  String get shareQuote => 'Share Quote';

  @override
  String get savingQuote => 'Saving quote...';

  @override
  String get quoteSaved => 'Quote saved successfully';

  @override
  String errorSavingQuote(String error) {
    return 'Error saving quote: $error';
  }

  @override
  String get pleaseSelectBirthDate => 'Please select birth date';

  @override
  String get birthDateMustBeBeforeToday => 'Birth date must be before today';

  @override
  String get pleaseSelectGender => 'Please select gender';

  @override
  String get pleaseEnterName => 'Please enter name';

  @override
  String get pleaseEnterLastName => 'Please enter last name';

  @override
  String get passwordMustBeAtLeast8Chars =>
      'Password must be at least 8 characters';

  @override
  String get profileUpdatedSuccessfully => 'Profile updated successfully';

  @override
  String get errorUpdatingProfile => 'Error updating profile';

  @override
  String get validationError => 'Validation error';
}
