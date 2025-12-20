part of '../../router.dart';

@TypedStatefulShellRoute<MainShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<HomeShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeRouteData>(
          path: HomeRouteData.route,
          routes: [],
        ),
      ],
    ),
    TypedStatefulShellBranch<ProfileShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ProfileRouteData>(
          path: ProfileRouteData.route,
          routes: [],
        ),
      ],
    ),
    TypedStatefulShellBranch<ShopShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<ShopRouteData>(
          path: ShopRouteData.route,
          routes: [],
        ),
      ],
    ),
    TypedStatefulShellBranch<CategoryShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<CategoryRouteData>(
          path: CategoryRouteData.route,
          routes: [],
        ),
      ],
    ),
    TypedStatefulShellBranch<MyBooksShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<MyBooksRouteData>(
          path: MyBooksRouteData.route,
          routes: [],
        ),
      ],
    ),
  ],
)
class MainShellRouteData extends StatefulShellRouteData {
  const MainShellRouteData();

  static final $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return AppShellRouteScreen(
      navigationShell: navigationShell,
      // children: children,
    );
  }
}
