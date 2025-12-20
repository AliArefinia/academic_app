part of '../router.dart';

@TypedGoRoute<ReviewsandratingRoute>(
  path: PathRoute.reviewsAndRatingRoute,
)
class ReviewsandratingRoute extends GoRouteData {
  const ReviewsandratingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => ReviewsandratingCubit(),
      child: const ReviewsandratingPage(),
    );
  }
}






