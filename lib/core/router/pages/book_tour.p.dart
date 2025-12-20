part of '../router.dart';


@TypedGoRoute<BooktourRoute>(
  path: PathRoute.bookTourRoute,
)
class BooktourRoute extends GoRouteData {
  const BooktourRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => BooktourCubit(
        getIt<BookExcerptsRepository>(),
        getIt<ILikesRepository>(),
      ),
      child: const BooktourPage(),
    );
  }
}
