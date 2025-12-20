part of '../router.dart';

@TypedGoRoute<ProfilemanagementRoute>(
  path: PathRoute.profileManagementRoute,
)
class ProfilemanagementRoute extends GoRouteData {
  const ProfilemanagementRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => getIt<ProfilemanagementCubit>(),
      child: const ProfilemanagementPage(),
    );
  }
}