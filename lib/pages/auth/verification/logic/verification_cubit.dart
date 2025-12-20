import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:academic/core/error/error_message_mapper.dart';
import 'package:academic/data/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/api/auth/model/login_response.dart';
import '../../../../data/api/categories/model/category_model.dart';
import '../../../../data/repository/categories_repository.dart';

part 'verification_state.dart';
part 'verification_event.dart';
part 'verification_cubit.freezed.dart';

@injectable
class VerificationCubit extends Cubit<VerificationState> {
  final AuthRepo repository;
  final ICategoriesRepository categoriesRepository;
  
  // Store step 1 data temporarily
  String? _phone;
  String? _otp;
  String? _inviteCode;

  VerificationCubit(this.repository, this.categoriesRepository) 
      : super(const VerificationState.initial());

  Future<void> checkPasswordStatus(String phone) async {
    try {
      final response = await repository.checkPhone(phone);
      emit(VerificationState.hasPassword(response.has_password));
    } catch (e) {
      emit(VerificationState.error(ErrorMessageMapper.mapError(e)));
    }
  }

  // Step 1: Verify OTP
  // If newUser is false, verify directly and go to home
  // If newUser is true, store data and move to step 2 (type & category selection)
  Future<void> verifyPhoneOtp(String phone, String code, {String? inviteCode, required bool newUser}) async {
    emit(const VerificationState.loading());

    try {
      if (newUser) {
        // For new users: Store the data for later use in step 2
        _phone = phone;
        _otp = code;
        _inviteCode = inviteCode;

        // After OTP verification success, move to step 2
        emit(const VerificationState.otpVerified());
        
        // Load categories for step 2
        await loadCategories();
      } else {
        // For existing users: Verify OTP directly without type and category
        final response = await repository.verifyPhone(
          phone,
          code,
          inviteCode: inviteCode,
        );

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.token);

        emit(VerificationState.success(response.user));
      }
    } catch (e) {
      emit(VerificationState.error(ErrorMessageMapper.mapError(e)));
    }
  }

  // Load categories for step 2
  Future<void> loadCategories({String? query}) async {
    try {
      emit(const VerificationState.loadingCategories());
      final response = await categoriesRepository.getCategories(query: query ?? '');
      // Only show main categories (parent_id is null or 0)
      final mainCategories = response.mainCategories
          .where((cat) => cat.parentId == null || cat.parentId == 0)
          .toList();
      emit(VerificationState.categoriesLoaded(mainCategories));
    } catch (e) {
      emit(VerificationState.error(ErrorMessageMapper.mapError(e)));
    }
  }

  // Load sub-categories for a category
  Future<void> loadSubCategories(int categoryId) async {
    try {
      await categoriesRepository.getSubCategories(categoryId);
      // Handle sub-categories if needed in the future
    } catch (e) {
      // Silently fail for sub-categories loading
      print('Error loading sub-categories: $e');
    }
  }

  // Step 2: Complete verification with type and category
  Future<void> completeVerification({
    required String type, // "1" for student, "2" for master
    required int categoryId,
  }) async {
    if (_phone == null || _otp == null) {
      emit(const VerificationState.error('خطا در اطلاعات ورودی'));
      return;
    }

    emit(const VerificationState.loading());

    try {
      final response = await repository.verifyPhone(
        _phone!,
        _otp!,
        inviteCode: _inviteCode,
        type: type,
        categoryId: categoryId,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.token);

      emit(VerificationState.success(response.user));
    } catch (e) {
      emit(VerificationState.error(ErrorMessageMapper.mapError(e)));
    }
  }
}