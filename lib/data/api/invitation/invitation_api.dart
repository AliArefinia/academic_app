import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'model/my_invites_model.dart';

part 'invitation_api.g.dart';

@lazySingleton
@RestApi()
abstract class InvitationApi {
  @factoryMethod
  factory InvitationApi(Dio dio) = _InvitationApi;

  @GET('/api/my-invites')
  Future<MyInvitesResponse> getMyInvites();
}
