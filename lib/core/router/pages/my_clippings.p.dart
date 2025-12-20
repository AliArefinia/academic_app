part of '../router.dart';

@TypedGoRoute<MyClippingsRoute>(
  path: PathRoute.myClippingsRoute,
)
class MyClippingsRoute extends GoRouteData {
  const MyClippingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => getIt<MyClippingsCubit>(),
      child: const MyClippingsPage(),
    );
  }
}
