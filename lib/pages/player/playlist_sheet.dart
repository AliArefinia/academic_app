import 'package:flutter/material.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/data/api/product/model/product_model.dart';
import 'package:academic/core/player/global_player.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:universal_image_flutter/universal_image_flutter.dart';

class PlaylistSheet extends StatefulWidget {
  final String cover;
  final String title;
  final String publisher;
  final String subject;
  final String category;
  final List<HeadlineModel> headlines;
  final double progress;
  final String totalDuration;

  const PlaylistSheet({
    super.key,
    required this.cover,
    required this.title,
    required this.publisher,
    required this.subject,
    required this.category,
    required this.headlines,
    required this.progress,
    required this.totalDuration,
  });

  @override
  State<PlaylistSheet> createState() => _PlaylistSheetState();
}

class _PlaylistSheetState extends State<PlaylistSheet> {
  bool isDownloadingAll = false;
  double downloadProgress = 0.0;
  List<int> failedIndexes = [];
  List<int> downloadingIndexes = [];
  bool downloadSuccess = false;
  String? downloadError;

  String _fixStorageUrl(String url) {
    if (url.contains('/storage/storage/')) {
      return url.replaceFirst('/storage/storage/', '/storage/');
    }
    return url;
  }

  Future<void> downloadAll({List<int>? onlyIndexes}) async {
    setState(() {
      isDownloadingAll = true;
      downloadProgress = 0.0;
      downloadError = null;
      downloadSuccess = false;
      failedIndexes.clear();
      downloadingIndexes.clear();
    });
    final dir = await getApplicationDocumentsDirectory();
    int completed = 0;
    final total = onlyIndexes?.length ?? widget.headlines.length;
    final indexes = onlyIndexes ?? List.generate(widget.headlines.length, (i) => i);
    for (final i in indexes) {
      final url = widget.headlines[i].file;
      final fixedUrl = _fixStorageUrl(url);
      final fileName = fixedUrl.split('/').last;
      final filePath = '${dir.path}/$fileName';
      try {
        setState(() { downloadingIndexes.add(i); });
        if (!File(filePath).existsSync()) {
          await Dio().download(fixedUrl, filePath);
        }
        completed++;
        setState(() {
          downloadProgress = completed / total;
          downloadingIndexes.remove(i);
        });
      } catch (e) {
        failedIndexes.add(i);
        setState(() {
          downloadProgress = completed / total;
          downloadingIndexes.remove(i);
        });
      }
    }
    setState(() {
      isDownloadingAll = false;
      downloadSuccess = failedIndexes.isEmpty;
      downloadError = failedIndexes.isNotEmpty ? 'برخی ترک‌ها دانلود نشدند.' : null;
    });
  }

  Future<bool> isTrackDownloaded(String url) async {
    final fixedUrl = _fixStorageUrl(url);
    final fileName = fixedUrl.split('/').last;
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/$fileName';
    return File(filePath).existsSync();
  }

  Future<bool> allTracksDownloaded() async {
    for (final h in widget.headlines) {
      if (!await isTrackDownloaded(h.file)) return false;
    }
    return true;
  }

