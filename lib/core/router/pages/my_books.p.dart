part of '../router.dart';

@TypedGoRoute<MybooksRoute>(
  path: PathRoute.myBooksRoute,
)

class MybooksRoute extends GoRouteData {
  const MybooksRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => MyBooksCubit(getIt<MyBooksRepository>()),
      child: MybooksPage(),
    );
  }
}