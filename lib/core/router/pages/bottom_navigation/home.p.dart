part of '../../router.dart';

class HomeShellBranchData extends StatefulShellBranchData {
  const HomeShellBranchData();
}

class HomeRouteData extends GoRouteData {
  static const String route = '/home';

  const HomeRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomePageCubit(getIt<HomeRepository>()),
        ),
        BlocProvider(
          create: (context) => getIt<CartCubit>()..getCart(),
        ),
      ],
      child: const HomepagePage(),
    );
  }
}
