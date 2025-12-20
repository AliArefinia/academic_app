import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:academic/data/api/auth/model/auth_response_model.dart';

class LocalStorage {
  static const String _userKey = 'user_data';
  static const String _tokenKey = 'auth_token';
  static const String _isPremiumKey = 'is_premium_user';

  final SharedPreferences _prefs;

  LocalStorage(this._prefs);

  Future<void> saveUser(UserModel user) async {
    await _prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  UserModel? getUser() {
    final userJson = _prefs.getString(_userKey);
    if (userJson == null) return null;
    return UserModel.fromJson(jsonDecode(userJson));
  }

  String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  Future<void> clearUser() async {
    await _prefs.remove(_userKey);
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_isPremiumKey);
  }

  Future<void> savePremiumStatus(bool isPremium) async {
    await _prefs.setBool(_isPremiumKey, isPremium);
  }

  bool isPremiumUser() {
    return _prefs.getBool(_isPremiumKey) ?? false;
  }
} 