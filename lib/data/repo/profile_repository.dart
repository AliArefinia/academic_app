import 'package:injectable/injectable.dart';
import 'package:academic/data/api/auth/model/auth_response_model.dart';
import 'package:academic/data/api/profile/profile_api.dart';

@injectable
class ProfileRepository {
  final ProfileApiService _profileApiService;

  ProfileRepository(this._profileApiService);

  Future<UserModel> updateProfile({
    required String name,
    required String lastName,
    String? password,
    required String gender,
    required String dateOfBirth,
    required String about,
    String? avatarImage,
  }) async {
    try {
      return await _profileApiService.updateProfile(
        name: name,
        lastName: lastName,
        password: password,
        gender: gender,
        dateOfBirth: dateOfBirth,
        about: about,
        avatarImage: avatarImage,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getProfile() async {
    try {
      return await _profileApiService.getProfile();
    } catch (e) {
      rethrow;
    }
  }
} 