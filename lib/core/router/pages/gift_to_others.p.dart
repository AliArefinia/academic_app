part of '../router.dart';

@TypedGoRoute<GifttoothersRoute>(
  path: PathRoute.giftToOthersRoute,
)
class GifttoothersRoute extends GoRouteData {
  const GifttoothersRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final product = state.extra as ProductModel?;
    return BlocProvider(
      create: (context) => GifttoothersCubit(),
      child: GifttoothersPage(product: product),
    );
  }
}
