part of '../../router.dart';

class ShopShellBranchData extends StatefulShellBranchData {
  const ShopShellBranchData();
}

class ShopRouteData extends GoRouteData {
  static const String route = '/shop';

  const ShopRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => ShopCubit(getIt<ShopRepository>()),
      child: const ShopPage(),
    );
  }
}

