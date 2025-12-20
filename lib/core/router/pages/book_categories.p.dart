part of '../router.dart';


@TypedGoRoute<BookcategoriesRoute>(
  path: PathRoute.bookCategoriesRoute,
)
class BookcategoriesRoute extends GoRouteData {
  const BookcategoriesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => BookcategoriesCubit(getIt<ICategoriesRepository>()),
      child: const BookcategoriesPage(),
    );
  }
}

@TypedGoRoute<SubCategoriesRoute>(
  path: '/sub-categories/:categoryId',
)
class SubCategoriesRoute extends GoRouteData {
  final int categoryId;

  const SubCategoriesRoute({required this.categoryId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final categoryTitle = state.extra as String? ?? '';
    return BlocProvider(
      create: (context) => SubCategoriesCubit(getIt<ICategoriesRepository>()),
      child: SubCategoriesPage(categoryId: categoryId, categoryTitle: categoryTitle),
    );
  }
}

@TypedGoRoute<CategoryProductsRoute>(
  path: '/category-products/:id/:title',
)
class CategoryProductsRoute extends GoRouteData {
  final int id;
  final String title;
  const CategoryProductsRoute({required this.id, required this.title});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CategoryProductsPage(categoryId: id, categoryTitle: title);
  }
}