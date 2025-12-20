part of 'verification_cubit.dart';

@freezed
class VerificationState with _$VerificationState {
  const factory VerificationState.initial() = _Initial;

  const factory VerificationState.loading() = _Loading;

  const factory VerificationState.success(User user) = _Success;

  const factory VerificationState.error(String message) = _Error;

  const factory VerificationState.hasPassword(bool hasPassword) = _HasPassword;

  // Step 1: OTP verification successful, move to step 2
  const factory VerificationState.otpVerified() = _OtpVerified;

  // Step 2: Loading categories
  const factory VerificationState.loadingCategories() = _LoadingCategories;

  // Step 2: Categories loaded, ready for selection
  const factory VerificationState.categoriesLoaded(
    List<CategoryModel> mainCategories,
  ) = _CategoriesLoaded;
}