  Future<void> playTrackWithCacheCheck(int index, GlobalPlayer globalPlayer) async {
    final url = widget.headlines[index].file;
    final fixedUrl = _fixStorageUrl(url);
    final fileName = fixedUrl.split('/').last;
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/$fileName';
    String source;
    if (File(filePath).existsSync()) {
      source = 'file://$filePath';
      print('[PlayerCubit] Playing from cache: $source');
    } else {
      source = fixedUrl;
      print('[PlayerCubit] Playing from network: $source');
    }

    // Update playlist state if needed
    if (!globalPlayer.playerCubit.state.hasPlaylist) {
      await globalPlayer.playerCubit.initPlaylist(widget.headlines, index);
    } else {
      // If playlist exists, just update the current track
      await globalPlayer.playerCubit.playTrack(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final globalPlayer = GlobalPlayer.of(context);
    if (globalPlayer == null) return const SizedBox.shrink();
    return FutureBuilder<bool>(
      future: allTracksDownloaded(),
      builder: (context, snapshot) {
        final allDownloaded = snapshot.data ?? false;
        return Container(
          height: context.fullHeight * 0.85,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.paddingDefault,
                  vertical: context.paddingDefault,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: [
                    // Book Cover
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: UniversalImageLoader(
                        path: widget.cover,
                        option: UniversalImageLoaderOption(
                          width: context.fullWidth * 0.22,
                          height: context.fullWidth * 0.32,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: context.paddingSmall),
                    // Book Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppSpacing.s8,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            textAlign: TextAlign.start,
                            textDirection: TextDirection.rtl,
                          ),
                          Text(
                            widget.publisher,
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.onSurface,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.start,
                            textDirection: TextDirection.rtl,
                          ),
                          Text(
                            'موضوع: ${widget.subject}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.start,
                            textDirection: TextDirection.rtl,
                          ),
                          Text(
                            'رده‌بندی کتاب: ${widget.category}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.start,
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(height: context.paddingSmall),
                          Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.paddingSmall,
                                  vertical: context.paddingTiny,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF3D7),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  '${(widget.progress * 100).toStringAsFixed(0)}% شنیده‌اید',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFFFFA000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(width: context.paddingTiny),
                              Text(
                                widget.totalDuration,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Close Button
                    IconButton(
                      icon: const Icon(Icons.close, size: 32),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              // Download All Button
              if (!allDownloaded)
                GestureDetector(
                  onTap: isDownloadingAll ? null : () => downloadAll(),
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: isDownloadingAll
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(value: downloadProgress),
                              ),
                              SizedBox(width: 12),
                              Text('${(downloadProgress * 100).toStringAsFixed(0)}%'),
                            ],
                          )
                        : (failedIndexes.isNotEmpty)
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.error, color: Colors.red),
                                      SizedBox(width: 8),
                                      Text('برخی ترک‌ها دانلود نشدند:', style: TextStyle(color: Colors.red, fontSize: 13)),
                                    ],
                                  ),
                                  ...failedIndexes.map((i) => Text(widget.headlines[i].title, style: TextStyle(color: Colors.red, fontSize: 12))),
                                  TextButton(
                                    onPressed: () => downloadAll(onlyIndexes: failedIndexes),
                                    child: Text('تلاش مجدد فقط برای ترک‌های ناموفق'),
                                  ),
                                ],
                              )
                            : downloadSuccess
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.check_circle, color: Colors.green),
                                      SizedBox(width: 8),
                                      Text('همه ترک‌ها با موفقیت دانلود شدند!', style: TextStyle(color: Colors.green)),
                                    ],
                                  )
                                : Center(
                                    child: Text(
                                      'دانلود همه',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                  ),
                ),
              SizedBox(height: 16),
              // Playlist Items
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(context.paddingDefault),
                  itemCount: widget.headlines.length,
                  separatorBuilder: (context, i) => Divider(
                    color: Theme.of(context).colorScheme.outline,
                    thickness: 1,
                    height: context.paddingLarge,
                  ),
                  itemBuilder: (context, i) {
                    final headline = widget.headlines[i];
                    final isCurrentTrack = globalPlayer.playerCubit.state.currentTrackIndex == i;
                    final isPlaying = isCurrentTrack && globalPlayer.playerCubit.state.isPlaying;
                    final isLoading = globalPlayer.playerCubit.state.isLoading;
                    final isDownloading = downloadingIndexes.contains(i);
                    return FutureBuilder<bool>(
                      future: isTrackDownloaded(headline.file),
                      builder: (context, snap) {
                        final isDownloaded = snap.data ?? false;
                        return _PlaylistItem(
                          title: headline.title,
                          duration: _formatTime(headline.time),
                          size: _formatFileSize(headline.file),
                          onPlay: (isLoading || isDownloading) ? null : () async {
                            await playTrackWithCacheCheck(i, globalPlayer);
                          },
                          onDownload: (isDownloaded || isDownloading) ? null : () => downloadAll(onlyIndexes: [i]),
                          isPlaying: isPlaying,
                          isLoading: isLoading && globalPlayer.playerCubit.state.currentTrackIndex == i,
                          isDownloading: isDownloading,
                          isDownloaded: isDownloaded,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatTime(TimeModel time) {
    final hours = int.tryParse(time.hours ?? '0') ?? 0;
    final minutes = int.tryParse(time.minutes ?? '0') ?? 0;
    final seconds = int.tryParse(time.seconds ?? '0') ?? 0;
    
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String _formatFileSize(String file) {
    try {
      final bytes = file.length;
      final mb = (bytes / 1024 / 1024).toStringAsFixed(1);
      return '$mb MB';
    } catch (e) {
      return '0.0 MB';
    }
  }
}

class _PlaylistItem extends StatelessWidget {
  final String title;
  final String duration;
  final String size;
  final VoidCallback? onPlay;
  final VoidCallback? onDownload;
  final bool isPlaying;
  final bool isLoading;
  final bool isDownloading;
  final bool isDownloaded;

  const _PlaylistItem({
    required this.title,
    required this.duration,
    required this.size,
    required this.onPlay,
    required this.onDownload,
    required this.isPlaying,
    required this.isLoading,
    required this.isDownloading,
    required this.isDownloaded,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        // Play button
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isPlaying ? const Color(0xFF2196F3) : const Color(0xFFFFA000),
            shape: BoxShape.circle,
          ),
          child: isLoading
              ? const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                )
              : IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 24,
                  ),
                  onPressed: onPlay,
                  padding: EdgeInsets.zero,
                ),
        ),
        const SizedBox(width: 12),
        // Title and duration
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isPlaying ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 4),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    duration,
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Download info
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            isDownloaded
                ? Icon(Icons.check_circle, color: Colors.green)
                : isDownloading
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : IconButton(
                        icon: const Icon(Icons.download_rounded),
                        onPressed: onDownload,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                      ),
            Text(
              size,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
} 