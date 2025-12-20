part of '../router.dart';


@TypedGoRoute<UserprofileRoute>(
  path: PathRoute.userProfileRoute,
)
class UserprofileRoute extends GoRouteData {
  const UserprofileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
        create: (context) => UserprofileCubit(getIt<LocalStorage>(), getIt<AuthRepo>(), getIt<ProfileRepository>()),
      child: const UserprofilePage(),
    );
  }
}






