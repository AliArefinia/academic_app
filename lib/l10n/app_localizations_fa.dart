// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get exampleText => 'خوش آمدید';

  @override
  String get getStartedPageText =>
      'اینجا با هر کلیک، سفری تازه آغاز می‌شود؛ سفری که شما را به دل داستان‌ها، رازها و دنیای پررمز و راز کتاب‌ها می‌برد.';

  @override
  String get appTitle => 'کتاب‌های حلال';

  @override
  String get shareQuote => 'اشتراک‌گذاری بریده';

  @override
  String get savingQuote => 'در حال ذخیره بریده...';

  @override
  String get quoteSaved => 'بریده با موفقیت ذخیره شد';

  @override
  String errorSavingQuote(String error) {
    return 'خطا در ذخیره بریده: $error';
  }

  @override
  String get pleaseSelectBirthDate => 'لطفا تاریخ تولد را انتخاب کنید';

  @override
  String get birthDateMustBeBeforeToday => 'تاریخ تولد باید قبل از امروز باشد';

  @override
  String get pleaseSelectGender => 'لطفا جنسیت را انتخاب کنید';

  @override
  String get pleaseEnterName => 'لطفا نام را وارد کنید';

  @override
  String get pleaseEnterLastName => 'لطفا نام خانوادگی را وارد کنید';

  @override
  String get passwordMustBeAtLeast8Chars =>
      'رمز عبور باید حداقل ۸ کاراکتر باشد';

  @override
  String get profileUpdatedSuccessfully => 'پروفایل با موفقیت بروزرسانی شد';

  @override
  String get errorUpdatingProfile => 'خطا در بروزرسانی پروفایل';

  @override
  String get validationError => 'خطا در اعتبارسنجی';
}
