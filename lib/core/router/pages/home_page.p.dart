part of '../router.dart';

@TypedGoRoute<HomepageRoute>(
  path: PathRoute.homePageRoute,
)
class HomepageRoute extends GoRouteData {
  const HomepageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomePageCubit>(
      create: (context) => HomePageCubit(getIt<HomeRepository>()),
        ),
        BlocProvider<ProductCubit>(
          create: (context) => getIt<ProductCubit>(),
        ),
      ],
      child: const HomepagePage(),
    );
  }
}