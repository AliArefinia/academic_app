import 'package:injectable/injectable.dart';
import '../api/invitation/invitation_api.dart';
import '../api/invitation/model/my_invites_model.dart';

abstract class IInvitationRepository {
  Future<MyInvitesResponse> getMyInvites();
}

@LazySingleton(as: IInvitationRepository)
class InvitationRepository implements IInvitationRepository {
  final InvitationApi _api;

  InvitationRepository(this._api);

  @override
  Future<MyInvitesResponse> getMyInvites() async {
    try {
      final response = await _api.getMyInvites();
      return response;
    } catch (e) {
      throw Exception('Failed to fetch invitations: ${e.toString()}');
    }
  }
}
