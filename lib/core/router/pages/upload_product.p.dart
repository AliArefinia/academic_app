part of '../router.dart';

@TypedGoRoute<UploadproductRoute>(
  path: PathRoute.uploadProductRoute,
)

class UploadproductRoute extends GoRouteData {
  const UploadproductRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => UploadProductCubit(
        getIt<IProductRequestRepository>(),
        getIt<ICategoriesRepository>(),
      ),
      child: const UploadProductPage(),
    );
  }
}

