part of '../../router.dart';


class ProfileShellBranchData extends StatefulShellBranchData {
  const ProfileShellBranchData();
}

class ProfileRouteData extends GoRouteData {
  static const String route = '/profile';

  const ProfileRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      BlocProvider(
        create: (context) => UserprofileCubit(getIt<LocalStorage>(), getIt<AuthRepo>(), getIt<ProfileRepository>()),
        child: const UserprofilePage(),
      );
}
