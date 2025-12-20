part of '../../router.dart';

class MyBooksShellBranchData extends StatefulShellBranchData {
  const MyBooksShellBranchData();
}

class MyBooksRouteData extends GoRouteData {
  static const String route = '/myBook';

  const MyBooksRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => MyBooksCubit(getIt<MyBooksRepository>()),
      child: const MybooksPage(),
    );
  }
}
