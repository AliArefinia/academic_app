part of '../router.dart';

@TypedGoRoute<MychaptersRoute>(
  path: '/my-chapters',
)
class MychaptersRoute extends GoRouteData {
  const MychaptersRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => getIt<MyChaptersCubit>(),
      child: const MyChaptersPage(),
    );
  }
}
