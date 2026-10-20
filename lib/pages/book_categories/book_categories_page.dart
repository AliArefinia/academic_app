import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/helper/app_helper.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/widgets/category_item.dart';
import 'package:academic/widgets/custom_list_view.dart';
import 'package:academic/widgets/search_input_field.dart';
import 'package:academic/widgets/app_error_widget.dart';
import 'logic/book_categories_cubit.dart';
import 'dart:async';

class BookcategoriesPage extends StatefulWidget {
  const BookcategoriesPage({super.key});

  @override
  State<BookcategoriesPage> createState() => _BookcategoriesPageState();
}

class _BookcategoriesPageState extends State<BookcategoriesPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<BookcategoriesCubit>().getCategories();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    
    // Only search if query has at least 2 characters or is empty (to show all categories)
    if (query.isEmpty || query.length >= 2) {
      _debounce = Timer(const Duration(milliseconds: 1000), () {
        context.read<BookcategoriesCubit>().getCategories(query: query);
      });
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookcategoriesCubit, BookcategoriesState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => MyAppHelper().hideKeyboard(context),
          child: Scaffold(
            appBar: AppBar(
              title: Text(l10n.categoriesShort),
            ),
            body: SafeArea(
              child: _buildCategoriesTab(context, state),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoriesTab(BuildContext context, BookcategoriesState state) {
    return GestureDetector(
      onTap: () => MyAppHelper().hideKeyboard(context),
              child: state.when(
                initial: () => const SizedBox(),
                loading: () => const Center(child: CircularProgressIndicator()),
                success: (mainCategories, featuredCategories) => CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20,vertical: AppSpacing.s16),
                        child: Stack(
                          children: [
                            SearchInputField(
                              controller: _searchController,
                              Text: l10n.searchInApp,
                              onChanged: _onSearchChanged,
                            ),
                            if (state.maybeWhen(loading: () => true, orElse: () => false))
                              Positioned(
                                right: 12,
                                top: 0,
                                bottom: 0,
                                child: Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        context.colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: AppSpacing.s8),
                  ),
                  SliverToBoxAdapter(
                    child: CustomListView(
                      items: mainCategories.map((cat) => {
                        "title": cat.name,
                        "icon": cat.image ?? '',
                        "action": (BuildContext context) {
                          context.push('/sub-categories/${cat.id}', extra: cat.name);
                        }
                      }).toList(),
                      ixExpanded: false,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: AppSpacing.s30),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
                      child: Text(
                        l10n.mostPopularAudioBookCategories,
                        style: context.textTheme.headlineSmall,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: AppSpacing.s24),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: AppSpacing.s20,
                        crossAxisSpacing: AppSpacing.s12,
                        childAspectRatio: 1.6,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final category = featuredCategories[index];
                          return CategoryItem(
                            iconPath: category.image ?? '',
                            title: category.name,
                            onTap: () {
                              context.push('/sub-categories/${category.id}', extra: category.name);
                            },
                          );
                        },
                        childCount: featuredCategories.length,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: AppSpacing.s20),
                  ),
                ],
              ),
              error: (message) => AppErrorWidget(
                message: message,
                onRetry: () {
                  context.read<BookcategoriesCubit>().getCategories();
                },
              ),
            ),
    );
  }
}

