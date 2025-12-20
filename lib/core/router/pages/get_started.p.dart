part of '../router.dart';

@TypedGoRoute<GetStartedRoute>(
  path: PathRoute.getStartedRoute,
)
class GetStartedRoute extends GoRouteData {
  const GetStartedRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => GetStartedCubit(),
      child: const GetStartedPage(),
    );
  }
}
