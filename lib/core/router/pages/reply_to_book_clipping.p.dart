part of '../router.dart';

@TypedGoRoute<ReplytobookclippingRoute>(
  path: PathRoute.replyToBookClippingRoute,
)
class ReplytobookclippingRoute extends GoRouteData {
  final String bookImage;
  final String userNameAndFamily;
  final String date;
  final String userDescription;
  final String userImage;
  final int? numOfLike;
  final int? numOfComment;

  const ReplytobookclippingRoute({
    required this.bookImage,
    required this.userNameAndFamily,
    required this.date,
    required this.userImage,
    this.numOfLike,
    this.numOfComment,
    required this.userDescription,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => ReplytobookclippingCubit(),
      child: ReplytobookclippingPage(
        bookImage: bookImage,
        userNameAndFamily: userNameAndFamily,
        date: date,
        userDescription: userDescription,
        userImage: userImage,
        numOfLike: numOfLike,
        numOfComment: numOfComment,
      ),
    );
  }
}
