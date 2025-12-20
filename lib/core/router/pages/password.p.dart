part of '../router.dart';

@TypedGoRoute<PasswordRoute>(
  path: PathRoute.passwordRoute,
)
class PasswordRoute extends GoRouteData {
  final String phone;
  final bool? isInvited;

  const PasswordRoute(this.phone, this.isInvited);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => PasswordCubit(getIt<AuthRepo>(), phone),
      child: PasswordPage(phone: phone, isInvited: isInvited),
    );
  }
}
