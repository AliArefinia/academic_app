import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/router.dart';
import 'bottom_navigation.dart';

class AppShellRouteScreen extends StatelessWidget {
  const AppShellRouteScreen({
    required this.navigationShell,
    super.key,
    // required this.children,
  });

  final StatefulNavigationShell navigationShell;

  // final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final matchedLocation = GoRouterState.of(context).fullPath;
        print("Matched Location: $matchedLocation");
        if (matchedLocation == HomeRouteData.route) {
          return true;
        } else {
          const HomeRouteData().go(context);

          return false;
        }
      },
      child: Scaffold(
          body: SafeArea(
            child: navigationShell,
          ),
          bottomNavigationBar: HandleBottomNavigationAnimation(
            navigationShell: navigationShell,
            onTap: (index) => _onTap(context, index),
          )),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: false,
    );
  }
}

class HandleBottomNavigationAnimation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final ValueChanged<int>? onTap;

  const HandleBottomNavigationAnimation(
      {super.key, required this.navigationShell, this.onTap});

  @override
  Widget build(BuildContext context) {
    bool showBottomNavigation0(BuildContext context) {
      final matchedLocation = GoRouterState.of(context).fullPath;
      print("Current Path: $matchedLocation");
      return true;
    }

    final bool showBottomNavigation = showBottomNavigation0(context);
    return showBottomNavigation
        ? BottomNavigationWidget(
            currentIndex: navigationShell.currentIndex,
            onTap: onTap,
          )
        : const SizedBox();
  }
}

class AnimatedBranchContainer extends StatelessWidget {
  /// Creates a AnimatedBranchContainer
  const AnimatedBranchContainer(
      {super.key, required this.currentIndex, required this.children});

  /// The index (in [children]) of the branch Navigator to display.
  final int currentIndex;

  /// The children (branch Navigators) to display in this container.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: children.mapIndexed(
      (int index, Widget navigator) {
        return AnimatedScale(
          scale: index == currentIndex ? 1 : 1.5,
          duration: const Duration(milliseconds: 200),
          child: AnimatedOpacity(
            opacity: index == currentIndex ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: _branchNavigatorWrapper(index, navigator),
          ),
        );
      },
    ).toList());
  }

  Widget _branchNavigatorWrapper(int index, Widget navigator) => IgnorePointer(
        ignoring: index != currentIndex,
        child: TickerMode(
          enabled: index == currentIndex,
          child: navigator,
        ),
      );
}

extension IterableExtension<E> on List<E> {
  List<T> mapIndexed<T>(T Function(int index, E value) f) {
    return List<T>.generate(length, (index) => f(index, this[index]));
  }
}
