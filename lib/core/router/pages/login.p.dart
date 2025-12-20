part of '../router.dart';

@TypedGoRoute<LoginRoute>(
  path: PathRoute.loginRoute,
)
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => LoginCubit(getIt<AuthRepo>()),
      child: const LoginPage(),
    );
  }
}
