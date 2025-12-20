part of '../router.dart';

@TypedGoRoute<BuysubscriptionRoute>(
  path: PathRoute.buySubscriptionRoute,
)
class BuysubscriptionRoute extends GoRouteData {
  const BuysubscriptionRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => GetIt.I<BuysubscriptionCubit>(),
      child: const BuysubscriptionPage(),
    );
  }
}
