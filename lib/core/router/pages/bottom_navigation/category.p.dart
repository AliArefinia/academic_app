part of '../../router.dart';


class CategoryShellBranchData extends StatefulShellBranchData {
  const CategoryShellBranchData();
}

class CategoryRouteData extends GoRouteData {
  static const String route = '/category';

  const CategoryRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => BookcategoriesCubit(getIt<ICategoriesRepository>()),
      child: const BookcategoriesPage(),
    );
  }
}
