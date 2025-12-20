part of '../router.dart';

@TypedGoRoute<SelectprogramlanguageRoute>(
  path: PathRoute.selectProgramLanguageRoute,
)
class SelectprogramlanguageRoute extends GoRouteData {
  const SelectprogramlanguageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => SelectprogramlanguageCubit(),
      child: const SelectprogramlanguagePage(),
    );
  }
}
