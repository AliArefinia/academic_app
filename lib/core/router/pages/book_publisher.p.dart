part of '../router.dart';

@TypedGoRoute<BookpublisherRoute>(
  path: PathRoute.bookPublisherRoute,
)
class BookpublisherRoute extends GoRouteData {
  const BookpublisherRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => BookpublisherCubit(),
      child: const BookpublisherPage(),
    );
  }
}
