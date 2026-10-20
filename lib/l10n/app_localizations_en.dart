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
  String get getStartedPageText => 'Here, every click begins a new journey; a journey that takes you into the heart of stories, secrets and the mysterious world of books.';

  @override
  String get appTitle => 'Imam Sadiq University';

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
  String get passwordMustBeAtLeast8Chars => 'Password must be at least 8 characters';

  @override
  String get profileUpdatedSuccessfully => 'Profile updated successfully';

  @override
  String get errorUpdatingProfile => 'Error updating profile';

  @override
  String get validationError => 'Validation error';

  @override
  String get errorSomethingWentWrong => 'Something went wrong. Please try again';

  @override
  String get errorNoInternet => 'No internet connection';

  @override
  String get errorServerTryAgain => 'A server error occurred. Please try again';

  @override
  String get errorConnectionTimeout => 'Connection timed out. Please try again';

  @override
  String get errorPleaseLoginAgain => 'Please log in again';

  @override
  String get errorUnauthorized => 'Unauthorized access';

  @override
  String get errorNotFound => 'The requested information was not found';

  @override
  String get errorInvalidInput => 'The entered information is invalid';

  @override
  String get errorServiceUnavailable => 'Service unavailable. Please try again later';

  @override
  String get errorOperationCancelled => 'Operation cancelled';

  @override
  String get errorInvalidRequestData => 'The submitted data is invalid. Please try again';

  @override
  String get errorFileTooLarge => 'The file is too large';

  @override
  String get errorUnsupportedFileFormat => 'File format is not supported';

  @override
  String get errorTooManyRequests => 'Too many requests. Please wait a moment';

  @override
  String get errorProcessingData => 'Error processing data';

  @override
  String get errorWrongPasswordOrPhone => 'Incorrect password or phone number';

  @override
  String get errorUserNotFound => 'No user found with this information';

  @override
  String get errorInvalidPhone => 'Invalid phone number';

  @override
  String get errorWrongVerificationCode => 'Incorrect verification code. Please enter the correct code';

  @override
  String get errorVerificationCodeExpired => 'Verification code has expired. Please request a new code';

  @override
  String get errorWrongInput => 'The entered information is incorrect';

  @override
  String get errorAlreadyRegistered => 'This information has already been registered';

  @override
  String get errorInsufficientBalance => 'Insufficient balance';

  @override
  String get errorPaymentProcessing => 'Error processing payment';

  @override
  String get errorServerTryLater => 'A server error occurred. Please try again later';

  @override
  String get authorBooks => 'Author\'s books';

  @override
  String get publisherBooks => 'Publisher\'s books';

  @override
  String unknownLinkReceived(Object link) {
    return 'Unknown link received: $link';
  }

  @override
  String get verifyingPayment => 'Verifying payment...';

  @override
  String get paymentVerifiedSuccessfully => 'Payment verified successfully!';

  @override
  String errorVerifyingPaymentWithMessage(Object error) {
    return 'Error verifying payment: $error';
  }

  @override
  String get paymentFailedMessage => 'Payment failed';

  @override
  String get paymentCancelledByUser => 'Payment was cancelled by the user';

  @override
  String get invalidBookLink => 'Invalid book link';

  @override
  String get invalidBookId => 'Invalid book ID';

  @override
  String get loadingBook => 'Loading book...';

  @override
  String get errorOpeningBook => 'Error opening book';

  @override
  String errorLoadingBookWithMessage(Object error) {
    return 'Error loading book: $error';
  }

  @override
  String get invalidClippingLink => 'Invalid clipping link';

  @override
  String get errorOpeningClipping => 'Error opening clipping';

  @override
  String get invalidPaymentParameters => 'Invalid payment parameters';

  @override
  String get paymentCompletedSuccessfully => 'Payment completed successfully!';

  @override
  String get paymentNotVerified => 'Payment was not verified';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get processingError => 'Processing error';

  @override
  String get unknownError => 'Unknown error';

  @override
  String get errorFetchingProfile => 'Error fetching profile information';

  @override
  String get active => 'Active';

  @override
  String get expiredStatus => 'Expired';

  @override
  String get daily => 'Daily';

  @override
  String get monthly => 'Monthly';

  @override
  String get yearly => 'Yearly';

  @override
  String get reserved => 'Reserved';

  @override
  String amountMillionToman(Object amount) {
    return '${amount}M Toman';
  }

  @override
  String amountThousandToman(Object amount) {
    return '${amount}K Toman';
  }

  @override
  String amountToman(Object amount) {
    return '$amount Toman';
  }

  @override
  String get used => 'Used';

  @override
  String get errorSavingNote => 'Error saving note';

  @override
  String get errorFetchingShop => 'Error fetching marketplace information';

  @override
  String unexpectedErrorWithMessage(Object error) {
    return 'Unexpected error: $error';
  }

  @override
  String get errorServerReturnedError => 'Server response error: the server returned an error';

  @override
  String get errorUploadingProduct => 'Error uploading product';

  @override
  String get appName => 'Imam Sadiq University';

  @override
  String get loginToApp => 'Log in to Imam Sadiq University';

  @override
  String get loginWithEmail => 'Log in with your email:';

  @override
  String get loginWithPhone => 'Log in with your mobile number:';

  @override
  String get login => 'Log in';

  @override
  String get or => 'or';

  @override
  String get terms => 'Terms';

  @override
  String get ofUsingApp => ' of using Imam Sadiq University';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get withPhoneNumber => 'With phone number';

  @override
  String get withEmail => 'With email';

  @override
  String get withGoogleAccount => 'With Google account';

  @override
  String get enteredNumberIncorrect => 'The entered number is incorrect';

  @override
  String get numberNotEntered => 'Number has not been entered';

  @override
  String get numberFormatIncorrect => 'Number format is incorrect';

  @override
  String get verificationCode => 'Verification code';

  @override
  String get enterYourPassword => 'Enter your password';

  @override
  String phoneNumberLabel(Object phone) {
    return 'Number: $phone';
  }

  @override
  String get editPhoneNumber => 'Edit phone number';

  @override
  String get pleaseEnterPassword => 'Please enter the password';

  @override
  String get loginWithOtp => 'Log in with one-time password';

  @override
  String get haveInviteCodeOptional => 'I have an invite code (optional)';

  @override
  String get sixDigitInviteCode => '6-digit invite code';

  @override
  String get errorInInputData => 'Error in input data';

  @override
  String get enterOtpSentToNumber => 'Enter the one-time code sent to the number below:';

  @override
  String get loginWithPassword => 'Log in with password';

  @override
  String get checking => 'Checking...';

  @override
  String get continueLabel => 'Continue';

  @override
  String get enterFiveDigitCode => 'Enter the 5-digit code';

  @override
  String get completeInformation => 'Complete information';

  @override
  String get pleaseSelectRoleAndCategory => 'Please select your role and category';

  @override
  String get yourRole => 'Your role:';

  @override
  String get student => 'Student';

  @override
  String get professor => 'Professor';

  @override
  String get categoryLabel => 'Category:';

  @override
  String get loggingIn => 'Logging in...';

  @override
  String get confirmAndLogin => 'Confirm and log in';

  @override
  String get selectCategory => 'Select category';

  @override
  String get searchCategory => 'Search categories...';

  @override
  String get categoryNotFound => 'Category not found';

  @override
  String get author => 'Author';

  @override
  String get searchAuthorTranslatorNarrator => 'Search author, translator or narrator';

  @override
  String get filter => 'Filter';

  @override
  String get clearFilter => 'Clear filter';

  @override
  String get categoriesShort => 'Categories';

  @override
  String get searchInApp => 'Search in Imam Sadiq University';

  @override
  String get mostPopularAudioBookCategories => 'Most popular audiobook categories';

  @override
  String sizeInMegabytes(Object size) {
    return '$size MB';
  }

  @override
  String get identifier => 'ID';

  @override
  String get format => 'Format';

  @override
  String get size => 'Size';

  @override
  String get duration => 'Duration';

  @override
  String get listSeparator => ',';

  @override
  String get translator => 'Translator';

  @override
  String get narrator => 'Narrator';

  @override
  String get publisher => 'Publisher';

  @override
  String get language => 'Language';

  @override
  String get persian => 'Persian';

  @override
  String get publishDate => 'Publication date';

  @override
  String get price => 'Price';

  @override
  String get readAndDownloadFile => 'Read and download file';

  @override
  String get inTheAppName => 'in the Imam Sadiq University app';

  @override
  String get searchPublisher => 'Search publishers';

  @override
  String clippingFromBook(Object bookName) {
    return 'A clipping from the book $bookName';
  }

  @override
  String errorSharingWithMessage(Object error) {
    return 'Error sharing: $error';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get share => 'Share';

  @override
  String get all => 'All';

  @override
  String get mostPopular => 'Most popular';

  @override
  String get hashtagSuccess => '#Success';

  @override
  String get hashtagPsychology => '#Psychology';

  @override
  String get bookTour => 'Book tour';

  @override
  String get noClippings => 'No clippings';

  @override
  String get noClippingsToShow => 'There are currently no clippings to show';

  @override
  String get newLabel => 'New';

  @override
  String bookWithName(Object bookName) {
    return 'Book $bookName';
  }

  @override
  String get more => 'More';

  @override
  String get less => 'Less';

  @override
  String get bookmarked => 'Bookmarked';

  @override
  String errorWithMessage(Object error) {
    return 'Error: $error';
  }

  @override
  String get noBookmarkedBooks => 'No bookmarked books!';

  @override
  String get noBookmarkedBooksYet => 'You haven\'t bookmarked any books yet';

  @override
  String get untitled => 'Untitled';

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get marketplace => 'Marketplace';

  @override
  String get categoriesTab => 'Categories';

  @override
  String get myBooks => 'My books';

  @override
  String get buySubscription => 'Buy subscription';

  @override
  String get faq => 'Frequently asked questions';

  @override
  String get faqPlaceholder => 'Answers to frequently asked questions go here...';

  @override
  String get termsAndConditions => 'Terms and conditions';

  @override
  String get subscriptionTermsPlaceholder => 'Subscription terms and conditions go here...';

  @override
  String get termsOfUse => 'Terms of use';

  @override
  String get subscriptionTermsOfUsePlaceholder => 'Subscription terms of use go here...';

  @override
  String errorProcessingPaymentWithMessage(Object error) {
    return 'Error processing payment: $error';
  }

  @override
  String get toman => 'Toman';

  @override
  String daysCount(Object days) {
    return '$days days';
  }

  @override
  String get cart => 'Shopping cart';

  @override
  String get paymentGatewayOpened => 'Payment gateway opened successfully';

  @override
  String get cartEmpty => 'Your shopping cart is empty';

  @override
  String get goHomeToBuyBooks => 'Go to the home page to buy books';

  @override
  String get goToHome => 'Go to home page';

  @override
  String get paymentMethod => 'Payment method';

  @override
  String get onlinePaymentGateway => 'Online payment gateway';

  @override
  String get payWithShetabCards => 'Pay with all Shetab member cards';

  @override
  String get invoice => 'Invoice';

  @override
  String get total => 'Total';

  @override
  String get yourSavings => 'Your savings on this purchase';

  @override
  String get payableAmount => 'Payable amount';

  @override
  String get processing => 'Processing...';

  @override
  String payAmountToman(Object amount) {
    return 'Pay - $amount Toman';
  }

  @override
  String get audioBook => 'Audiobook';

  @override
  String get textBook => 'Text book';

  @override
  String subjectWithValue(Object subject) {
    return 'Subject: $subject';
  }

  @override
  String get useDiscountCode => 'Use discount code';

  @override
  String get enterDiscountCode => 'Enter your discount code';

  @override
  String get apply => 'Apply';

  @override
  String get discountCodeApplied => 'Discount code applied successfully';

  @override
  String get filterLabel => 'Filter';

  @override
  String get bestSelling => 'Best selling';

  @override
  String get noProductsFound => 'No products found.';

  @override
  String authorWithValue(Object author) {
    return 'Author: $author';
  }

  @override
  String translatorWithValue(Object translator) {
    return 'Translator: $translator';
  }

  @override
  String narratorWithValue(Object narrator) {
    return 'Narrator: $narrator';
  }

  @override
  String get speaker => 'Narrator';

  @override
  String publisherWithValue(Object publisher) {
    return 'Publisher: $publisher';
  }

  @override
  String get applyFilter => 'Apply filter';

  @override
  String get selectAuthor => 'Select author';

  @override
  String get searchAuthors => 'Search authors...';

  @override
  String get noAuthorFound => 'No author found.';

  @override
  String get confirm => 'Confirm';

  @override
  String searchInWithValue(Object title) {
    return 'Search in $title...';
  }

  @override
  String noneFoundWithValue(Object title) {
    return 'No $title found.';
  }

  @override
  String get chapterDetails => 'Chapter details';

  @override
  String notesCount(Object count) {
    return '$count notes';
  }

  @override
  String get noNotes => 'No notes';

  @override
  String get noNotesInChapter => 'No notes have been added to this chapter yet';

  @override
  String get readMore => 'Read more';

  @override
  String get analysis => 'Analysis';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get editNote => 'Edit note';

  @override
  String get yourNote => 'Your note';

  @override
  String get noteAboutClippingHint => 'A note or comment about this clipping...';

  @override
  String get save => 'Save';

  @override
  String get deleteNote => 'Delete note';

  @override
  String get confirmDeleteNote => 'Are you sure you want to delete this note?';

  @override
  String get chapterNotFound => 'The chapter was not found. It may have been deleted or you may not have access to it.';

  @override
  String errorLoadingDetailsWithMessage(Object error) {
    return 'Error loading details: $error';
  }

  @override
  String errorUpdatingNoteWithMessage(Object error) {
    return 'Error updating note: $error';
  }

  @override
  String errorDeletingNoteWithMessage(Object error) {
    return 'Error deleting note: $error';
  }

  @override
  String errorSelectingImageWithMessage(Object error) {
    return 'Error selecting image: $error';
  }

  @override
  String get pleaseSelectCategoryFormal => 'Please select a category';

  @override
  String get createNewChapter => 'Create new chapter';

  @override
  String get editChapter => 'Edit chapter';

  @override
  String get close => 'Close';

  @override
  String get chapterTitle => 'Chapter title';

  @override
  String get chapterTitleExample => 'e.g. Artificial intelligence';

  @override
  String get titleRequired => 'Title is required';

  @override
  String get titleMinLength => 'Title must be at least 3 characters';

  @override
  String get descriptionOptional => 'Description (optional)';

  @override
  String get description => 'Description';

  @override
  String get chapterDescriptionHint => 'A short description of this chapter';

  @override
  String get category => 'Category';

  @override
  String get imageOptional => 'Image (optional)';

  @override
  String get changeImage => 'Change image';

  @override
  String get selectImage => 'Select image';

  @override
  String get enterApp => 'Enter the app';

  @override
  String get giftCard => 'Gift card';

  @override
  String get confirmAndPay => 'Confirm and pay';

  @override
  String get recipientPhoneRequired => 'Recipient mobile number*';

  @override
  String get amountInRial => 'Amount in Rial';

  @override
  String get sendGiftCardToOthers => 'Send a gift card to others';

  @override
  String get pleaseEnterPhoneNumber => 'Please enter the phone number';

  @override
  String get phoneMustStartWith09 => 'Number must start with 09';

  @override
  String get phoneNumberInvalid => 'The entered number is not valid';

  @override
  String get rialArabic => 'Rial';

  @override
  String get mobileNumber => 'Mobile number';

  @override
  String get paymentAmount => 'Payment amount';

  @override
  String amountRial(Object amount) {
    return '$amount Rial';
  }

  @override
  String giftCardSentToNumber(Object phone) {
    return 'Your gift card was successfully\n sent to $phone! 🤩';
  }

  @override
  String get giftSentSuccessfully => 'Gift sent successfully!';

  @override
  String get giftToOthers => 'Gift to others';

  @override
  String get bookName => 'Book name';

  @override
  String get subject => 'Subject';

  @override
  String get classification => 'Classification';

  @override
  String get pay => 'Pay';

  @override
  String get successful => 'Successful';

  @override
  String get retry => 'Try again';

  @override
  String bookByAuthorPublisher(Object bookName, Object author, Object publisher) {
    return 'The book $bookName by $author, $publisher Publications';
  }

  @override
  String bookClassificationWithValue(Object classification) {
    return 'Book classification: $classification';
  }

  @override
  String get tomanWithSpace => ' Toman';

  @override
  String get friendMobileNumber => 'Your friend\'s mobile number';

  @override
  String get noContent => 'No content';

  @override
  String get noContentToShow => 'There is currently no content to show';

  @override
  String get currentlyReading => 'Currently reading';

  @override
  String get categories => 'Categories';

  @override
  String get newestProducts => 'Newest products';

  @override
  String get featuredProducts => 'Featured products';

  @override
  String get suggestedProducts => 'Suggested products';

  @override
  String get weeklySuggestion => 'Suggestion of the week';

  @override
  String get newTextBooks => 'New text books';

  @override
  String get newAudioBooks => 'New audiobooks';

  @override
  String get pdfNotAvailable => 'PDF file is not available';

  @override
  String get errorFetchingHome => 'Error fetching home page information';

  @override
  String get introLoremIpsum => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.';

  @override
  String get nextStep => 'Next step';

  @override
  String get invited => 'Invited';

  @override
  String get inviteFriends => 'Invite friends';

  @override
  String get invite => 'Invite';

  @override
  String get rewards => 'Rewards';

  @override
  String get inviteCodeUnavailable => 'Invite code is not available';

  @override
  String get invitedFriendsList => 'List of invited friends';

  @override
  String totalPeopleCount(Object count) {
    return 'Total: $count people';
  }

  @override
  String get noInvitations => 'No invitations';

  @override
  String get noFriendsInvitedYet => 'You haven\'t invited any friends yet';

  @override
  String get noRewards => 'No rewards';

  @override
  String get noRewardsToShow => 'There are no rewards to show yet';

  @override
  String get inviteFriendsReadFree => '📚 Invite your friends and\n read free for a month!';

  @override
  String get inviteFriendsDescription => 'Invite your friends to the book reader app and you and your friend will each get a free one-month subscription! Just send them your invite code so they can enter the fascinating world of books.';

  @override
  String get inviteCodeCopied => 'Invite code copied!';

  @override
  String get copy => 'Copy';

  @override
  String get noFriendInvitedYet => 'You haven\'t invited a friend yet';

  @override
  String get inviteFriendsBothGetFreeMonth => 'By inviting your friends, both of you will receive a free one-month subscription!';

  @override
  String get shareYourInviteCode => 'Share your invite code';

  @override
  String invitationDateWithValue(Object date) {
    return 'Invitation date: $date';
  }

  @override
  String get noRewardsReceivedYet => 'You haven\'t received any rewards yet';

  @override
  String get inviteFriendsGetRewards => 'By inviting your friends and using the invite code, you will receive valuable rewards!';

  @override
  String get receivedRewards => 'Received rewards';

  @override
  String totalRewardsCount(Object count) {
    return 'Total: $count rewards';
  }

  @override
  String trackingCodeWithValue(Object code) {
    return 'Tracking code: $code';
  }

  @override
  String receivedDateWithValue(Object date) {
    return 'Received date: $date';
  }

  @override
  String get errorLoadingShelf => 'Error loading shelf';

  @override
  String get shelfIsEmpty => 'This shelf is empty';

  @override
  String get addFavoriteBooksToShelf => 'Add your favorite books to this shelf';

  @override
  String get shelfBooks => 'Shelf books';

  @override
  String booksCount(Object count) {
    return '$count books';
  }

  @override
  String get audio => 'Audio';

  @override
  String get text => 'Text';

  @override
  String get progress => 'Progress';

  @override
  String get bookClippingComments => 'Book clipping comments';

  @override
  String get errorLoadingComments => 'Error loading comments';

  @override
  String get noCommentsYet => 'No comments yet';

  @override
  String get beFirstToComment => 'Be the first to comment';

  @override
  String get noBookFound => 'No book found!';

  @override
  String get noBooksInLibraryYet => 'No books have been added to your library yet';

  @override
  String get myShelves => 'My shelves';

  @override
  String get appShelves => 'Imam Sadiq University shelves';

  @override
  String get noTextBooksInLibrary => 'There are no text books in your library';

  @override
  String get noAudioBooksInLibrary => 'There are no audiobooks in your library';

  @override
  String get noBooksFound => 'No books found';

  @override
  String get electronic => 'Electronic';

  @override
  String errorLoadingChaptersWithMessage(Object error) {
    return 'Error loading chapters: $error';
  }

  @override
  String errorCreatingChapterWithMessage(Object error) {
    return 'Error creating chapter: $error';
  }

  @override
  String errorUpdatingChapterWithMessage(Object error) {
    return 'Error updating chapter: $error';
  }

  @override
  String errorDeletingChapterWithMessage(Object error) {
    return 'Error deleting chapter: $error';
  }

  @override
  String get myNoteCards => 'My note cards';

  @override
  String get noChapters => 'No chapters';

  @override
  String get noChaptersCreatedYet => 'You haven\'t created any chapters yet';

  @override
  String get deleteChapter => 'Delete chapter';

  @override
  String confirmDeleteItem(Object title) {
    return 'Are you sure you want to delete "$title"?';
  }

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String daysAgo(Object days) {
    return '$days days ago';
  }

  @override
  String get myClippings => 'My clippings';

  @override
  String get noClippingsSavedYet => 'You haven\'t saved any clippings from books yet';

  @override
  String get likedByUser => '  liked by user';

  @override
  String get commentSubmittedSuccessfully => 'Your comment was submitted successfully';

  @override
  String get myComments => 'My comments';

  @override
  String get yourComment => 'Your comment';

  @override
  String get pleaseEnterComment => 'Please enter your comment';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get sending => 'Sending...';

  @override
  String get submitComment => 'Submit comment';

  @override
  String get howWasYourReadingExperience => 'How was your experience\n reading this book?';

  @override
  String get helpOthersReadBetter => 'Help others read better';

  @override
  String get doYouRecommendBook => 'Would you recommend this book to others?';

  @override
  String get notSure => 'Not sure';

  @override
  String get pleaseEnterRating => 'Please enter your rating';

  @override
  String get iRecommend => 'I recommend it';

  @override
  String get iDontRecommend => 'I don\'t recommend it';

  @override
  String get noCommentSubmitted => 'No comments submitted';

  @override
  String get noCommentsForBooksYet => 'You haven\'t commented on any books yet';

  @override
  String get unknownBookName => 'Unknown book name';

  @override
  String get myPurchases => 'My purchases';

  @override
  String get viewAll => 'View all';

  @override
  String get noPurchases => 'No purchases';

  @override
  String get trackingCode => 'Tracking code';

  @override
  String get purchaseDate => 'Purchase date';

  @override
  String get discount => 'Discount';

  @override
  String get myShelvesTitle => 'My shelves';

  @override
  String get createNewShelf => 'Create new shelf';

  @override
  String get errorLoadingShelves => 'Error loading shelves';

  @override
  String get noShelvesCreatedYet => 'You haven\'t created a shelf yet';

  @override
  String get createShelfFirstToAddBooks => 'To add books to a shelf, first create a new shelf';

  @override
  String get createShelf => 'Create shelf';

  @override
  String get writeShelfName => 'Write the shelf name';

  @override
  String get submit => 'Submit';

  @override
  String get deleteShelf => 'Delete shelf';

  @override
  String confirmDeleteShelf(Object name) {
    return 'Are you sure you want to delete the shelf "$name"?';
  }

  @override
  String get latestBooks => 'Latest books:';

  @override
  String moreBooksCount(Object count) {
    return '+$count more books';
  }

  @override
  String get shelfEmpty => 'Shelf is empty';

  @override
  String get subscriptionHistory => 'Subscription history';

  @override
  String get activeSubscription => 'Active subscription';

  @override
  String get appSubscription => 'Imam Sadiq University subscription';

  @override
  String get subscriptionDescription => 'By buying a book reader subscription, get access to a world of e-books and audiobooks. A unique experience for book lovers, anywhere and anytime!';

  @override
  String get activeSubscriptions => 'Active subscriptions';

  @override
  String get startDate => 'Start date:';

  @override
  String get expiryDate => 'Expiry date:';

  @override
  String get buyPremiumSubscription => 'Buy premium subscription';

  @override
  String get expiredSubscriptions => 'Expired subscriptions';

  @override
  String get noExpiredSubscriptions => 'You have no expired subscriptions';

  @override
  String openLinkInBrowser(Object url) {
    return 'Please open this link in your browser: $url';
  }

  @override
  String get paymentVerificationFailed => 'Payment verification failed. Please try again.';

  @override
  String get paymentType => 'Payment type';

  @override
  String get amount => 'Amount';

  @override
  String get errorMessage => 'Error message';

  @override
  String get paymentSuccessful => 'Payment successful';

  @override
  String get paymentFailed => 'Payment failed';

  @override
  String get paymentExpired => 'Payment time expired';

  @override
  String get paymentCancelled => 'Payment cancelled';

  @override
  String get paymentError => 'Payment error';

  @override
  String get paymentSuccessDescription => 'Your payment was successful and your purchase has been recorded';

  @override
  String get paymentFailedDescription => 'Unfortunately your payment was not successful. Please try again';

  @override
  String get paymentExpiredDescription => 'Your payment time has expired. Please try again';

  @override
  String get paymentCancelledDescription => 'The payment was cancelled by you';

  @override
  String get paymentErrorDescription => 'An error occurred while processing the payment';

  @override
  String get backToHome => 'Back to home page';

  @override
  String get bookPurchase => 'Book purchase';

  @override
  String get giftCardPurchase => 'Gift card purchase';

  @override
  String get walletCharge => 'Wallet top-up';

  @override
  String get viewMyBooks => 'View my books';

  @override
  String get viewMySubscriptions => 'View my subscriptions';

  @override
  String get viewGiftCards => 'View gift cards';

  @override
  String get viewWallet => 'View wallet';

  @override
  String get paymentDone => 'Payment completed successfully';

  @override
  String get orderNumber => 'Order number';

  @override
  String get transactionId => 'Transaction ID';

  @override
  String get purchasedItems => 'Purchased items';

  @override
  String itemsCountTapToView(Object count) {
    return '$count items - tap to view';
  }

  @override
  String get unknown => 'Unknown';

  @override
  String productWithValue(Object productId) {
    return 'Product $productId';
  }

  @override
  String productIdWithValue(Object productId) {
    return 'Product ID: $productId';
  }

  @override
  String get purchased => 'Purchased';

  @override
  String get totalPayment => 'Total payment';

  @override
  String itemsCount(Object count) {
    return '$count items';
  }

  @override
  String get viewPaymentHistory => 'View payment history';

  @override
  String get paymentHistory => 'Payment history';

  @override
  String get dateLabel => 'Date:';

  @override
  String get purchaseLabel => 'Purchase:';

  @override
  String get amountLabel => 'Amount:';

  @override
  String amountTomanTrailing(Object amount) {
    return '$amount Toman';
  }

  @override
  String get viaLabel => 'Via:';

  @override
  String get statusLabel => 'Status:';

  @override
  String get trackingCodeLabel => 'Tracking code:';

  @override
  String get discountLabel => 'Discount:';

  @override
  String get store => 'Store';

  @override
  String get noPurchasesYet => 'You haven\'t made any purchases yet.';

  @override
  String get paymentHistoryHint => 'Here you can see your transaction history';

  @override
  String get personalDevelopmentBooks => 'Personal development books';

  @override
  String get filters => 'Filters';

  @override
  String get textBooks => 'Text books';

  @override
  String get audioBooks => 'Audiobooks';

  @override
  String get authorTranslatorNarrator => 'Author, translator or narrator';

  @override
  String get drivingMode => 'Driving mode';

  @override
  String get stopPlaybackAfter => 'Stop playback after...';

  @override
  String get oneMinuteTest => '1 minute (test)';

  @override
  String get fifteenMinutes => '15 minutes';

  @override
  String get twentyMinutes => '20 minutes';

  @override
  String get thirtyMinutes => '30 minutes';

  @override
  String get fortyFiveMinutes => '45 minutes';

  @override
  String get oneHour => '1 hour';

  @override
  String get endOfThisSection => 'End of this section';

  @override
  String get playbackSpeed => 'Playback speed';

  @override
  String normalSpeed(Object speed) {
    return '$speed.0X (normal)';
  }

  @override
  String get someTracksNotDownloaded => 'Some tracks were not downloaded.';

  @override
  String percentListened(Object percent) {
    return '$percent% listened';
  }

  @override
  String get someTracksNotDownloadedColon => 'Some tracks were not downloaded:';

  @override
  String get retryFailedTracksOnly => 'Retry only the failed tracks';

  @override
  String get allTracksDownloaded => 'All tracks downloaded successfully!';

  @override
  String get downloadAll => 'Download all';

  @override
  String get noteSavedSuccessfully => 'Note saved successfully';

  @override
  String errorSavingNoteWithMessage(Object error) {
    return 'Error saving note: $error';
  }

  @override
  String get bookAddedToBookmarks => 'Book added to bookmarks';

  @override
  String get bookRemovedFromBookmarks => 'Book removed from bookmarks';

  @override
  String errorBookmarkingWithMessage(Object error) {
    return 'Error bookmarking: $error';
  }

  @override
  String get clippingSavedSuccessfully => 'Book clipping saved successfully';

  @override
  String errorSavingClippingWithMessage(Object error) {
    return 'Error saving book clipping: $error';
  }

  @override
  String errorDownloadingBookWithMessage(Object error) {
    return 'Error downloading book: $error';
  }

  @override
  String get errorSharing => 'Error sharing';

  @override
  String get note => 'Note';

  @override
  String get productNotFound => 'Product not found';

  @override
  String get productNotAvailable => 'The requested product is not available';

  @override
  String get shareBook => 'Share book';

  @override
  String get aboutBook => 'About the book';

  @override
  String get tags => 'Tags';

  @override
  String get tag => 'Tag';

  @override
  String get userReviews => 'User reviews';

  @override
  String get otherBooksByAuthor => 'Other books by this author';

  @override
  String get otherBooksByPublisher => 'Other books by this publisher';

  @override
  String get relatedBooks => 'Related books';

  @override
  String get play => 'Play';

  @override
  String get read => 'Read';

  @override
  String get contentTypeUnknown => 'Content type is unknown';

  @override
  String get audioFileNotAvailable => 'Audio file is not available';

  @override
  String get bookFileNotAvailable => 'Book file is not available';

  @override
  String get productAlreadyInCart => 'This product is already in your shopping cart';

  @override
  String addedToCartWithName(Object name) {
    return '$name was added to the shopping cart';
  }

  @override
  String get view => 'View';

  @override
  String get errorAddingToCart => 'Error adding to shopping cart';

  @override
  String fromReviewsCount(Object count) {
    return 'from $count reviews';
  }

  @override
  String get premiumAccess => 'Premium access';

  @override
  String get addToShelf => 'Add to shelf';

  @override
  String get viewCart => 'View shopping cart';

  @override
  String get addToCart => 'Add to shopping cart';

  @override
  String get loading => 'Loading...';

  @override
  String get readSample => 'Read sample';

  @override
  String get continueReading => 'Continue reading';

  @override
  String get fullDescription => 'Full description';

  @override
  String get tableOfContents => 'Table of contents';

  @override
  String get viewBookInfo => 'View book information';

  @override
  String get helpful => 'Helpful';

  @override
  String get notHelpful => 'Not helpful';

  @override
  String get whatIsYourOpinion => 'What is your opinion?';

  @override
  String get bookAddedToShelf => 'Book added to shelf successfully';

  @override
  String get createNewShelfTitle => 'Create new shelf';

  @override
  String get enterShelfName => 'Enter the shelf name';

  @override
  String get create => 'Create';

  @override
  String get errorLoadingProfileCheckInternet => 'Error loading profile information. Please check your internet connection.';

  @override
  String errorLoadingProfileWithMessage(Object error) {
    return 'Error loading profile information: $error';
  }

  @override
  String get profileManagement => 'Profile management';

  @override
  String get errorLoadingProfile => 'Error loading profile';

  @override
  String get selectImageSource => 'Select image source';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get imageFileNotFound => 'Image file not found';

  @override
  String get imageMaxSize10Mb => 'Image file size must not exceed 10 MB';

  @override
  String get editImage => 'Edit image';

  @override
  String get imageSelectedWithoutEditing => 'Image selected without editing';

  @override
  String get errorSelectingImage => 'Error selecting image';

  @override
  String get errorEditingImage => 'Error editing image. Please select another image';

  @override
  String get galleryCameraPermissionDenied => 'Access to the gallery or camera was not granted';

  @override
  String get unsupportedImageFormat => 'Image format is not supported. Please select a JPG or PNG image';

  @override
  String get errorReadingImage => 'Error reading image file. Please select another image';

  @override
  String get invalidImageFormat => 'Invalid image format. Please select a valid image';

  @override
  String get minimumAge10 => 'You must be at least 10 years old';

  @override
  String get invalidBirthDate => 'Invalid birth date';

  @override
  String get imageTooLarge => 'The image is too large. Please select a smaller image';

  @override
  String get errorProcessingImage => 'Error processing image. Please select another image';

  @override
  String get firstName => 'First name';

  @override
  String get lastName => 'Last name';

  @override
  String get passwordOptional => 'Password (optional)';

  @override
  String get enterNewPasswordToChange => 'To change your password, enter a new password';

  @override
  String get gender => 'Gender';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get birthDate => 'Birth date';

  @override
  String get selectDate => 'Select date';

  @override
  String get aboutMeOptional => 'About me (optional)';

  @override
  String get saveInformation => 'Save information';

  @override
  String get monthFarvardin => 'Farvardin';

  @override
  String get monthOrdibehesht => 'Ordibehesht';

  @override
  String get monthKhordad => 'Khordad';

  @override
  String get monthTir => 'Tir';

  @override
  String get monthMordad => 'Mordad';

  @override
  String get monthShahrivar => 'Shahrivar';

  @override
  String get monthMehr => 'Mehr';

  @override
  String get monthAban => 'Aban';

  @override
  String get monthAzar => 'Azar';

  @override
  String get monthDey => 'Dey';

  @override
  String get monthBahman => 'Bahman';

  @override
  String get monthEsfand => 'Esfand';

  @override
  String get selectBirthDate => 'Select birth date';

  @override
  String get year => 'Year';

  @override
  String get month => 'Month';

  @override
  String get day => 'Day';

  @override
  String get noPublicChaptersYet => 'No public chapters have been created yet';

  @override
  String get user => 'User';

  @override
  String get replyToBookClipping => 'Reply to book clipping';

  @override
  String get send => 'Send';

  @override
  String get reviewsAndRatings => 'Reviews and ratings';

  @override
  String get submitReviewAndRating => 'Submit review and rating';

  @override
  String get shareOpinion => 'Share opinion';

  @override
  String get uploadProduct => 'Upload product';

  @override
  String get searchMarketplace => 'Search the marketplace';

  @override
  String get noProductsInMarketplace => 'There are currently no products in the marketplace';

  @override
  String get handouts => 'Handouts';

  @override
  String get educationalContent => 'Educational content';

  @override
  String get questionBank => 'Question bank';

  @override
  String get periodical => 'Periodical';

  @override
  String get quarterly => 'Quarterly';

  @override
  String get monthlyMagazine => 'Monthly magazine';

  @override
  String get yearbook => 'Yearbook';

  @override
  String productsCount(Object count) {
    return '$count products';
  }

  @override
  String get studyTourNotFound => 'The requested study path was not found';

  @override
  String errorLoadingStudyTourDetailsWithMessage(Object error) {
    return 'Error loading study path details: $error';
  }

  @override
  String get twoMonths => '2 months';

  @override
  String get fourMonths => '4 months';

  @override
  String get sixMonths => '6 months';

  @override
  String get eightMonths => '8 months';

  @override
  String get studyTour => 'Study path';

  @override
  String get booksCountLabel => 'Number of books';

  @override
  String get studyRoute => 'Study route';

  @override
  String errorLoadingStudyToursWithMessage(Object error) {
    return 'Error loading study paths: $error';
  }

  @override
  String get myStudyTours => 'My study paths';

  @override
  String get noStudyToursYet => 'You haven\'t submitted a study path yet';

  @override
  String get submitFirstStudyTour => 'Submit your first study path';

  @override
  String get submitStudyTour => 'Submit study path';

  @override
  String get providedAnswer => 'Provided answer:';

  @override
  String get pending => 'Pending';

  @override
  String get approved => 'Approved';

  @override
  String get rejected => 'Rejected';

  @override
  String get errorLoadingCategories => 'Error loading categories';

  @override
  String get studyTourRequest => 'Study path request';

  @override
  String get designYourStudyTour => 'Design your study path';

  @override
  String get studyTourRequestHint => 'Choose your desired subject and submit your study path request';

  @override
  String get studyTourTitle => 'Study path title';

  @override
  String get studyTourTitleExample => 'Example: Iranian history study path';

  @override
  String get studyTourDescriptionHint => 'Write your description of the desired study path...';

  @override
  String get submitRequest => 'Submit request';

  @override
  String get noBookFoundPlain => 'No book found';

  @override
  String get textBooksTitle => 'Text books';

  @override
  String get productUploadedSuccessfully => 'Product uploaded successfully';

  @override
  String errorSelectingFileWithMessage(Object error) {
    return 'Error selecting file: $error';
  }

  @override
  String errorSelectingSampleFileWithMessage(Object error) {
    return 'Error selecting sample file: $error';
  }

  @override
  String get pleaseSelectMainFile => 'Please select the main file';

  @override
  String get pleaseSelectCategory => 'Please select a category';

  @override
  String get pleaseSelectProductImage => 'Please select the product image';

  @override
  String get uploadAnswerSheetOrHandout => 'Upload answer sheet or handout';

  @override
  String get contentType => 'Content type';

  @override
  String get productName => 'Product name';

  @override
  String get productNameExample => 'Example: 10th grade math handout';

  @override
  String get pleaseEnterProductName => 'Please enter the product name';

  @override
  String get pageCount => 'Number of pages';

  @override
  String get pageCountExample => 'Example: 30';

  @override
  String get pleaseEnterPageCount => 'Please enter the number of pages';

  @override
  String get pleaseEnterValidNumber => 'Please enter a valid number';

  @override
  String get publishYear => 'Publication year';

  @override
  String get publishYearExample => 'Example: 1402';

  @override
  String get pleaseEnterPublishYear => 'Please enter the publication year';

  @override
  String get priceInToman => 'Price (Toman)';

  @override
  String get priceExample => 'Example: 250,000';

  @override
  String get pleaseEnterPrice => 'Please enter the price';

  @override
  String get enterProductDescription => 'Enter the product description...';

  @override
  String get pleaseEnterDescription => 'Please enter the description';

  @override
  String get mainFileRequired => 'Main file *';

  @override
  String get selectFilePdfDoc => 'Select file (PDF, DOC, DOCX)';

  @override
  String get sampleFileOptional => 'Sample file (optional)';

  @override
  String get selectSampleFile => 'Select sample file';

  @override
  String get productImageRequired => 'Product image *';

  @override
  String get handout => 'Handout';

  @override
  String get mySubscriptions => 'My subscriptions';

  @override
  String get myCommentsMenu => 'My comments';

  @override
  String get myClippingsMenu => 'My clippings';

  @override
  String get update => 'Update';

  @override
  String get logout => 'Log out of account';

  @override
  String get walletChargedSuccessfully => 'Wallet topped up successfully!';

  @override
  String get wallet => 'Wallet';

  @override
  String get customAmountToman => 'Custom amount (Toman)';

  @override
  String get activateGiftCard => 'Activate gift card';

  @override
  String currentBalanceToman(Object amount) {
    return 'Current balance\n $amount Toman';
  }

  @override
  String get setAmount => ' Set amount';

  @override
  String get pleaseSelectAtLeastOneChapter => 'Please select at least one chapter';

  @override
  String get addToNoteCards => 'Add to note cards';

  @override
  String get selectedClipping => 'Selected clipping';

  @override
  String get selectChapter => 'Select chapter';

  @override
  String chaptersSelectedCount(Object count) {
    return '$count chapters selected';
  }

  @override
  String get noteOptional => 'Note (optional)';

  @override
  String get confirmFormal => 'Confirm';

  @override
  String confirmWithCount(Object count) {
    return 'Confirm ($count)';
  }

  @override
  String get createChapterFirstToAddNote => 'To add a note, you must first create a chapter.';

  @override
  String get selectedClippingColon => 'Selected clipping:';

  @override
  String get selectChapterColon => 'Select chapter:';

  @override
  String get yourNoteOptional => 'Your note (optional)';

  @override
  String get unknownAuthor => 'Unknown author';

  @override
  String percentListenedSpaced(Object percent) {
    return '$percent% listened';
  }

  @override
  String percentRead(Object percent) {
    return '$percent% read';
  }

  @override
  String get noCategoryFound => 'No category found';

  @override
  String get fontYekanBakh => 'Yekan Bakh';

  @override
  String get fontVazir => 'Vazir';

  @override
  String get fontAnjoman => 'Anjoman';

  @override
  String get fontIranYekan => 'IRAN Yekan';

  @override
  String get addToNoteCardsEmoji => '📝 Add to note cards';

  @override
  String get bookClippingEmoji => '📑 Book clipping';

  @override
  String get highlightYellow => '🟡 Yellow highlight';

  @override
  String get highlightGreen => '🟢 Green highlight';

  @override
  String get highlightOrange => '🟠 Orange highlight';

  @override
  String get highlightBlue => '🔵 Blue highlight';

  @override
  String get textHighlightedSuccessfully => 'Text highlighted successfully';

  @override
  String get noReadableContent => 'No readable content found.';

  @override
  String get chapters => 'Chapters';

  @override
  String get highlights => 'Highlights';

  @override
  String get saved => 'Saved';

  @override
  String get deleteAllHighlights => 'Delete all highlights';

  @override
  String pageNumber(Object page) {
    return 'Page $page';
  }

  @override
  String get gridView => 'Grid view';

  @override
  String get previousPage => 'Previous page';

  @override
  String pageProgress(Object page, Object totalPages, Object percent) {
    return '$page of $totalPages pages - $percent%';
  }

  @override
  String get nextPage => 'Next page';

  @override
  String get chaptersAndHighlights => 'Chapters and highlights';

  @override
  String get book => 'Book';

  @override
  String get settings => 'Settings';

  @override
  String get fontType => 'Font type';

  @override
  String get fontSize => 'Font size';

  @override
  String get lineSpacing => 'Line spacing';

  @override
  String get low => 'Low';

  @override
  String get high => 'High';

  @override
  String get fontWeight => 'Font weight';

  @override
  String get normal => 'Normal';

  @override
  String get medium => 'Medium';

  @override
  String get bold => 'Bold';

  @override
  String get extraBold => 'Extra bold';

  @override
  String get displayMode => 'Display mode';

  @override
  String get nightMode => 'Night mode';

  @override
  String get readingDirection => 'Reading direction';

  @override
  String get vertical => 'Vertical';

  @override
  String get switchToVerticalReading => 'Switch reading direction to vertical';

  @override
  String get noReadableContentHtml => '<p>No readable content found.</p>';

  @override
  String get emptyBookHtml => '<p>The book is empty.</p>';

  @override
  String get emptyBook => 'The book is empty.';

  @override
  String get pdfFileNotFound => 'PDF file not found';

  @override
  String errorLoadingPdfWithMessage(Object error) {
    return 'Error loading PDF: $error';
  }

  @override
  String errorDownloadingFileWithMessage(Object error) {
    return 'Error downloading file: $error';
  }

  @override
  String get downloading => 'Downloading...';

  @override
  String pageOfTotal(Object page, Object totalPages) {
    return 'Page $page of $totalPages';
  }

  @override
  String get connectionProblem => 'Connection problem';

  @override
  String get serverError => 'Server error';

  @override
  String get connectionTimedOut => 'Connection timed out';

  @override
  String get notFound => 'Not found';

  @override
  String get accessDenied => 'Access denied';

  @override
  String get invalidData => 'Invalid data';

  @override
  String get errorOccurred => 'An error occurred';

  @override
  String get appTheme => 'App theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get appLanguage => 'App language';

  @override
  String get english => 'English';

  @override
  String get uncategorized => 'Uncategorized';

  @override
  String get unknownPublisher => 'Unknown publisher';
}
