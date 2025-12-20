part of '../router.dart';

@TypedGoRoute<BookmarkedBooksRoute>(
  path: PathRoute.bookmarkedBooksRoute,
)
class BookmarkedBooksRoute extends GoRouteData {
  const BookmarkedBooksRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => BookmarkedBooksCubit(getIt<IBookmarksRepository>()),
      child: BookmarkedBooksPage(),
    );
  }
}
