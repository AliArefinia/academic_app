import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/helper/app_helper.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/data/api/home/model/book_model.dart';
import 'package:academic/widgets/other_booksBy_author_widget.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import 'package:academic/core/router/router.dart';
import 'logic/tag_books_cubit.dart';
import 'logic/tag_books_state.dart';

class TagBooksPage extends StatefulWidget {
  final int? tagId;
  final int? authorId;
  final int? publisherId;
  final String? publisherName;
  final String title;
  
  const TagBooksPage({
    super.key, 
    this.tagId,
    this.authorId,
    this.publisherId,
    this.publisherName,
    required this.title,
  });

  @override
  State<TagBooksPage> createState() => _TagBooksPageState();
}

class _TagBooksPageState extends State<TagBooksPage> {
  late TagBooksCubit _cubit;
  bool isGridView = true;

  @override
  void initState() {
    super.initState();
    _cubit = TagBooksCubit();
    _cubit.fetchTagBooks(
      tagId: widget.tagId,
      authorId: widget.authorId,
      publisherId: widget.publisherId,
      publisherName: widget.publisherName,
    );
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<TagBooksCubit, TagBooksState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => MyAppHelper().hideKeyboard(context),
            child: Scaffold(
              appBar: CustomAppBar(
                title: widget.title,
                icon: Icons.label_rounded,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => context.pop(),
                ),
                actions: [
                  IconButton(
                    icon: Icon(isGridView ? Icons.list : Icons.grid_view),
                    onPressed: () {
                      setState(() {
                        isGridView = !isGridView;
                      });
                    },
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
                child: Column(
                  children: [
                    const SizedBox(height: AppSpacing.s20),
                    Expanded(
                      child: state.when(
                        initial: () => const Center(child: Text('در حال بارگذاری...')),
                        loading: () => const Center(child: CircularProgressIndicator()),
                        success: (books) => _buildBooksList(books),
                        error: (message) => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.error_outline, size: 64, color: Colors.red),
                              const SizedBox(height: 16),
                              Text('خطا: $message'),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => _cubit.fetchTagBooks(
                                  tagId: widget.tagId,
                                  authorId: widget.authorId,
                                  publisherId: widget.publisherId,
                                  publisherName: widget.publisherName,
                                ),
                                child: const Text('تلاش مجدد'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBooksList(List<BookModel> books) {
    if (books.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.book_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('هیچ کتابی یافت نشد'),
          ],
        ),
      );
    }

    return isGridView
        ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return OtherBooksByAuthorWidget(
                bookModel: book,
                onTap: () => ProductRoute(book).push(context),
              );
            },
          )
        : ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: OtherBooksByAuthorWidget(
                  bookModel: book,
                  onTap: () => ProductRoute(book).push(context),
                ),
              );
            },
          );
  }
}
