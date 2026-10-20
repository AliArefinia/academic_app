import 'package:academic/l10n/l10n.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:academic/data/api/auth/model/auth_response_model.dart';

@injectable
class ProfileApiService {
  final Dio _dio;

  ProfileApiService(this._dio);

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
      final formData = FormData.fromMap({
        'name': name.isNotEmpty ? name : 'کاربر',
        'last_name': lastName,
        if (password != null) 'password': password,
        'gender': gender,
        'date_of_birth': dateOfBirth, // Fixed typo in field name
        'about': about,
        if (avatarImage != null) 'avatar_image': MultipartFile.fromBytes(
          base64Decode(avatarImage),
          filename: 'avatar.jpg',
          contentType: DioMediaType('image', 'jpeg'),
        ),
      });

      final response = await _dio.post('/api/profiles', data: formData);
      if (response.data['data'] == null) {
        throw Exception(response.data['message'] ?? l10n.errorFetchingProfile);
      }
      return UserModel.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getProfile() async {
    try {
      final response = await _dio.get('/api/profiles');
      if (response.data['data'] == null) {
        throw Exception(response.data['message'] ?? l10n.errorFetchingProfile);
      }
      return UserModel.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }
} 