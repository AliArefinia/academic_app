part of '../router.dart';

@TypedGoRoute<SplashRoute>(
  path: PathRoute.splashRoute,
)
class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => SplashCubit(getIt<LocalStorage>(), getIt<ISubscriptionRepository>()),
      child: const SplashPage(),
    );
  }
}
