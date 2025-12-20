part of '../router.dart';

@TypedGoRoute<MypurchasesRoute>(
  path: PathRoute.myPurchasesRoute,
)

class MypurchasesRoute extends GoRouteData {
  const MypurchasesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => MypurchasesCubit(getIt<IMyPurchasesRepository>()),
      child: const MypurchasesPage(),
    );
  }
}