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
  String get getStartedPageText => 'اینجا با هر کلیک، سفری تازه آغاز می‌شود؛ سفری که شما را به دل داستان‌ها، رازها و دنیای پررمز و راز کتاب‌ها می‌برد.';

  @override
  String get appTitle => 'دانشگاه امام صادق (ع)';

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
  String get passwordMustBeAtLeast8Chars => 'رمز عبور باید حداقل ۸ کاراکتر باشد';

  @override
  String get profileUpdatedSuccessfully => 'پروفایل با موفقیت بروزرسانی شد';

  @override
  String get errorUpdatingProfile => 'خطا در بروزرسانی پروفایل';

  @override
  String get validationError => 'خطا در اعتبارسنجی';

  @override
  String get errorSomethingWentWrong => 'مشکلی پیش آمده است. لطفا دوباره تلاش کنید';

  @override
  String get errorNoInternet => 'اتصال اینترنت برقرار نیست';

  @override
  String get errorServerTryAgain => 'مشکلی در سرور پیش آمده است. لطفا دوباره تلاش کنید';

  @override
  String get errorConnectionTimeout => 'زمان اتصال به پایان رسید. لطفا دوباره تلاش کنید';

  @override
  String get errorPleaseLoginAgain => 'لطفا دوباره وارد شوید';

  @override
  String get errorUnauthorized => 'دسترسی غیرمجاز';

  @override
  String get errorNotFound => 'اطلاعات مورد نظر یافت نشد';

  @override
  String get errorInvalidInput => 'اطلاعات وارد شده نامعتبر است';

  @override
  String get errorServiceUnavailable => 'سرویس در دسترس نیست. لطفا بعدا تلاش کنید';

  @override
  String get errorOperationCancelled => 'عملیات لغو شد';

  @override
  String get errorInvalidRequestData => 'اطلاعات ارسالی نامعتبر است. لطفا دوباره تلاش کنید';

  @override
  String get errorFileTooLarge => 'حجم فایل بسیار بزرگ است';

  @override
  String get errorUnsupportedFileFormat => 'فرمت فایل پشتیبانی نمی‌شود';

  @override
  String get errorTooManyRequests => 'تعداد درخواست‌ها بیش از حد مجاز است. لطفا کمی صبر کنید';

  @override
  String get errorProcessingData => 'خطا در پردازش اطلاعات';

  @override
  String get errorWrongPasswordOrPhone => 'رمز عبور یا شماره همراه اشتباه است';

  @override
  String get errorUserNotFound => 'کاربری با این اطلاعات یافت نشد';

  @override
  String get errorInvalidPhone => 'شماره همراه نامعتبر است';

  @override
  String get errorWrongVerificationCode => 'کد تایید اشتباه است. لطفا کد صحیح را وارد کنید';

  @override
  String get errorVerificationCodeExpired => 'کد تایید منقضی شده است. لطفا کد جدید درخواست کنید';

  @override
  String get errorWrongInput => 'اطلاعات وارد شده اشتباه است';

  @override
  String get errorAlreadyRegistered => 'این اطلاعات قبلا ثبت شده است';

  @override
  String get errorInsufficientBalance => 'موجودی کافی نیست';

  @override
  String get errorPaymentProcessing => 'خطا در پردازش پرداخت';

  @override
  String get errorServerTryLater => 'مشکلی در سرور پیش آمده است. لطفا بعدا تلاش کنید';

  @override
  String get authorBooks => 'کتاب‌های نویسنده';

  @override
  String get publisherBooks => 'کتاب‌های ناشر';

  @override
  String unknownLinkReceived(Object link) {
    return 'لینک نامشخص دریافت شد: $link';
  }

  @override
  String get verifyingPayment => 'در حال تایید پرداخت...';

  @override
  String get paymentVerifiedSuccessfully => 'پرداخت با موفقیت تایید شد!';

  @override
  String errorVerifyingPaymentWithMessage(Object error) {
    return 'خطا در تایید پرداخت: $error';
  }

  @override
  String get paymentFailedMessage => 'پرداخت ناموفق بود';

  @override
  String get paymentCancelledByUser => 'پرداخت توسط کاربر لغو شد';

  @override
  String get invalidBookLink => 'لینک کتاب نامعتبر است';

  @override
  String get invalidBookId => 'شناسه کتاب نامعتبر است';

  @override
  String get loadingBook => 'در حال بارگذاری کتاب...';

  @override
  String get errorOpeningBook => 'خطا در باز کردن کتاب';

  @override
  String errorLoadingBookWithMessage(Object error) {
    return 'خطا در بارگذاری کتاب: $error';
  }

  @override
  String get invalidClippingLink => 'لینک بریده نامعتبر است';

  @override
  String get errorOpeningClipping => 'خطا در باز کردن بریده';

  @override
  String get invalidPaymentParameters => 'پارامترهای پرداخت نامعتبر است';

  @override
  String get paymentCompletedSuccessfully => 'پرداخت با موفقیت انجام شد!';

  @override
  String get paymentNotVerified => 'پرداخت تایید نشد';

  @override
  String get cancelled => 'لغو';

  @override
  String get processingError => 'خطا در پردازش';

  @override
  String get unknownError => 'خطای نامشخص';

  @override
  String get errorFetchingProfile => 'خطا در دریافت اطلاعات پروفایل';

  @override
  String get active => 'فعال';

  @override
  String get expiredStatus => 'منقضی شده';

  @override
  String get daily => 'روزه';

  @override
  String get monthly => 'ماهانه';

  @override
  String get yearly => 'سالانه';

  @override
  String get reserved => 'رزرو شده';

  @override
  String amountMillionToman(Object amount) {
    return '${amount}M تومان';
  }

  @override
  String amountThousandToman(Object amount) {
    return '${amount}K تومان';
  }

  @override
  String amountToman(Object amount) {
    return '$amount تومان';
  }

  @override
  String get used => 'استفاده شده';

  @override
  String get errorSavingNote => 'خطا در ذخیره یادداشت';

  @override
  String get errorFetchingShop => 'خطا در دریافت اطلاعات بازارچه';

  @override
  String unexpectedErrorWithMessage(Object error) {
    return 'خطای غیرمنتظره: $error';
  }

  @override
  String get errorServerReturnedError => 'خطا در پاسخ سرور: سرور یک خطا بازگشت داده است';

  @override
  String get errorUploadingProduct => 'خطا در آپلود محصول';

  @override
  String get appName => 'دانشگاه امام صادق (ع)';

  @override
  String get loginToApp => 'ورود به دانشگاه امام صادق (ع)';

  @override
  String get loginWithEmail => 'با ایمیل خود وارد شوید:';

  @override
  String get loginWithPhone => 'با شماره موبایل خود وارد شوید:';

  @override
  String get login => 'ورود';

  @override
  String get or => 'یا';

  @override
  String get terms => 'قوانین';

  @override
  String get ofUsingApp => ' استفاده از دانشگاه امام صادق (ع)';

  @override
  String get email => 'ایمیل';

  @override
  String get password => 'رمز عبور';

  @override
  String get withPhoneNumber => 'با شماره همراه';

  @override
  String get withEmail => 'با ایمیل';

  @override
  String get withGoogleAccount => 'با حساب گوگل';

  @override
  String get enteredNumberIncorrect => 'شماره وارد شده صحیح نمیباشد';

  @override
  String get numberNotEntered => 'شماره وارد نشده است';

  @override
  String get numberFormatIncorrect => 'فرمت شماره صحیح نمی باشد';

  @override
  String get verificationCode => 'کد تایید';

  @override
  String get enterYourPassword => 'رمز ورود خود را وارد کنید';

  @override
  String phoneNumberLabel(Object phone) {
    return 'شماره: $phone';
  }

  @override
  String get editPhoneNumber => 'ویرایش شماره همراه';

  @override
  String get pleaseEnterPassword => 'لطفا رمز عبور را وارد کنید';

  @override
  String get loginWithOtp => 'ورود با رمز یکبار مصرف';

  @override
  String get haveInviteCodeOptional => 'کد دعوت دارم (اختیاری)';

  @override
  String get sixDigitInviteCode => 'کد دعوت ۶ رقمی';

  @override
  String get errorInInputData => 'خطا در اطلاعات ورودی';

  @override
  String get enterOtpSentToNumber => 'کد یکبار مصرف ارسال شده به شماره زیر را وارد کنید:';

  @override
  String get loginWithPassword => 'ورود با رمز عبور';

  @override
  String get checking => 'در حال بررسی...';

  @override
  String get continueLabel => 'ادامه';

  @override
  String get enterFiveDigitCode => 'کد ۵ رقمی را وارد کنید';

  @override
  String get completeInformation => 'تکمیل اطلاعات';

  @override
  String get pleaseSelectRoleAndCategory => 'لطفاً نقش و دسته‌بندی خود را انتخاب کنید';

  @override
  String get yourRole => 'نقش شما:';

  @override
  String get student => 'دانشجو';

  @override
  String get professor => 'استاد';

  @override
  String get categoryLabel => 'دسته‌بندی:';

  @override
  String get loggingIn => 'در حال ورود...';

  @override
  String get confirmAndLogin => 'تأیید و ورود';

  @override
  String get selectCategory => 'انتخاب دسته‌بندی';

  @override
  String get searchCategory => 'جستجوی دسته‌بندی...';

  @override
  String get categoryNotFound => 'دسته‌بندی یافت نشد';

  @override
  String get author => 'نویسنده';

  @override
  String get searchAuthorTranslatorNarrator => 'جستجو در نویسنده، مترجم یا گوینده';

  @override
  String get filter => 'فیلتر کردن';

  @override
  String get clearFilter => 'لغو فیلتر';

  @override
  String get categoriesShort => 'دسته‌ها';

  @override
  String get searchInApp => 'جستجو در دانشگاه امام صادق (ع)';

  @override
  String get mostPopularAudioBookCategories => 'محبوب‌ترین دسته‌بندی‌های کتاب صوتی';

  @override
  String sizeInMegabytes(Object size) {
    return '$size مگابایت';
  }

  @override
  String get identifier => 'شناسه';

  @override
  String get format => 'فرمت';

  @override
  String get size => 'حجم';

  @override
  String get duration => 'مدت زمان';

  @override
  String get listSeparator => '، ';

  @override
  String get translator => 'مترجم';

  @override
  String get narrator => 'راوی';

  @override
  String get publisher => 'ناشر';

  @override
  String get language => 'زبان';

  @override
  String get persian => 'فارسی';

  @override
  String get publishDate => 'تاریخ انتشار';

  @override
  String get price => 'قیمت';

  @override
  String get readAndDownloadFile => 'مطالعه و دانلود فایل';

  @override
  String get inTheAppName => 'در برنامه دانشگاه امام صادق (ع)';

  @override
  String get searchPublisher => 'جستجو در ناشر';

  @override
  String clippingFromBook(Object bookName) {
    return 'بریده‌ای از کتاب $bookName';
  }

  @override
  String errorSharingWithMessage(Object error) {
    return 'خطا در اشتراک‌گذاری: $error';
  }

  @override
  String get cancel => 'انصراف';

  @override
  String get share => 'اشتراک‌گذاری';

  @override
  String get all => 'همه';

  @override
  String get mostPopular => 'محبوبترین ها';

  @override
  String get hashtagSuccess => '#موفقیت';

  @override
  String get hashtagPsychology => '#روانشناسی';

  @override
  String get bookTour => 'کتاب گردی';

  @override
  String get noClippings => 'بریده‌ای وجود ندارد';

  @override
  String get noClippingsToShow => 'در حال حاضر بریده‌ای برای نمایش وجود ندارد';

  @override
  String get newLabel => 'تازه';

  @override
  String bookWithName(Object bookName) {
    return 'کتاب $bookName';
  }

  @override
  String get more => 'بیشتر';

  @override
  String get less => 'کمتر';

  @override
  String get bookmarked => 'نشان شده';

  @override
  String errorWithMessage(Object error) {
    return 'خطا: $error';
  }

  @override
  String get noBookmarkedBooks => 'کتابی نشان نشده!';

  @override
  String get noBookmarkedBooksYet => 'هنوز هیچ کتابی را نشان نکرده‌اید';

  @override
  String get untitled => 'بدون عنوان';

  @override
  String get home => 'خانه';

  @override
  String get profile => 'پروفایل';

  @override
  String get marketplace => 'بازارچه';

  @override
  String get categoriesTab => 'دسته ها';

  @override
  String get myBooks => 'کتاب های من';

  @override
  String get buySubscription => 'خرید اشتراک';

  @override
  String get faq => 'سوالات متداول';

  @override
  String get faqPlaceholder => 'پاسخ سوالات متداول در اینجا قرار می‌گیرد...';

  @override
  String get termsAndConditions => 'قوانین و مقررات';

  @override
  String get subscriptionTermsPlaceholder => 'قوانین و مقررات اشتراک در اینجا قرار می‌گیرد...';

  @override
  String get termsOfUse => 'شرایط استفاده';

  @override
  String get subscriptionTermsOfUsePlaceholder => 'شرایط استفاده از اشتراک در اینجا قرار می‌گیرد...';

  @override
  String errorProcessingPaymentWithMessage(Object error) {
    return 'خطا در پردازش پرداخت: $error';
  }

  @override
  String get toman => 'تومان';

  @override
  String daysCount(Object days) {
    return '$days روز';
  }

  @override
  String get cart => 'سبد خرید';

  @override
  String get paymentGatewayOpened => 'درگاه پرداخت با موفقیت باز شد';

  @override
  String get cartEmpty => 'سبد خرید شما خالی است';

  @override
  String get goHomeToBuyBooks => 'برای خرید کتاب به صفحه اصلی بروید';

  @override
  String get goToHome => 'برو به صفحه اصلی';

  @override
  String get paymentMethod => 'شیوه پرداخت';

  @override
  String get onlinePaymentGateway => 'درگاه پرداخت آنلاین';

  @override
  String get payWithShetabCards => 'پرداخت با همه کارت های عضو شتاب';

  @override
  String get invoice => 'فاکتور خرید';

  @override
  String get total => 'جمع کل';

  @override
  String get yourSavings => 'سود شما در این خرید';

  @override
  String get payableAmount => 'مبلغ قابل پرداخت';

  @override
  String get processing => 'در حال پردازش...';

  @override
  String payAmountToman(Object amount) {
    return 'پرداخت - $amount تومان';
  }

  @override
  String get audioBook => 'کتاب صوتی';

  @override
  String get textBook => 'کتاب متنی';

  @override
  String subjectWithValue(Object subject) {
    return 'موضوع: $subject';
  }

  @override
  String get useDiscountCode => 'استفاده از کد تخفیف';

  @override
  String get enterDiscountCode => 'کد تخفیف خود را وارد کنید';

  @override
  String get apply => 'اعمال';

  @override
  String get discountCodeApplied => 'کد تخفیف با موفقیت اعمال شد';

  @override
  String get filterLabel => 'فیلتر';

  @override
  String get bestSelling => 'پر فروش ترین';

  @override
  String get noProductsFound => 'محصولی یافت نشد.';

  @override
  String authorWithValue(Object author) {
    return 'نویسنده: $author';
  }

  @override
  String translatorWithValue(Object translator) {
    return 'مترجم: $translator';
  }

  @override
  String narratorWithValue(Object narrator) {
    return 'گوینده: $narrator';
  }

  @override
  String get speaker => 'گوینده';

  @override
  String publisherWithValue(Object publisher) {
    return 'ناشر: $publisher';
  }

  @override
  String get applyFilter => 'اعمال فیلتر';

  @override
  String get selectAuthor => 'انتخاب نویسنده';

  @override
  String get searchAuthors => 'جستجو در نویسنده‌ها...';

  @override
  String get noAuthorFound => 'نویسنده‌ای یافت نشد.';

  @override
  String get confirm => 'تایید';

  @override
  String searchInWithValue(Object title) {
    return 'جستجو در $title...';
  }

  @override
  String noneFoundWithValue(Object title) {
    return '${title}ی یافت نشد.';
  }

  @override
  String get chapterDetails => 'جزئیات سرفصل';

  @override
  String notesCount(Object count) {
    return '$count یادداشت';
  }

  @override
  String get noNotes => 'یادداشتی وجود ندارد';

  @override
  String get noNotesInChapter => 'هنوز هیچ یادداشتی در این سرفصل ثبت نشده است';

  @override
  String get readMore => 'بیشتر بخوانید';

  @override
  String get analysis => 'تحلیل';

  @override
  String get edit => 'ویرایش';

  @override
  String get delete => 'حذف';

  @override
  String get editNote => 'ویرایش یادداشت';

  @override
  String get yourNote => 'یادداشت شما';

  @override
  String get noteAboutClippingHint => 'یادداشت یا توضیحی درباره این بریده...';

  @override
  String get save => 'ذخیره';

  @override
  String get deleteNote => 'حذف یادداشت';

  @override
  String get confirmDeleteNote => 'آیا از حذف این یادداشت اطمینان دارید؟';

  @override
  String get chapterNotFound => 'سرفصل مورد نظر یافت نشد. ممکن است این سرفصل حذف شده باشد یا شما دسترسی به آن ندارید.';

  @override
  String errorLoadingDetailsWithMessage(Object error) {
    return 'خطا در بارگذاری جزئیات: $error';
  }

  @override
  String errorUpdatingNoteWithMessage(Object error) {
    return 'خطا در به‌روزرسانی یادداشت: $error';
  }

  @override
  String errorDeletingNoteWithMessage(Object error) {
    return 'خطا در حذف یادداشت: $error';
  }

  @override
  String errorSelectingImageWithMessage(Object error) {
    return 'خطا در انتخاب تصویر: $error';
  }

  @override
  String get pleaseSelectCategoryFormal => 'لطفاً دسته‌بندی را انتخاب کنید';

  @override
  String get createNewChapter => 'ایجاد سرفصل جدید';

  @override
  String get editChapter => 'ویرایش سرفصل';

  @override
  String get close => 'بستن';

  @override
  String get chapterTitle => 'عنوان سرفصل';

  @override
  String get chapterTitleExample => 'مثلاً: هوش مصنوعی';

  @override
  String get titleRequired => 'عنوان الزامی است';

  @override
  String get titleMinLength => 'عنوان باید حداقل ۳ کاراکتر باشد';

  @override
  String get descriptionOptional => 'توضیحات (اختیاری)';

  @override
  String get description => 'توضیحات';

  @override
  String get chapterDescriptionHint => 'توضیح کوتاه درباره این سرفصل';

  @override
  String get category => 'دسته‌بندی';

  @override
  String get imageOptional => 'تصویر (اختیاری)';

  @override
  String get changeImage => 'تغییر تصویر';

  @override
  String get selectImage => 'انتخاب تصویر';

  @override
  String get enterApp => 'ورود به برنامه';

  @override
  String get giftCard => 'کارت هدیه';

  @override
  String get confirmAndPay => 'تایید و پرداخت';

  @override
  String get recipientPhoneRequired => 'شماره موبایل مقصد*';

  @override
  String get amountInRial => 'مبلغ به ریال';

  @override
  String get sendGiftCardToOthers => 'ارسال کارت هدیه به دیگران';

  @override
  String get pleaseEnterPhoneNumber => 'لطفا شماره تلفن را وارد کنید';

  @override
  String get phoneMustStartWith09 => 'شماره باید با 09 شروع شود';

  @override
  String get phoneNumberInvalid => 'شماره مورد نظر معتبر نمی باشد';

  @override
  String get rialArabic => 'ريال';

  @override
  String get mobileNumber => 'شماره موبایل';

  @override
  String get paymentAmount => 'هزینه پرداختی';

  @override
  String amountRial(Object amount) {
    return '$amount ریال';
  }

  @override
  String giftCardSentToNumber(Object phone) {
    return 'کارت هدیه شما با موفقیت\n برای شماره $phone ارسال شد! 🤩';
  }

  @override
  String get giftSentSuccessfully => 'هدیه با موفقیت ارسال شد!';

  @override
  String get giftToOthers => 'هدیه به دیگران';

  @override
  String get bookName => 'نام کتاب';

  @override
  String get subject => 'موضوع';

  @override
  String get classification => 'رده‌بندی';

  @override
  String get pay => 'پرداخت';

  @override
  String get successful => 'موفق';

  @override
  String get retry => 'تلاش مجدد';

  @override
  String bookByAuthorPublisher(Object bookName, Object author, Object publisher) {
    return 'کتاب $bookName اثر $author انتشارات $publisher';
  }

  @override
  String bookClassificationWithValue(Object classification) {
    return 'رده‌بندی کتاب: $classification';
  }

  @override
  String get tomanWithSpace => ' تومان';

  @override
  String get friendMobileNumber => 'شماره موبایل دوستتان';

  @override
  String get noContent => 'محتوایی وجود ندارد';

  @override
  String get noContentToShow => 'در حال حاضر محتوایی برای نمایش وجود ندارد';

  @override
  String get currentlyReading => 'در حال مطالعه';

  @override
  String get categories => 'دسته‌بندی‌ها';

  @override
  String get newestProducts => 'جدیدترین محصولات';

  @override
  String get featuredProducts => 'محصولات ویژه';

  @override
  String get suggestedProducts => 'محصولات پیشنهادی';

  @override
  String get weeklySuggestion => 'پیشنهاد هفته';

  @override
  String get newTextBooks => 'تازه های متنی';

  @override
  String get newAudioBooks => 'تازه های صوتی';

  @override
  String get pdfNotAvailable => 'فایل PDF در دسترس نیست';

  @override
  String get errorFetchingHome => 'خطا در دریافت اطلاعات صفحه اصلی';

  @override
  String get introLoremIpsum => 'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد. کتابهای زیادی در شصت و سه درصد گذشته، حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد ';

  @override
  String get nextStep => 'مرحله بعدی';

  @override
  String get invited => 'دعوت شده';

  @override
  String get inviteFriends => 'دعوت از دوستان';

  @override
  String get invite => 'دعوت';

  @override
  String get rewards => 'جوایز';

  @override
  String get inviteCodeUnavailable => 'کد دعوت در دسترس نیست';

  @override
  String get invitedFriendsList => 'لیست دوستان دعوت شده';

  @override
  String totalPeopleCount(Object count) {
    return 'تعداد کل: $count نفر';
  }

  @override
  String get noInvitations => 'دعوتی ثبت نشده';

  @override
  String get noFriendsInvitedYet => 'هنوز هیچ دوستی را دعوت نکرده‌اید';

  @override
  String get noRewards => 'جایزه‌ای وجود ندارد';

  @override
  String get noRewardsToShow => 'هنوز جایزه‌ای برای نمایش وجود ندارد';

  @override
  String get inviteFriendsReadFree => '📚 دوستانت رو دعوت کن و\n یک ماه رایگان بخون!';

  @override
  String get inviteFriendsDescription => 'با دعوت از دوستانت به اپلیکیشن کتاب‌خوان، شما و دوستتون هر کدوم یک ماه اشتراک رایگان هدیه می‌گیرین! فقط کافیه کد دعوت رو برای اون‌ها بفرستی، تا به دنیای جذاب کتاب‌ها وارد بشن.';

  @override
  String get inviteCodeCopied => 'کد دعوت کپی شد!';

  @override
  String get copy => 'کپی کن';

  @override
  String get noFriendInvitedYet => 'هنوز دوستی دعوت نکرده‌اید';

  @override
  String get inviteFriendsBothGetFreeMonth => 'با دعوت از دوستانتان، هر دو نفر یک ماه اشتراک رایگان دریافت خواهید کرد!';

  @override
  String get shareYourInviteCode => 'کد دعوت خود را به اشتراک بگذارید';

  @override
  String invitationDateWithValue(Object date) {
    return 'تاریخ دعوت: $date';
  }

  @override
  String get noRewardsReceivedYet => 'هنوز جایزه‌ای دریافت نکرده‌اید';

  @override
  String get inviteFriendsGetRewards => 'با دعوت از دوستانتان و استفاده از کد دعوت، جوایز ارزشمندی دریافت خواهید کرد!';

  @override
  String get receivedRewards => 'جوایز دریافتی';

  @override
  String totalRewardsCount(Object count) {
    return 'تعداد کل: $count جایزه';
  }

  @override
  String trackingCodeWithValue(Object code) {
    return 'کد پیگیری: $code';
  }

  @override
  String receivedDateWithValue(Object date) {
    return 'تاریخ دریافت: $date';
  }

  @override
  String get errorLoadingShelf => 'خطا در بارگذاری قفسه';

  @override
  String get shelfIsEmpty => 'این قفسه خالی است';

  @override
  String get addFavoriteBooksToShelf => 'کتاب‌های مورد علاقه خود را به این قفسه اضافه کنید';

  @override
  String get shelfBooks => 'کتاب‌های قفسه';

  @override
  String booksCount(Object count) {
    return '$count کتاب';
  }

  @override
  String get audio => 'صوتی';

  @override
  String get text => 'متنی';

  @override
  String get progress => 'پیشرفت';

  @override
  String get bookClippingComments => 'نظرات بریده کتاب';

  @override
  String get errorLoadingComments => 'خطا در بارگذاری نظرات';

  @override
  String get noCommentsYet => 'هنوز نظری ثبت نشده است';

  @override
  String get beFirstToComment => 'اولین نفری باشید که نظر می‌دهد';

  @override
  String get noBookFound => 'کتابی پیدا نشد!';

  @override
  String get noBooksInLibraryYet => 'هنوز هیچ کتابی به کتابخانه شما اضافه نشده است';

  @override
  String get myShelves => 'قفسه های من';

  @override
  String get appShelves => 'قفسه های دانشگاه امام صادق (ع)';

  @override
  String get noTextBooksInLibrary => 'هیچ کتاب متنی در کتابخانه شما وجود ندارد';

  @override
  String get noAudioBooksInLibrary => 'هیچ کتاب صوتی در کتابخانه شما وجود ندارد';

  @override
  String get noBooksFound => 'هیچ کتابی پیدا نشد';

  @override
  String get electronic => 'الکترونیک';

  @override
  String errorLoadingChaptersWithMessage(Object error) {
    return 'خطا در بارگذاری سرفصل‌ها: $error';
  }

  @override
  String errorCreatingChapterWithMessage(Object error) {
    return 'خطا در ایجاد سرفصل: $error';
  }

  @override
  String errorUpdatingChapterWithMessage(Object error) {
    return 'خطا در به‌روزرسانی سرفصل: $error';
  }

  @override
  String errorDeletingChapterWithMessage(Object error) {
    return 'خطا در حذف سرفصل: $error';
  }

  @override
  String get myNoteCards => 'فیش‌های من';

  @override
  String get noChapters => 'سرفصلی وجود ندارد';

  @override
  String get noChaptersCreatedYet => 'هنوز هیچ سرفصلی ایجاد نکرده‌اید';

  @override
  String get deleteChapter => 'حذف سرفصل';

  @override
  String confirmDeleteItem(Object title) {
    return 'آیا از حذف "$title" اطمینان دارید؟';
  }

  @override
  String get today => 'امروز';

  @override
  String get yesterday => 'دیروز';

  @override
  String daysAgo(Object days) {
    return '$days روز پیش';
  }

  @override
  String get myClippings => 'بریده‌های من';

  @override
  String get noClippingsSavedYet => 'هنوز هیچ بریده‌ای از کتاب‌ها ذخیره نکرده‌اید';

  @override
  String get likedByUser => '  پسندیده شده توسط کاربر';

  @override
  String get commentSubmittedSuccessfully => 'نظر شما با موفقیت ثبت شد';

  @override
  String get myComments => 'نظر های من';

  @override
  String get yourComment => 'نظر شما';

  @override
  String get pleaseEnterComment => 'لطفا نظر خود را وارد کنید';

  @override
  String get yes => 'بله';

  @override
  String get no => 'خیر';

  @override
  String get sending => 'در حال ارسال...';

  @override
  String get submitComment => 'ثبت نظر';

  @override
  String get howWasYourReadingExperience => 'تجربه شما از مطالعه این کتاب\n چطور بود؟';

  @override
  String get helpOthersReadBetter => 'به دیگران برای مطالعه بهتر کمک کنید';

  @override
  String get doYouRecommendBook => 'این کتاب را به دیگران توصیه می کنید؟';

  @override
  String get notSure => 'مطمئن نیستم';

  @override
  String get pleaseEnterRating => 'لطفا امتیاز خود را وارد کنید';

  @override
  String get iRecommend => 'توصیه می کنم';

  @override
  String get iDontRecommend => 'توصیه نمیکنم';

  @override
  String get noCommentSubmitted => 'نظری ثبت نشده';

  @override
  String get noCommentsForBooksYet => 'هنوز نظری برای کتاب‌ها ثبت نکرده‌اید';

  @override
  String get unknownBookName => 'نام کتاب نامشخص';

  @override
  String get myPurchases => 'خرید های من';

  @override
  String get viewAll => 'مشاهده همه';

  @override
  String get noPurchases => 'خریدی وجود ندارد';

  @override
  String get trackingCode => 'کد پیگیری';

  @override
  String get purchaseDate => 'تاریخ خرید';

  @override
  String get discount => 'تخفیف';

  @override
  String get myShelvesTitle => 'قفسه‌های من';

  @override
  String get createNewShelf => 'ساخت قفسه جدید';

  @override
  String get errorLoadingShelves => 'خطا در بارگذاری قفسه‌ها';

  @override
  String get noShelvesCreatedYet => 'شما هنوز قفسه‌ای نساخته‌اید';

  @override
  String get createShelfFirstToAddBooks => 'برای افزودن کتاب به قفسه، ابتدا یک قفسه جدید بسازید';

  @override
  String get createShelf => 'ساخت قفسه';

  @override
  String get writeShelfName => 'نام قفسه را بنویسید';

  @override
  String get submit => 'ثبت';

  @override
  String get deleteShelf => 'حذف قفسه';

  @override
  String confirmDeleteShelf(Object name) {
    return 'آیا مطمئن هستید که می‌خواهید قفسه "$name" را حذف کنید؟';
  }

  @override
  String get latestBooks => 'آخرین کتاب‌ها:';

  @override
  String moreBooksCount(Object count) {
    return '+$count کتاب دیگر';
  }

  @override
  String get shelfEmpty => 'قفسه خالی است';

  @override
  String get subscriptionHistory => 'سابقه اشتراک';

  @override
  String get activeSubscription => 'اشتراک فعال';

  @override
  String get appSubscription => 'اشتراک دانشگاه امام صادق (ع)';

  @override
  String get subscriptionDescription => 'با خرید اشتراک کتاب‌خوان، به دنیایی از کتاب‌های الکترونیکی و صوتی دسترسی پیدا کنید. تجربه‌ای بی‌نظیر برای عاشقان کتاب، هرجا و هرزمان!';

  @override
  String get activeSubscriptions => 'اشتراک‌های فعال';

  @override
  String get startDate => 'تاریخ شروع:';

  @override
  String get expiryDate => 'تاریخ انقضا:';

  @override
  String get buyPremiumSubscription => 'خرید اشتراک ویژه';

  @override
  String get expiredSubscriptions => 'اشتراک‌های منقضی شده';

  @override
  String get noExpiredSubscriptions => 'اشتراک منقضی شده‌ای ندارید';

  @override
  String openLinkInBrowser(Object url) {
    return 'لطفاً این لینک را در مرورگر باز کنید: $url';
  }

  @override
  String get paymentVerificationFailed => 'تایید پرداخت ناموفق بود. لطفاً دوباره تلاش کنید.';

  @override
  String get paymentType => 'نوع پرداخت';

  @override
  String get amount => 'مبلغ';

  @override
  String get errorMessage => 'پیام خطا';

  @override
  String get paymentSuccessful => 'پرداخت موفق';

  @override
  String get paymentFailed => 'پرداخت ناموفق';

  @override
  String get paymentExpired => 'زمان پرداخت منقضی شده';

  @override
  String get paymentCancelled => 'پرداخت لغو شد';

  @override
  String get paymentError => 'خطا در پرداخت';

  @override
  String get paymentSuccessDescription => 'پرداخت شما با موفقیت انجام شد و خرید شما ثبت گردید';

  @override
  String get paymentFailedDescription => 'متاسفانه پرداخت شما با موفقیت انجام نشد. لطفا دوباره تلاش کنید';

  @override
  String get paymentExpiredDescription => 'زمان پرداخت شما به پایان رسیده است. لطفا دوباره تلاش کنید';

  @override
  String get paymentCancelledDescription => 'پرداخت توسط شما لغو شد';

  @override
  String get paymentErrorDescription => 'خطایی در هنگام پردازش پرداخت رخ داد';

  @override
  String get backToHome => 'بازگشت به صفحه اصلی';

  @override
  String get bookPurchase => 'خرید کتاب';

  @override
  String get giftCardPurchase => 'خرید کارت هدیه';

  @override
  String get walletCharge => 'شارژ کیف پول';

  @override
  String get viewMyBooks => 'مشاهده کتاب های من';

  @override
  String get viewMySubscriptions => 'مشاهده اشتراک های من';

  @override
  String get viewGiftCards => 'مشاهده کارت های هدیه';

  @override
  String get viewWallet => 'مشاهده کیف پول';

  @override
  String get paymentDone => 'پرداخت با موفقیت انجام شد';

  @override
  String get orderNumber => 'شماره سفارش';

  @override
  String get transactionId => 'شناسه تراکنش';

  @override
  String get purchasedItems => 'اقلام خریداری شده';

  @override
  String itemsCountTapToView(Object count) {
    return '$count مورد - برای مشاهده کلیک کنید';
  }

  @override
  String get unknown => 'نامشخص';

  @override
  String productWithValue(Object productId) {
    return 'محصول $productId';
  }

  @override
  String productIdWithValue(Object productId) {
    return 'شناسه محصول: $productId';
  }

  @override
  String get purchased => 'خریداری شده';

  @override
  String get totalPayment => 'مجموع پرداخت';

  @override
  String itemsCount(Object count) {
    return '$count مورد';
  }

  @override
  String get viewPaymentHistory => 'مشاهده سوابق پرداخت';

  @override
  String get paymentHistory => 'تاریخچه پرداخت ها';

  @override
  String get dateLabel => 'تاریخ:';

  @override
  String get purchaseLabel => 'خرید:';

  @override
  String get amountLabel => 'مبلغ:';

  @override
  String amountTomanTrailing(Object amount) {
    return '$amount تومان ';
  }

  @override
  String get viaLabel => 'از طریق:';

  @override
  String get statusLabel => 'وضعیت:';

  @override
  String get trackingCodeLabel => 'کد پیگیری:';

  @override
  String get discountLabel => 'تخفیف:';

  @override
  String get store => 'فروشگاه';

  @override
  String get noPurchasesYet => 'تا به حال هیچ خریدی نکرده‌ای.';

  @override
  String get paymentHistoryHint => 'در اینجا می‌توانی تاریخچه‌ی تراکنش هات رو ببینی';

  @override
  String get personalDevelopmentBooks => 'کتاب های توسعه فردی';

  @override
  String get filters => 'فیلترها';

  @override
  String get textBooks => 'کتاب‌های متنی';

  @override
  String get audioBooks => 'کتاب‌های صوتی';

  @override
  String get authorTranslatorNarrator => 'نویسنده، مترجم یا گوینده';

  @override
  String get drivingMode => 'حالت رانندگی';

  @override
  String get stopPlaybackAfter => 'توقف پخش بعد از...';

  @override
  String get oneMinuteTest => '۱ دقیقه (تست)';

  @override
  String get fifteenMinutes => '۱۵ دقیقه';

  @override
  String get twentyMinutes => '۲۰ دقیقه';

  @override
  String get thirtyMinutes => '۳۰ دقیقه';

  @override
  String get fortyFiveMinutes => '۴۵ دقیقه';

  @override
  String get oneHour => '۱ ساعت';

  @override
  String get endOfThisSection => 'پایان این بخش';

  @override
  String get playbackSpeed => 'سرعت پخش';

  @override
  String normalSpeed(Object speed) {
    return '$speed.0X (نرمال)';
  }

  @override
  String get someTracksNotDownloaded => 'برخی ترک‌ها دانلود نشدند.';

  @override
  String percentListened(Object percent) {
    return '$percent% شنیده‌اید';
  }

  @override
  String get someTracksNotDownloadedColon => 'برخی ترک‌ها دانلود نشدند:';

  @override
  String get retryFailedTracksOnly => 'تلاش مجدد فقط برای ترک‌های ناموفق';

  @override
  String get allTracksDownloaded => 'همه ترک‌ها با موفقیت دانلود شدند!';

  @override
  String get downloadAll => 'دانلود همه';

  @override
  String get noteSavedSuccessfully => 'یادداشت با موفقیت ذخیره شد';

  @override
  String errorSavingNoteWithMessage(Object error) {
    return 'خطا در ذخیره یادداشت: $error';
  }

  @override
  String get bookAddedToBookmarks => 'کتاب به بوکمارک اضافه شد';

  @override
  String get bookRemovedFromBookmarks => 'کتاب از بوکمارک حذف شد';

  @override
  String errorBookmarkingWithMessage(Object error) {
    return 'خطا در بوکمارک کردن: $error';
  }

  @override
  String get clippingSavedSuccessfully => 'بریده کتاب با موفقیت ذخیره شد';

  @override
  String errorSavingClippingWithMessage(Object error) {
    return 'خطا در ذخیره بریده کتاب: $error';
  }

  @override
  String errorDownloadingBookWithMessage(Object error) {
    return 'خطا در دانلود کتاب: $error';
  }

  @override
  String get errorSharing => 'خطا در اشتراک‌گذاری';

  @override
  String get note => 'یادداشت';

  @override
  String get productNotFound => 'محصول یافت نشد';

  @override
  String get productNotAvailable => 'محصول مورد نظر در دسترس نیست';

  @override
  String get shareBook => 'اشتراک‌گذاری کتاب';

  @override
  String get aboutBook => 'درباره کتاب';

  @override
  String get tags => 'برچسب‌ها';

  @override
  String get tag => 'تگ';

  @override
  String get userReviews => 'نظرات کاربران';

  @override
  String get otherBooksByAuthor => 'کتاب‌های دیگر این نویسنده';

  @override
  String get otherBooksByPublisher => 'کتاب‌های دیگر این ناشر';

  @override
  String get relatedBooks => 'کتاب‌های مرتبط';

  @override
  String get play => 'پخش';

  @override
  String get read => 'مطالعه';

  @override
  String get contentTypeUnknown => 'نوع محتوا نامشخص است';

  @override
  String get audioFileNotAvailable => 'فایل صوتی در دسترس نیست';

  @override
  String get bookFileNotAvailable => 'فایل کتاب در دسترس نیست';

  @override
  String get productAlreadyInCart => 'این محصول قبلاً در سبد خرید شما وجود دارد';

  @override
  String addedToCartWithName(Object name) {
    return '$name به سبد خرید اضافه شد';
  }

  @override
  String get view => 'مشاهده';

  @override
  String get errorAddingToCart => 'خطا در افزودن به سبد خرید';

  @override
  String fromReviewsCount(Object count) {
    return 'از $count نظر';
  }

  @override
  String get premiumAccess => 'دسترسی پریمیوم';

  @override
  String get addToShelf => 'افزودن به قفسه';

  @override
  String get viewCart => 'مشاهده سبد خرید';

  @override
  String get addToCart => 'افزودن به سبد خرید';

  @override
  String get loading => 'در حال بارگذاری...';

  @override
  String get readSample => 'مطالعه نمونه';

  @override
  String get continueReading => 'ادامه مطلب';

  @override
  String get fullDescription => 'توضیحات کامل';

  @override
  String get tableOfContents => 'فهرست مطالب';

  @override
  String get viewBookInfo => 'مشاهده اطلاعات کتاب';

  @override
  String get helpful => 'مفید بود';

  @override
  String get notHelpful => 'مفید نبود';

  @override
  String get whatIsYourOpinion => 'نظر شما چیست؟';

  @override
  String get bookAddedToShelf => 'کتاب با موفقیت به قفسه اضافه شد';

  @override
  String get createNewShelfTitle => 'ایجاد قفسه جدید';

  @override
  String get enterShelfName => 'نام قفسه را وارد کنید';

  @override
  String get create => 'ایجاد';

  @override
  String get errorLoadingProfileCheckInternet => 'خطا در بارگذاری اطلاعات پروفایل. لطفا اتصال اینترنت خود را بررسی کنید.';

  @override
  String errorLoadingProfileWithMessage(Object error) {
    return 'خطا در بارگذاری اطلاعات پروفایل: $error';
  }

  @override
  String get profileManagement => 'مدیریت پروفایل';

  @override
  String get errorLoadingProfile => 'خطا در بارگذاری پروفایل';

  @override
  String get selectImageSource => 'انتخاب منبع تصویر';

  @override
  String get camera => 'دوربین';

  @override
  String get gallery => 'گالری';

  @override
  String get imageFileNotFound => 'فایل تصویر یافت نشد';

  @override
  String get imageMaxSize10Mb => 'حجم فایل تصویر نباید بیشتر از ۱۰ مگابایت باشد';

  @override
  String get editImage => 'ویرایش تصویر';

  @override
  String get imageSelectedWithoutEditing => 'تصویر بدون ویرایش انتخاب شد';

  @override
  String get errorSelectingImage => 'خطا در انتخاب تصویر';

  @override
  String get errorEditingImage => 'خطا در ویرایش تصویر. لطفا تصویر دیگری انتخاب کنید';

  @override
  String get galleryCameraPermissionDenied => 'دسترسی به گالری یا دوربین داده نشده است';

  @override
  String get unsupportedImageFormat => 'فرمت تصویر پشتیبانی نمی‌شود. لطفا تصویر JPG یا PNG انتخاب کنید';

  @override
  String get errorReadingImage => 'خطا در خواندن فایل تصویر. لطفا تصویر دیگری انتخاب کنید';

  @override
  String get invalidImageFormat => 'فرمت تصویر نامعتبر است. لطفا تصویر معتبری انتخاب کنید';

  @override
  String get minimumAge10 => 'سن شما باید حداقل ۱۰ سال باشد';

  @override
  String get invalidBirthDate => 'تاریخ تولد نامعتبر است';

  @override
  String get imageTooLarge => 'حجم تصویر بسیار بزرگ است. لطفا تصویر کوچکتری انتخاب کنید';

  @override
  String get errorProcessingImage => 'خطا در پردازش تصویر. لطفا تصویر دیگری انتخاب کنید';

  @override
  String get firstName => 'نام';

  @override
  String get lastName => 'نام خانوادگی';

  @override
  String get passwordOptional => 'رمز عبور (اختیاری)';

  @override
  String get enterNewPasswordToChange => 'برای تغییر رمز عبور، رمز جدید را وارد کنید';

  @override
  String get gender => 'جنسیت';

  @override
  String get male => 'مرد';

  @override
  String get female => 'زن';

  @override
  String get birthDate => 'تاریخ تولد';

  @override
  String get selectDate => 'انتخاب تاریخ';

  @override
  String get aboutMeOptional => 'درباره من (اختیاری)';

  @override
  String get saveInformation => 'ذخیره اطلاعات';

  @override
  String get monthFarvardin => 'فروردین';

  @override
  String get monthOrdibehesht => 'اردیبهشت';

  @override
  String get monthKhordad => 'خرداد';

  @override
  String get monthTir => 'تیر';

  @override
  String get monthMordad => 'مرداد';

  @override
  String get monthShahrivar => 'شهریور';

  @override
  String get monthMehr => 'مهر';

  @override
  String get monthAban => 'آبان';

  @override
  String get monthAzar => 'آذر';

  @override
  String get monthDey => 'دی';

  @override
  String get monthBahman => 'بهمن';

  @override
  String get monthEsfand => 'اسفند';

  @override
  String get selectBirthDate => 'انتخاب تاریخ تولد';

  @override
  String get year => 'سال';

  @override
  String get month => 'ماه';

  @override
  String get day => 'روز';

  @override
  String get noPublicChaptersYet => 'هنوز هیچ سرفصل عمومی‌ای ایجاد نشده است';

  @override
  String get user => 'کاربر';

  @override
  String get replyToBookClipping => 'پاسخ به بریده کتاب';

  @override
  String get send => 'ارسال';

  @override
  String get reviewsAndRatings => 'نقدها و امتیازها';

  @override
  String get submitReviewAndRating => 'ثبت نقد و امتیاز';

  @override
  String get shareOpinion => 'اشتراک دیدگاه';

  @override
  String get uploadProduct => 'آپلود محصول';

  @override
  String get searchMarketplace => 'جستجو در بازارچه';

  @override
  String get noProductsInMarketplace => 'در حال حاضر محصولی در بازارچه موجود نیست';

  @override
  String get handouts => 'جزوات';

  @override
  String get educationalContent => 'محتوای آموزشی';

  @override
  String get questionBank => 'بانک سوالات';

  @override
  String get periodical => 'گاهنامه';

  @override
  String get quarterly => 'فصلنامه';

  @override
  String get monthlyMagazine => 'ماهنامه';

  @override
  String get yearbook => 'سالنامه';

  @override
  String productsCount(Object count) {
    return '$count محصول';
  }

  @override
  String get studyTourNotFound => 'سیر مطالعاتی مورد نظر یافت نشد';

  @override
  String errorLoadingStudyTourDetailsWithMessage(Object error) {
    return 'خطا در بارگذاری جزئیات سیر مطالعاتی: $error';
  }

  @override
  String get twoMonths => '۲ ماه';

  @override
  String get fourMonths => '۴ ماه';

  @override
  String get sixMonths => '۶ ماه';

  @override
  String get eightMonths => '۸ ماه';

  @override
  String get studyTour => 'سیر مطالعاتی';

  @override
  String get booksCountLabel => 'تعداد کتاب‌ها';

  @override
  String get studyRoute => 'مسیر مطالعاتی';

  @override
  String errorLoadingStudyToursWithMessage(Object error) {
    return 'خطا در بارگذاری سیر مطالعاتی‌ها: $error';
  }

  @override
  String get myStudyTours => 'سیر مطالعاتی من';

  @override
  String get noStudyToursYet => 'هنوز سیر مطالعاتی ثبت نکرده‌اید';

  @override
  String get submitFirstStudyTour => 'اولین سیر مطالعاتی خود را ثبت کنید';

  @override
  String get submitStudyTour => 'ثبت سیر مطالعاتی';

  @override
  String get providedAnswer => 'پاسخ ارائه شده:';

  @override
  String get pending => 'در انتظار';

  @override
  String get approved => 'تایید شده';

  @override
  String get rejected => 'رد شده';

  @override
  String get errorLoadingCategories => 'خطا در بارگذاری دسته‌بندی‌ها';

  @override
  String get studyTourRequest => 'درخواست سیر مطالعاتی';

  @override
  String get designYourStudyTour => 'سیر مطالعاتی خود را طراحی کنید';

  @override
  String get studyTourRequestHint => 'موضوع مورد نظر خود را انتخاب کنید و درخواست سیر مطالعاتی خود را ثبت کنید';

  @override
  String get studyTourTitle => 'عنوان سیر مطالعاتی';

  @override
  String get studyTourTitleExample => 'مثال: سیر مطالعاتی تاریخ ایران';

  @override
  String get studyTourDescriptionHint => 'توضیحات خود را در مورد سیر مطالعاتی مورد نظر بنویسید...';

  @override
  String get submitRequest => 'ثبت درخواست';

  @override
  String get noBookFoundPlain => 'هیچ کتابی یافت نشد';

  @override
  String get textBooksTitle => 'کتاب های متنی';

  @override
  String get productUploadedSuccessfully => 'محصول با موفقیت آپلود شد';

  @override
  String errorSelectingFileWithMessage(Object error) {
    return 'خطا در انتخاب فایل: $error';
  }

  @override
  String errorSelectingSampleFileWithMessage(Object error) {
    return 'خطا در انتخاب فایل نمونه: $error';
  }

  @override
  String get pleaseSelectMainFile => 'لطفا فایل اصلی را انتخاب کنید';

  @override
  String get pleaseSelectCategory => 'لطفا دسته‌بندی را انتخاب کنید';

  @override
  String get pleaseSelectProductImage => 'لطفا تصویر محصول را انتخاب کنید';

  @override
  String get uploadAnswerSheetOrHandout => 'آپلود پاسخنامه یا جزوه';

  @override
  String get contentType => 'نوع محتوا';

  @override
  String get productName => 'نام محصول';

  @override
  String get productNameExample => 'مثال: جزوه ریاضی پایه دهم';

  @override
  String get pleaseEnterProductName => 'لطفا نام محصول را وارد کنید';

  @override
  String get pageCount => 'تعداد صفحات';

  @override
  String get pageCountExample => 'مثال: 30';

  @override
  String get pleaseEnterPageCount => 'لطفا تعداد صفحات را وارد کنید';

  @override
  String get pleaseEnterValidNumber => 'لطفا یک عدد معتبر وارد کنید';

  @override
  String get publishYear => 'سال انتشار';

  @override
  String get publishYearExample => 'مثال: 1402';

  @override
  String get pleaseEnterPublishYear => 'لطفا سال انتشار را وارد کنید';

  @override
  String get priceInToman => 'قیمت (تومان)';

  @override
  String get priceExample => 'مثال: 250,000';

  @override
  String get pleaseEnterPrice => 'لطفا قیمت را وارد کنید';

  @override
  String get enterProductDescription => 'توضیحات محصول را وارد کنید...';

  @override
  String get pleaseEnterDescription => 'لطفا توضیحات را وارد کنید';

  @override
  String get mainFileRequired => 'فایل اصلی *';

  @override
  String get selectFilePdfDoc => 'انتخاب فایل (PDF, DOC, DOCX)';

  @override
  String get sampleFileOptional => 'فایل نمونه (اختیاری)';

  @override
  String get selectSampleFile => 'انتخاب فایل نمونه';

  @override
  String get productImageRequired => 'تصویر محصول *';

  @override
  String get handout => 'جزوه';

  @override
  String get mySubscriptions => 'اشتراک های من';

  @override
  String get myCommentsMenu => 'نظرات من';

  @override
  String get myClippingsMenu => 'بریده های من';

  @override
  String get update => 'بروز رسانی';

  @override
  String get logout => 'خروج از حساب کاربری';

  @override
  String get walletChargedSuccessfully => 'کیف پول با موفقیت شارژ شد!';

  @override
  String get wallet => 'کیف پول';

  @override
  String get customAmountToman => 'مبلغ دلخواه (تومان)';

  @override
  String get activateGiftCard => 'فعالسازی کارت هدیه';

  @override
  String currentBalanceToman(Object amount) {
    return 'موجودی فعلی\n $amount تومان';
  }

  @override
  String get setAmount => ' تعیین مبلغ';

  @override
  String get pleaseSelectAtLeastOneChapter => 'لطفاً حداقل یک سرفصل انتخاب کنید';

  @override
  String get addToNoteCards => 'افزودن به فیش‌نویسی';

  @override
  String get selectedClipping => 'بریده انتخاب شده';

  @override
  String get selectChapter => 'انتخاب سرفصل';

  @override
  String chaptersSelectedCount(Object count) {
    return '$count سرفصل انتخاب شده';
  }

  @override
  String get noteOptional => 'یادداشت (اختیاری)';

  @override
  String get confirmFormal => 'تأیید';

  @override
  String confirmWithCount(Object count) {
    return 'تأیید ($count)';
  }

  @override
  String get createChapterFirstToAddNote => 'برای افزودن یادداشت، ابتدا باید یک سرفصل ایجاد کنید.';

  @override
  String get selectedClippingColon => 'بریده انتخاب شده:';

  @override
  String get selectChapterColon => 'انتخاب سرفصل:';

  @override
  String get yourNoteOptional => 'یادداشت شما (اختیاری)';

  @override
  String get unknownAuthor => 'نویسنده نا مشخص';

  @override
  String percentListenedSpaced(Object percent) {
    return '$percent٪ شنیده اید';
  }

  @override
  String percentRead(Object percent) {
    return '$percent٪ خوانده اید';
  }

  @override
  String get noCategoryFound => 'دسته‌بندی‌ای یافت نشد';

  @override
  String get fontYekanBakh => 'یکان باخ';

  @override
  String get fontVazir => 'وزیر';

  @override
  String get fontAnjoman => 'انجمن';

  @override
  String get fontIranYekan => 'ایران یکان';

  @override
  String get addToNoteCardsEmoji => '📝 افزودن به فیش‌نویسی';

  @override
  String get bookClippingEmoji => '📑 بریده کتاب';

  @override
  String get highlightYellow => '🟡 برجسته‌سازی زرد';

  @override
  String get highlightGreen => '🟢 برجسته‌سازی سبز';

  @override
  String get highlightOrange => '🟠 برجسته‌سازی نارنجی';

  @override
  String get highlightBlue => '🔵 برجسته‌سازی آبی';

  @override
  String get textHighlightedSuccessfully => 'متن با موفقیت برجسته شد';

  @override
  String get noReadableContent => 'محتوای قابل خواندن یافت نشد.';

  @override
  String get chapters => 'سرفصل‌ها';

  @override
  String get highlights => 'برجسته‌ها';

  @override
  String get saved => 'ذخیره شده‌ها';

  @override
  String get deleteAllHighlights => 'حذف همه برجسته‌ها';

  @override
  String pageNumber(Object page) {
    return 'صفحه $page';
  }

  @override
  String get gridView => 'نمای شبکه‌ای';

  @override
  String get previousPage => 'صفحه قبل';

  @override
  String pageProgress(Object page, Object totalPages, Object percent) {
    return '$page از $totalPages صفحه - $percent٪';
  }

  @override
  String get nextPage => 'صفحه بعد';

  @override
  String get chaptersAndHighlights => 'سرفصل‌ها و برجسته‌ها';

  @override
  String get book => 'کتاب';

  @override
  String get settings => 'تنظیمات';

  @override
  String get fontType => 'نوع فونت';

  @override
  String get fontSize => 'اندازه فونت';

  @override
  String get lineSpacing => 'فاصله خطوط';

  @override
  String get low => 'کم';

  @override
  String get high => 'زیاد';

  @override
  String get fontWeight => 'ضخامت فونت';

  @override
  String get normal => 'معمولی';

  @override
  String get medium => 'متوسط';

  @override
  String get bold => 'ضخیم';

  @override
  String get extraBold => 'خیلی ضخیم';

  @override
  String get displayMode => 'حالت نمایش';

  @override
  String get nightMode => 'حالت شب';

  @override
  String get readingDirection => 'جهت مطالعه';

  @override
  String get vertical => 'عمودی';

  @override
  String get switchToVerticalReading => 'تغییر جهت مطالعه به حالت عمودی';

  @override
  String get noReadableContentHtml => '<p>محتوای قابل خواندن یافت نشد.</p>';

  @override
  String get emptyBookHtml => '<p>کتاب خالی است.</p>';

  @override
  String get emptyBook => 'کتاب خالی است.';

  @override
  String get pdfFileNotFound => 'فایل PDF پیدا نشد';

  @override
  String errorLoadingPdfWithMessage(Object error) {
    return 'خطا در بارگذاری PDF: $error';
  }

  @override
  String errorDownloadingFileWithMessage(Object error) {
    return 'خطا در دانلود فایل: $error';
  }

  @override
  String get downloading => 'در حال دانلود...';

  @override
  String pageOfTotal(Object page, Object totalPages) {
    return 'صفحه $page از $totalPages';
  }

  @override
  String get connectionProblem => 'مشکل در اتصال';

  @override
  String get serverError => 'خطای سرور';

  @override
  String get connectionTimedOut => 'زمان اتصال تمام شد';

  @override
  String get notFound => 'یافت نشد';

  @override
  String get accessDenied => 'دسترسی ممنوع';

  @override
  String get invalidData => 'اطلاعات نامعتبر';

  @override
  String get errorOccurred => 'خطا رخ داده است';

  @override
  String get appTheme => 'پوسته برنامه';

  @override
  String get themeSystem => 'پیروی از سیستم';

  @override
  String get themeLight => 'روشن';

  @override
  String get themeDark => 'تیره';

  @override
  String get appLanguage => 'زبان برنامه';

  @override
  String get english => 'انگلیسی';

  @override
  String get uncategorized => 'بدون دسته‌بندی';

  @override
  String get unknownPublisher => 'ناشر نامشخص';
}
