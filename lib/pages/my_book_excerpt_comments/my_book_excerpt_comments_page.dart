import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/data/model/my_book_excerpt_comment.dart';
import 'logic/my_book_excerpt_comments_cubit.dart';

class MyBookExcerptCommentsPage extends StatelessWidget {
  final int excerptId;
  final String bookImage;
  final String userNameAndFamily;
  final String date;
  final String userDescription;
  final String userImage;
  final int? numOfLike;
  final int? numOfComment;

  const MyBookExcerptCommentsPage({
    super.key,
    required this.excerptId,
    required this.bookImage,
    required this.userNameAndFamily,
    required this.date,
    required this.userImage,
    this.numOfLike,
    this.numOfComment,
    required this.userDescription,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBookExcerptCommentsCubit, MyBookExcerptCommentsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('نظرات بریده کتاب'),
          ),
          body: Column(
            children: [
              // Book excerpt info
              Container(
                margin: const EdgeInsets.all(AppSpacing.s16),
                padding: const EdgeInsets.all(AppSpacing.s16),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.corner10),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.corner8),
                      child: Image.network(
                        bookImage,
                        width: 60,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 60,
                          height: 80,
                          color: Colors.grey[300],
                          child: const Icon(Icons.book),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.s12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userNameAndFamily,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.s4),
                          Text(
                            date,
                            style: context.textTheme.bodySmall,
                          ),
                          const SizedBox(height: AppSpacing.s8),
                          Text(
                            userDescription,
                            style: context.textTheme.bodyMedium,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Comments list
              Expanded(
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : state.error != null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.error, size: 48, color: Colors.red),
                                const SizedBox(height: AppSpacing.s16),
                                Text(
                                  'خطا در بارگذاری نظرات',
                                  style: context.textTheme.titleMedium,
                                ),
                                const SizedBox(height: AppSpacing.s8),
                                Text(
                                  state.error!,
                                  style: context.textTheme.bodySmall,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: AppSpacing.s16),
                                ElevatedButton(
                                  onPressed: () => context.read<MyBookExcerptCommentsCubit>().fetchComments(),
                                  child: const Text('تلاش مجدد'),
                                ),
                              ],
                            ),
                          )
                        : state.comments.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.comment_outlined, size: 48, color: Colors.grey),
                                    const SizedBox(height: AppSpacing.s16),
                                    Text(
                                      'هنوز نظری ثبت نشده است',
                                      style: context.textTheme.titleMedium,
                                    ),
                                    const SizedBox(height: AppSpacing.s8),
                                    Text(
                                      'اولین نفری باشید که نظر می‌دهد',
                                      style: context.textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
                                itemCount: state.comments.length,
                                itemBuilder: (context, index) {
                                  final comment = state.comments[index];
                                  return CommentItem(comment: comment);
                                },
                              ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CommentItem extends StatelessWidget {
  final MyBookExcerptComment comment;

  const CommentItem({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.s12),
      padding: const EdgeInsets.all(AppSpacing.s16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.corner10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: context.colorScheme.primary.withOpacity(0.1),
            child: ClipOval(
              child: Image.network(
                comment.avatar,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.person,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.text,
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

