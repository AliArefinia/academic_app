part of '../router.dart';

@TypedGoRoute<ShareviewRoute>(
  path: PathRoute.shareViewRoute,
)
class ShareviewRoute extends GoRouteData {
  final String userNameAndFamily;
  final String userImage;
  final String date;
  final String userDescription;
  final String opinion;
  final String personNameAndFamily;
  final String todayDate;
  final int? numOfLike;
  final int? numOfComment;

  const ShareviewRoute({
    required this.userNameAndFamily,
    required this.userImage,
    required this.date,
    required this.opinion,
    this.numOfComment,
    this.numOfLike,
    required this.todayDate,
    required this.personNameAndFamily,
    required this.userDescription,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => ShareviewCubit(),
      child: ShareviewPage(
        userNameAndFamily: userNameAndFamily,
        userImage: userImage,
        date: date,
        opinion: opinion,
        numOfLike: numOfLike,
        numOfComment: numOfComment,
        userDescription: userDescription,
        personNameAndFamily: personNameAndFamily,
        todayDate: todayDate,
      ),
    );
  }
}
