part of '../router.dart';

@TypedGoRoute<MycommentsmainRoute>(
  path: PathRoute.myCommentsMainRoute,
)
class MycommentsmainRoute extends GoRouteData {
  const MycommentsmainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => MycommentsmainCubit(getIt<IUserReviewsRepository>()),
      child: const MycommentsmainPage(),
    );
  }
}
