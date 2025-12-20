part of '../router.dart';

@TypedGoRoute<ProductRoute>(
  path: PathRoute.productRoute,
)
class ProductRoute extends GoRouteData {
  final BookModel $extra;

  const ProductRoute(this.$extra);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final productId = $extra.idAsInt ?? 0;
            print('DEBUG: Navigating to product with ID: $productId (original: ${$extra.id})');
            return ProductCubit()..fetchProduct(productId);
          },
        ),
        BlocProvider(
          create: (context) => MycommentsCubit(),
        ),
      ],
      child: ProductPage($extra),
    );
  }
}
