import 'package:dio/dio.dart';
import 'package:academic/data/api/auth/model/auth_phone.dart';
import 'package:academic/data/api/auth/model/login_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/api_constants.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
@LazySingleton()
abstract class AuthApiService {
  @factoryMethod
  factory AuthApiService(Dio dio) = _AuthApiService;

  @FormUrlEncoded()
  @POST(AppUrls.phoneAuth)
  Future<AuthPhoneModel> phoneAuth({@Field("phone") required String phone});

  @FormUrlEncoded()
  @POST(AppUrls.passwordAuth)
  Future<LoginResponse> passwordAuth(
      {@Field("phone") required String phone,
      @Field("password") required String password});

  @POST(AppUrls.verifyAuth)
  Future<LoginResponse> verifyPhoneCode(@Body() Map<String, dynamic> body);

  @POST('/api/logout')
  Future<void> logout();

  @FormUrlEncoded()
  @POST('/api/auth/email/password')
  Future<LoginResponse> emailPasswordAuth({
    @Field("email") required String email,
    @Field("password") required String password,
  });

  @FormUrlEncoded()
  @POST(AppUrls.phoneAuth)
  Future<AuthPhoneModel> checkPhone({@Field("phone") required String phone});
}
