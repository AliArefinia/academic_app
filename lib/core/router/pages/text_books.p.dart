part of '../router.dart';

@TypedGoRoute<TextbooksRoute>(
  path: PathRoute.textBooksRoute,
)
class TextbooksRoute extends GoRouteData {
  const TextbooksRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => TextbooksCubit(),
      child: const TextbooksPage(),
    );
  }
}