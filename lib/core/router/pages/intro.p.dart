part of '../router.dart';

@TypedGoRoute<IntroRoute>(
  path: PathRoute.introRoute,
)
class IntroRoute extends GoRouteData {
  const IntroRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return  IntroPage();
  }
}
