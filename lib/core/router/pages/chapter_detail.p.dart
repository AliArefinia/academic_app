part of '../router.dart';

@TypedGoRoute<ChapterDetailRoute>(
  path: '/chapter-detail/:chapterId',
)
class ChapterDetailRoute extends GoRouteData {
  final int chapterId;

  const ChapterDetailRoute({required this.chapterId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => getIt<ChapterDetailCubit>()..loadChapterDetail(chapterId),
      child: ChapterDetailPage(chapterId: chapterId),
    );
  }
}
