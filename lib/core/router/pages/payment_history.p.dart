part of '../router.dart';

@TypedGoRoute<PaymenthistoryRoute>(
  path: PathRoute.paymentHistoryRoute,
)
class PaymenthistoryRoute extends GoRouteData {
  const PaymenthistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => PaymenthistoryCubit(getIt<IPaymentHistoryRepository>()),
      child: const PaymenthistoryPage(),
    );
  }
}
