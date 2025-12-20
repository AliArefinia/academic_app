part of '../router.dart';

@TypedGoRoute<WalletRoute>(
  path: PathRoute.walletRoute,
)
class WalletRoute extends GoRouteData {
  const WalletRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => WalletCubit(),
      child: const WalletPage(),
    );
  }
}

//