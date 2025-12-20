import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/data/api/home/model/book_model.dart';
import 'package:academic/data/api/people/model/person_model.dart';
import 'logic/study_tour_detail_cubit.dart';
import 'models/study_tour_detail_model.dart';

class StudyTourDetailPage extends StatefulWidget {
  final String studyTourId;
  
  const StudyTourDetailPage({
    super.key,
    required this.studyTourId,
  });

  @override
  State<StudyTourDetailPage> createState() => _StudyTourDetailPageState();
}

class _StudyTourDetailPageState extends State<StudyTourDetailPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _treeController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _treeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _treeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _treeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _treeController, curve: Curves.easeOutCubic),
    );

    _fadeController.forward();
    _treeController.forward();
    
    context.read<StudyTourDetailCubit>().loadStudyTourDetail(widget.studyTourId);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _treeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'سیر مطالعاتی',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<StudyTourDetailCubit, StudyTourDetailState>(
        builder: (context, state) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: state.maybeWhen(
              loaded: (studyTour) => _buildStudyTourDetail(studyTour),
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64.w,
                      color: context.colorScheme.error,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      message,
                      style: context.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () => context.read<StudyTourDetailCubit>().loadStudyTourDetail(widget.studyTourId),
                      child: const Text('تلاش مجدد'),
                    ),
                  ],
                ),
              ),
              orElse: () => const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStudyTourDetail(StudyTourDetailModel studyTour) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(studyTour),
          SizedBox(height: 32.h),
          _buildTreeView(studyTour.books),
        ],
      ),
    );
  }

  Widget _buildHeader(StudyTourDetailModel studyTour) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colorScheme.primary.withOpacity(0.1),
            context.colorScheme.secondary.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: context.colorScheme.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.school,
                  color: context.colorScheme.primary,
                  size: 24.w,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      studyTour.title,
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      studyTour.categoryName,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (studyTour.description.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Text(
              studyTour.description,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.8),
              ),
            ),
          ],
          SizedBox(height: 16.h),
          Row(
            children: [
              _buildStatItem(
                icon: Icons.book_outlined,
                label: 'تعداد کتاب‌ها',
                value: '${studyTour.books.length}',
              ),
              SizedBox(width: 24.w),
              _buildStatItem(
                icon: Icons.schedule,
                label: 'مدت زمان',
                value: studyTour.estimatedDuration,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.w,
          color: context.colorScheme.primary,
        ),
        SizedBox(width: 4.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSurface,
              ),
            ),
            Text(
              label,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTreeView(List<StudyTourBookModel> books) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'مسیر مطالعاتی',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 16.h),
        AnimatedBuilder(
          animation: _treeAnimation,
          builder: (context, child) {
            return Column(
              children: books.asMap().entries.map((entry) {
                final index = entry.key;
                final book = entry.value;
                final progress = _treeAnimation.value;
                final isVisible = progress > (index * 0.1);
                
                return AnimatedOpacity(
                  opacity: isVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: _buildBookNode(book, index, books.length),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBookNode(StudyTourBookModel book, int index, int totalBooks) {
    final isLast = index == totalBooks - 1;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.colorScheme.surface,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 60.h,
                color: context.colorScheme.primary.withOpacity(0.3),
              ),
          ],
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: _buildBookCard(book),
        ),
      ],
    );
  }

  Widget _buildBookCard(StudyTourBookModel book) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            colors: [
              context.colorScheme.surfaceVariant,
              context.colorScheme.surfaceVariant.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: context.colorScheme.outline.withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.shadow.withOpacity(0.12),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
            BoxShadow(
              color: context.colorScheme.shadow.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
          onTap: () {
            // Navigate to book detail using BookModel
            final bookModel = BookModel(
              id: book.id,
              name: book.title,
              image: book.image,
              publisher: book.publisher,
              author: book.author != null ? PersonModel(name: book.author!) : null,
              translator: book.translator,
              audioTime: book.audioTime,
              content: book.content,
              price: book.price?.toDouble(),
              discountPrice: book.discountPrice?.toDouble(),
              peopleRates: book.peopleRates,
              numOfPeopleRates: book.numOfPeopleRates,
              type: book.type,
            );
            ProductRoute(bookModel).push(context);
          },
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: context.colorScheme.shadow.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.network(
                        book.image,
                        width: 70.w,
                        height: 90.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 70.w,
                            height: 90.h,
                            decoration: BoxDecoration(
                              color: context.colorScheme.surfaceVariant.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              Icons.menu_book_rounded,
                              color: context.colorScheme.onSurface.withOpacity(0.5),
                              size: 32.w,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onSurface,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 6.h),
                        if (book.author != null)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: context.colorScheme.surfaceVariant.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              book.author!,
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.colorScheme.onSurface.withOpacity(0.8),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        SizedBox(height: 12.h),
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6.r),
                                border: Border.all(
                                  color: Colors.amber.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    size: 14.w,
                                    color: Colors.amber,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    book.avgRate?.toStringAsFixed(1) ?? '0.0',
                                    style: context.textTheme.bodySmall?.copyWith(
                                      color: Colors.amber.shade700,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (book.audioTime != null)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: context.colorScheme.surfaceVariant.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.schedule_rounded,
                                      size: 14.w,
                                      color: context.colorScheme.onSurface.withOpacity(0.6),
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      book.audioTime!,
                                      style: context.textTheme.bodySmall?.copyWith(
                                        color: context.colorScheme.onSurface.withOpacity(0.7),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceVariant.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16.w,
                      color: context.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

