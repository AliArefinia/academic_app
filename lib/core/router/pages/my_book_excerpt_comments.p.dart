part of '../router.dart';

@TypedGoRoute<MyBookExcerptCommentsRoute>(
  path: PathRoute.myBookExcerptCommentsRoute,
)
class MyBookExcerptCommentsRoute extends GoRouteData {
  final int excerptId;
  final String bookImage;
  final String userNameAndFamily;
  final String date;
  final String userDescription;
  final String userImage;
  final int? numOfLike;
  final int? numOfComment;

  const MyBookExcerptCommentsRoute({
    required this.excerptId,
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
      create: (context) => MyBookExcerptCommentsCubit(getIt<MyBookExcerptsRepository>(), excerptId),
      child: MyBookExcerptCommentsPage(
        excerptId: excerptId,
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

