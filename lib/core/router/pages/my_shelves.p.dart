part of '../router.dart';


@TypedGoRoute<MyshelvesRoute>(
  path: PathRoute.myShelvesRoute,
  routes: [
    TypedGoRoute<BookCaseDetailRoute>(
      path: 'case/:id/:name',
    ),
  ],
)
class MyshelvesRoute extends GoRouteData {
  const MyshelvesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => MyshelvesCubit(getIt<BookCaseRepository>())..fetchShelves(),
      child: const MyshelvesPage(),
    );
  }
}

class BookCaseDetailRoute extends GoRouteData {
  final int id;
  final String name;

  const BookCaseDetailRoute({required this.id, required this.name});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => BookCaseDetailCubit(getIt<BookCaseRepository>())..fetchBookCase(id),
      child: BookCaseDetailPage(caseId: id, caseName: name),
    );
  }
}