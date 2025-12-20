part of '../router.dart';

@TypedGoRoute<InvitefriendsRoute>(
  path: PathRoute.inviteFriendsRoute,
)
class InvitefriendsRoute extends GoRouteData {
  const InvitefriendsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => getIt<InvitefriendsCubit>(),
      child: const InvitefriendsPage(),
    );
  }
}
