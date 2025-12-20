part of '../router.dart';


@TypedGoRoute<GiftcardRoute>(
  path: PathRoute.giftCardRoute,
)
class GiftcardRoute extends GoRouteData {
  const GiftcardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => GiftcardCubit(),
      child: const GiftcardPage(),
    );
  }
}
