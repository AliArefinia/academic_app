part of '../router.dart';

@TypedGoRoute<MycommentsRoute>(
  path: PathRoute.myCommentsRoute,
)
class MycommentsRoute extends GoRouteData {
  final String bookName;
  final String bookImage;
  final int rate;
  final int productId;

  const MycommentsRoute({
    required this.bookName,
    required this.bookImage,
    required this.rate,
    required this.productId,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => MycommentsCubit(),
      child: MycommentsPage(
        bookName: bookName,
        bookImage: bookImage,
        rate: rate,
        productId: productId,
      ),
    );
  }
}
