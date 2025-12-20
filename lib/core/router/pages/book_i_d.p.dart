part of '../router.dart';

@TypedGoRoute<BookidRoute>(
  path: PathRoute.bookIDRoute,
)
class BookidRoute extends GoRouteData {
  final String id;
  final String? name;
  final String? image;
  final String? type;
  final String? publisher;
  final String? translator;
  final double? price;
  final double? discountPrice;

  const BookidRoute({
    required this.id,
    this.name,
    this.image,
    this.type,
    this.publisher,
    this.translator,
    this.price,
    this.discountPrice,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final product = ProductModel(
      id: id,
      name: name,
      image: image,
      type: type,
      publisher: publisher,
      translator: translator,
      price: price,
      discountPrice: discountPrice,
    );
    return BlocProvider(
      create: (context) => BookidCubit(),
      child: BookidPage(product: product),
    );
  }
}
