import 'package:flutter/material.dart';
import 'package:academic/pages/player/player_page.dart';
import 'package:academic/data/api/product/model/product_model.dart';
import 'package:academic/core/player/global_player.dart';

Future<void> showPlayerSheet(BuildContext context, ProductModel product) async {
  final globalPlayer = GlobalPlayer.of(context);
  if (globalPlayer == null) return;

  // Store current playback state
  final wasPlaying = globalPlayer.playerCubit.state.isPlaying;
  final currentPosition = globalPlayer.playerCubit.state.position;

  // Hide mini player when sheet is opened
  globalPlayer.playerCubit.setMiniPlayerVisible(false);

  // Show the bottom sheet using the current context
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    routeSettings: const RouteSettings(name: 'player_sheet'),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.95,
        minChildSize: 0.95,
        maxChildSize: 0.95,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return PlayerPage(
            cover: product.image ?? '',
            title: product.name ?? '',
            publisher: product.publisher ?? '',
            subject: 'Audio Book',
            category: (product.categories?.isNotEmpty == true)
                ? (product.categories!.first.name ?? 'Uncategorized')
                : 'Uncategorized',
            audioUrl: product.sampleAudio,
            product: product,
          );
        },
      );
    },
  ).whenComplete(() {
    // Show mini player when sheet is closed and restore previous state if needed
    globalPlayer.playerCubit.setMiniPlayerVisible(true);
  });
} 