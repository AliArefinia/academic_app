import 'package:academic/core/storage/local_storage.dart';
import 'package:academic/data/api/auth/model/auth_phone.dart';
import 'package:academic/data/api/auth/model/login_response.dart';
import 'package:injectable/injectable.dart';

import '../api/auth/auth_api.dart';
import '../api/auth/model/auth_response_model.dart';

@injectable
class AuthRepo {
  final AuthApiService _userApiService;
  final LocalStorage _localStorage;

  AuthRepo(this._userApiService, this._localStorage);

  Future<AuthPhoneModel> authPhone(String phone) async {
    try {
      final response = await _userApiService.phoneAuth(phone: phone);
      return response;
    } catch (e) {
      throw e; // Throw the original error, not the stack trace
    }
  }

  Future<AuthPhoneModel> checkPhone(String phone) async {
    try {
      final response = await _userApiService.checkPhone(phone: phone);
      return response;
    } catch (e) {
      throw e; // Throw the original error, not the stack trace
    }
  }

  Future<LoginResponse> loginPassword(String phone, String pass, {String? inviteCode}) async {
    try {
      final response = await _userApiService.passwordAuth(phone: phone, password: pass);
      final userModel = UserModel(
        id: response.user.id,
        name: response.user.name,
        phone: response.user.phone,
        inviteCode: response.user.inviteCode,
        createdAt: response.user.createdAt.toIso8601String(),
        updatedAt: response.user.updatedAt.toIso8601String(),
      );
      await _localStorage.saveUser(userModel);
      await _localStorage.saveToken(response.token);
      return response;
    } catch (e) {
      throw e; // Throw the original error, not the stack trace
    }
  }

  Future<LoginResponse> verifyPhone(
    String phone,
    String code, {
    String? inviteCode,
    String? type,
    int? categoryId,
  }) async {
    try {
      final Map<String, dynamic> body = {
        'phone': phone,
        'otp': code,
      };
      
      if (inviteCode != null && inviteCode.isNotEmpty) {
        body['invite_code'] = inviteCode;
      }

      if (type != null) {
        body['type'] = type;
      }

      if (categoryId != null) {
        body['category_id'] = categoryId;
      }
      
      final response = await _userApiService.verifyPhoneCode(body);
      final userModel = UserModel(
        id: response.user.id,
        name: response.user.name,
        phone: response.user.phone,
        inviteCode: response.user.inviteCode,
        createdAt: response.user.createdAt.toIso8601String(),
        updatedAt: response.user.updatedAt.toIso8601String(),
        avatar: response.user.avatar,
      );
      await _localStorage.saveUser(userModel);
      await _localStorage.saveToken(response.token);
      return response;
    } catch (e) {
      throw e; // Throw the original error, not the stack trace
    }
  }

  Future<void> logout() async {
    try {
      await _userApiService.logout();
      await _localStorage.clearUser();
    } catch (e) {
      // Handle logout error if necessary, though clearing local storage is the priority.
      print('Logout failed: $e');
      await _localStorage.clearUser(); // Ensure local data is cleared even if API call fails
    }
  }

  Future<LoginResponse> loginEmailPassword(String email, String password) async {
    try {
      final response = await _userApiService.emailPasswordAuth(
          email: email, password: password);
      final userModel = UserModel(
        id: response.user.id,
        name: response.user.name,
        phone: response.user.phone,
        inviteCode: response.user.inviteCode,
        createdAt: response.user.createdAt.toIso8601String(),
        updatedAt: response.user.updatedAt.toIso8601String(),
      );
      await _localStorage.saveUser(userModel);
      await _localStorage.saveToken(response.token);
      return response;
    } catch (e) {
      throw e; // Throw the original error, not the stack trace
    }
  }
}
