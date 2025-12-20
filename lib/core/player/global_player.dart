import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/pages/player/logic/player_cubit.dart';
import 'package:academic/pages/player/logic/player_state.dart';
import 'package:academic/core/services/reading_progress_service.dart';

class GlobalPlayer extends InheritedWidget {
  final PlayerCubit playerCubit;
  final String? currentTitle;
  final String? currentCover;

  const GlobalPlayer({
    super.key,
    required this.playerCubit,
    required this.currentTitle,
    required this.currentCover,
    required super.child,
  });

  static GlobalPlayer? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GlobalPlayer>();
  }

  @override
  bool updateShouldNotify(GlobalPlayer oldWidget) {
    return playerCubit != oldWidget.playerCubit ||
        currentTitle != oldWidget.currentTitle ||
        currentCover != oldWidget.currentCover;
  }
}

class GlobalPlayerScope extends StatelessWidget {
  final Widget child;

  const GlobalPlayerScope({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayerCubit(context.read<ReadingProgressService>()),
      child: BlocBuilder<PlayerCubit, PlayerState>(
        builder: (context, state) {
          return GlobalPlayer(
            playerCubit: context.read<PlayerCubit>(),
            currentTitle: state.currentTitle,
            currentCover: state.currentCover,
            child: child,
          );
        },
      ),
    );
  }
} 