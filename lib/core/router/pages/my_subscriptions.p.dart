part of '../router.dart';

@TypedGoRoute<MysubscriptionsRoute>(
  path: PathRoute.mySubscriptionsRoute,
)
class MysubscriptionsRoute extends GoRouteData {
  const MysubscriptionsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => GetIt.I<MysubscriptionsCubit>(),
      child: const MysubscriptionsPage(),
    );
  }
}
