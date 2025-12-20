part of '../router.dart';

@TypedGoRoute<AuthorbookRoute>(
  path: PathRoute.authorBookRoute,
)
class AuthorbookRoute extends GoRouteData {
  const AuthorbookRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => AuthorbookCubit(),
      child: const AuthorbookPage(),
    );
  }
}