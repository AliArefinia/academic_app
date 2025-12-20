import '../api/invitation/model/my_invites_model.dart';

class InvitedFriendsModel {
  String name;
  int score;
  String created_at;

  InvitedFriendsModel({
    required this.name,
    required this.score,
    required this.created_at,
  });

  factory InvitedFriendsModel.fromApiItem(MyInviteItem item) {
    return InvitedFriendsModel(
      name: item.name,
      score: item.score,
      created_at: item.created_at,
    );
  }
}

List<InvitedFriendsModel> fakeInvitedFriendsList = [
  InvitedFriendsModel(
      name: 'علی عارفی نیا',
      score: 10,
      created_at: "1404/07/12"),
  InvitedFriendsModel(
      name: 'User 194794',
      score: 10,
      created_at: "1404/07/11"),
];
