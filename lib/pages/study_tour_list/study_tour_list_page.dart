import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/widgets/error_state_widget.dart';
import 'logic/study_tour_list_cubit.dart';
import 'models/study_tour_model.dart';

class StudyTourListPage extends StatefulWidget {
  const StudyTourListPage({super.key});

  @override
  State<StudyTourListPage> createState() => _StudyTourListPageState();
}

class _StudyTourListPageState extends State<StudyTourListPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _fadeController.forward();

    // بارگذاری اولیه لیست
    _loadStudyToursIfNeeded();
  }

  void _loadStudyToursIfNeeded() {
    final currentState = context.read<StudyTourListCubit>().state;
    // اگر لیست هنوز بارگذاری نشده یا خالی است، بارگذاری می‌کنیم
    if (currentState.maybeWhen(
      initial: () => true,
      error: (_) => true,
      orElse: () => false,
    )) {
      context.read<StudyTourListCubit>().loadStudyTours();
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          l10n.myStudyTours,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              // Navigate to request page and wait for result
              final result = await context.push('/study-tour-request');
              // اگر نتیجه true بود (یعنی درخواست ذخیره شده)، لیست را رفرش می‌کنیم
              if (result == true) {
                context.read<StudyTourListCubit>().loadStudyTours();
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<StudyTourListCubit, StudyTourListState>(
        builder: (context, state) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: state.maybeWhen(
              loaded: (studyTours) => _buildStudyToursList(studyTours),
              empty: () => _buildEmptyState(),
              error: (message) => ErrorStateWidget(
                error: message,
                onRetry: () => context.read<StudyTourListCubit>().loadStudyTours(),
              ),
              orElse: () => const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStudyToursList(List<StudyTourModel> studyTours) {
    if (studyTours.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: EdgeInsets.all(20.w),
      physics: const BouncingScrollPhysics(),
      itemCount: studyTours.length,
      itemBuilder: (context, index) {
        final studyTour = studyTours[index];
        return _buildStudyTourCard(studyTour, index);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(32.w),
            decoration: BoxDecoration(
              color: context.colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.school_outlined,
              size: 64.w,
              color: context.colorScheme.primary,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            l10n.noStudyToursYet,
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            l10n.submitFirstStudyTour,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),
          ElevatedButton.icon(
            onPressed: () async {
              final result = await context.push('/study-tour-request');
              if (result == true) {
                context.read<StudyTourListCubit>().loadStudyTours();
              }
            },
            icon: const Icon(Icons.add),
            label: Text(l10n.submitStudyTour),
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colorScheme.primary,
              foregroundColor: context.colorScheme.onPrimary,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudyTourCard(StudyTourModel studyTour, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300 + (index * 100)),
      margin: EdgeInsets.only(bottom: 16.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          gradient: LinearGradient(
            colors: [
              context.colorScheme.surface,
              context.colorScheme.surfaceVariant.withOpacity(0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: context.colorScheme.outline.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.shadow.withOpacity(0.25),
              blurRadius: 32,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: context.colorScheme.shadow.withOpacity(0.15),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: context.colorScheme.shadow.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => context.push('/study-tour-detail/${studyTour.id}'),
            borderRadius: BorderRadius.circular(24.r),
            child: Container(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              context.colorScheme.primary.withOpacity(0.1),
                              context.colorScheme.secondary.withOpacity(0.1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: context.colorScheme.primary.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons.auto_stories_rounded,
                          color: context.colorScheme.primary,
                          size: 28.w,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              studyTour.title,
                              style: context.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.onSurface,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 6.h),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: context.colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: context.colorScheme.primary.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                studyTour.categoryName,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: _getStatusColor(studyTour.statusEnum).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: _getStatusColor(studyTour.statusEnum).withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          _getStatusText(studyTour.statusEnum),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: _getStatusColor(studyTour.statusEnum),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (studyTour.description.isNotEmpty) ...[
                    SizedBox(height: 16.h),
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceVariant.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: context.colorScheme.outline.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        studyTour.description,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurface.withOpacity(0.8),
                          height: 1.4,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                  
                  // Show answer if available
                  if (studyTour.answer != null && studyTour.answer!.isNotEmpty) ...[
                    SizedBox(height: 16.h),
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: context.colorScheme.primary.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lightbulb_outline,
                                size: 16.w,
                                color: context.colorScheme.primary,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                l10n.providedAnswer,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            studyTour.answer!,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.onSurface.withOpacity(0.9),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: context.colorScheme.surfaceVariant.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.schedule_rounded,
                              size: 16.w,
                              color: context.colorScheme.onSurface.withOpacity(0.7),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              studyTour.createdAt,
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.colorScheme.onSurface.withOpacity(0.8),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16.w,
                        color: context.colorScheme.onSurface.withOpacity(0.4),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(StudyTourStatus status) {
    switch (status) {
      case StudyTourStatus.pending:
        return const Color(0xFFF59E0B); // Amber
      case StudyTourStatus.approved:
        return const Color(0xFF10B981); // Emerald
      case StudyTourStatus.rejected:
        return const Color(0xFFEF4444); // Red
    }
  }

  String _getStatusText(StudyTourStatus status) {
    switch (status) {
      case StudyTourStatus.pending:
        return l10n.pending;
      case StudyTourStatus.approved:
        return l10n.approved;
      case StudyTourStatus.rejected:
        return l10n.rejected;
    }
  }
}

