part of '../router.dart';

@TypedGoRoute<VerificationRoute>(
  path: PathRoute.verificationRoute,
)
class VerificationRoute extends GoRouteData {
  final String phone;
  final bool? isInvited;
  final bool? hasPassword;
  final bool newUser;
  const VerificationRoute(this.phone, this.isInvited, this.hasPassword, this.newUser);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => VerificationCubit(
        getIt<AuthRepo>(),
        getIt<ICategoriesRepository>(),
      ),
      child: VerificationPage(phone, isInvited, hasPassword, newUser),
    );
  }
}
