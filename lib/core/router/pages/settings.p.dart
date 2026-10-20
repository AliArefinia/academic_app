part of '../router.dart';

@TypedGoRoute<SettingsRoute>(
  path: PathRoute.settingsRoute,
)
class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}
