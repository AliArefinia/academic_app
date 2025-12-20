part of '../router.dart';

@TypedGoRoute<LangRoute>(
  path: PathRoute.langRoute,
)
class LangRoute extends GoRouteData {
  const LangRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SelectLanguageScreen();
  }
}
