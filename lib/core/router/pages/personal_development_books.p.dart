part of '../router.dart';

@TypedGoRoute<PersonaldevelopmentbooksRoute>(
  path: PathRoute.personalDevelopmentBooksRoute + '/:id/:title',
)
class PersonaldevelopmentbooksRoute extends GoRouteData {
  final int id;
  final String title;
  const PersonaldevelopmentbooksRoute({required this.id, required this.title});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => PersonaldevelopmentbooksCubit(),
      child: CategoryProductsPage(categoryId: id, categoryTitle: title),
    );
  }
}