import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:academic/core/helper/app_helper.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/widgets/book_discount_card.dart';
import 'package:academic/widgets/other_booksBy_author_widget.dart';
import '../../gen/assets.gen.dart';
import 'logic/category_products_cubit.dart';
import 'dart:async';
import 'logic/authors_cubit.dart';
import 'package:academic/data/api/people/model/person_model.dart';
import 'widgets/people_multi_select_sheet.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import 'logic/speakers_cubit.dart';
import 'logic/publishers_cubit.dart';
import 'logic/translators_cubit.dart';

class CategoryProductsPage extends StatefulWidget {
  final int categoryId;
  final String categoryTitle;
  const CategoryProductsPage({super.key, required this.categoryId, required this.categoryTitle});

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  late CategoryProductsCubit _cubit;
  bool isGridView = true;
  final TextEditingController _searchController = TextEditingController();
  String? selectedAuthor;
  String? selectedPublisher;
  Timer? _debounce;
  List<PersonModel> selectedAuthorsList = [];
  List<PersonModel> selectedSpeakersList = [];
  List<PersonModel> selectedPublishersList = [];
  List<PersonModel> selectedTranslatorsList = [];

  @override
  void initState() {
    super.initState();
    _cubit = CategoryProductsCubit();
    _cubit.fetchCategoryProducts(categoryId: widget.categoryId);
  }


  void _onFilterPressed() {
    showFiltersDialog(context, _cubit);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<CategoryProductsCubit, CategoryProductsState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => MyAppHelper().hideKeyboard(context),
            child: Scaffold(
              appBar: CustomAppBar(
                title: widget.categoryTitle,
                icon: Icons.label_rounded,
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
                  child: Column(
                    children: [
                      const SizedBox(height: AppSpacing.s24),
                    Container(
                      height: context.fullHeight * 0.0625,
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadius.corner12),
                        color: context.colorScheme.surface,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onSubmitted: (value) {
                                if (value.isEmpty) {
                                  _cubit.fetchCategoryProducts(categoryId: widget.categoryId);
                                } else if (value.length > 1) {
                                  _cubit.fetchCategoryProducts(categoryId: widget.categoryId, query: value);
                                }
                              },
                              decoration: InputDecoration(
                                hintText: l10n.searchInApp,
                                hintStyle: context.textTheme.bodyMedium,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: context.textTheme.labelLarge,
                              textDirection: TextDirection.rtl,
                            ),
                          ),

                          if (_searchController.text.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                _cubit.fetchCategoryProducts(categoryId: widget.categoryId);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Icon(
                                  Icons.close, 
                                  size: AppSpacing.s20, 
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            )
                          else
                            SvgPicture.asset(
                              Assets.icSearch,
                              width: AppSpacing.s20,
                              height: AppSpacing.s20,
                              colorFilter: ColorFilter.mode(
                                context.colorScheme.onSurfaceVariant,
                                BlendMode.srcIn,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s20),
                    Container(
                      height: context.fullHeight * 0.07,
                      decoration: BoxDecoration(
                        color: context.colorScheme.surface,
                        borderRadius: BorderRadius.circular(AppRadius.corner12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s24),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: _onFilterPressed,
                              child: Row(
                                children: [
                                  SvgPicture.asset(Assets.icFilter),
                                  const SizedBox(width: AppSpacing.s8),
                                  Text(l10n.filterLabel, style: context.textTheme.titleMedium?.copyWith(fontSize: 15)),
                                ],
                              ),
                            ),
                            const SizedBox(width: AppSpacing.s32),
                            SvgPicture.asset(Assets.icBest),
                            const SizedBox(width: AppSpacing.s8),
                            Text(l10n.bestSelling, style: context.textTheme.titleMedium?.copyWith(fontSize: 15)),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => setState(() => isGridView = false),
                              child: SvgPicture.asset(
                                isGridView ? Assets.icVertical : Assets.icVerticalFull,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.s16),
                            GestureDetector(
                              onTap: () => setState(() => isGridView = true),
                              child: SvgPicture.asset(
                                isGridView ? Assets.icHorizontal : Assets.icHorizontalVacant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s20),
                    Expanded(
                      child: state.when(
                        initial: () => const SizedBox(),
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (message) => Center(child: Text(message)),
                        success: (products) {
                          if (products.isEmpty) {
                            return Center(child: Text(l10n.noProductsFound));
                          }
                          if (isGridView) {
                            return GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: products.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8.0,
                                childAspectRatio: 1/1.6,
                              ),
                              itemBuilder: (context, index) {
                                return OtherBooksByAuthorWidget(bookModel: products[index]);
                              },
                            );
                          } else {
                            return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final book = products[index];
                                return BookDiscountCard.fromBookModel(book);
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void showFiltersDialog(BuildContext context, CategoryProductsCubit cubit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.corner20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.s16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: AppSpacing.s16),
                    decoration: BoxDecoration(
                      color: context.colorScheme.shadow,
                      borderRadius: BorderRadius.circular(AppRadius.corner20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.filterLabel,
                          style: context.textTheme.titleLarge,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s16),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          filterItem(
                            context,
                            title: l10n.textBook,
                            isActive: cubit.isText,
                            onTap: () {
                              setModalState(() {
                                cubit.toggleText();
                              });
                            },
                          ),
                          filterItem(
                            context,
                            title: l10n.audioBook,
                            isActive: cubit.isAudio,
                            onTap: () {
                              setModalState(() {
                                cubit.toggleAudio();
                              });
                            },
                          ),
                          navigationItem(
                            context,
                            title: selectedAuthorsList.isNotEmpty
                                ? l10n.authorWithValue(selectedAuthorsList.map((a) => a.name ?? '').join(', '))
                                : l10n.author,
                            hasDivider: true,
                            onTap: () async {
                              final authorsCubit = AuthorsCubit()..fetchAuthors();
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return BlocProvider.value(
                                    value: authorsCubit,
                                    child: PeopleMultiSelectSheet<AuthorsCubit, AuthorsState>(
                                      title: l10n.author,
                                      cubit: authorsCubit,
                                      initiallySelected: selectedAuthorsList,
                                      onConfirm: (selected) {
                                        setModalState(() {
                                          selectedAuthorsList = selected;
                                          cubit.setAuthors(selected.map((a) => a.idAsInt).whereType<int>().toList());
                                        });
                                      },
                                      getPeopleFromState: (state) => state.maybeWhen(success: (authors) => authors, orElse: () => []),
                                      isLoading: (state) => state.maybeWhen(loading: () => true, orElse: () => false),
                                      getError: (state) => state.maybeWhen(error: (msg) => msg, orElse: () => null),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          navigationItem(
                            context,
                            title: selectedTranslatorsList.isNotEmpty
                                ? l10n.translatorWithValue(selectedTranslatorsList.map((a) => a.name ?? '').join(', '))
                                : l10n.translator,
                            hasDivider: true,
                            onTap: () async {
                              final translatorsCubit = TranslatorsCubit()..fetchTranslators();
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return BlocProvider.value(
                                    value: translatorsCubit,
                                    child: PeopleMultiSelectSheet<TranslatorsCubit, TranslatorsState>(
                                      title: l10n.translator,
                                      cubit: translatorsCubit,
                                      initiallySelected: selectedTranslatorsList,
                                      onConfirm: (selected) {
                                        setModalState(() {
                                          selectedTranslatorsList = selected;
                                          cubit.setTranslators(selected.map((a) => a.idAsInt).whereType<int>().toList());
                                        });
                                      },
                                      getPeopleFromState: (state) => state.maybeWhen(success: (translators) => translators, orElse: () => []),
                                      isLoading: (state) => state.maybeWhen(loading: () => true, orElse: () => false),
                                      getError: (state) => state.maybeWhen(error: (msg) => msg, orElse: () => null),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          navigationItem(
                            context,
                            title: selectedSpeakersList.isNotEmpty
                                ? l10n.narratorWithValue(selectedSpeakersList.map((a) => a.name ?? '').join(', '))
                                : l10n.speaker,
                            hasDivider: true,
                            onTap: () async {
                              final speakersCubit = SpeakersCubit()..fetchSpeakers();
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return BlocProvider.value(
                                    value: speakersCubit,
                                    child: PeopleMultiSelectSheet<SpeakersCubit, SpeakersState>(
                                      title: l10n.speaker,
                                      cubit: speakersCubit,
                                      initiallySelected: selectedSpeakersList,
                                      onConfirm: (selected) {
                                        setModalState(() {
                                          selectedSpeakersList = selected;
                                          cubit.setSpeakers(selected.map((a) => a.idAsInt).whereType<int>().toList());
                                        });
                                      },
                                      getPeopleFromState: (state) => state.maybeWhen(success: (speakers) => speakers, orElse: () => []),
                                      isLoading: (state) => state.maybeWhen(loading: () => true, orElse: () => false),
                                      getError: (state) => state.maybeWhen(error: (msg) => msg, orElse: () => null),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          navigationItem(
                            context,
                            title: selectedPublishersList.isNotEmpty
                                ? l10n.publisherWithValue(selectedPublishersList.map((a) => a.name ?? '').join(', '))
                                : l10n.publisher,
                            hasDivider: true,
                            onTap: () async {
                              final publishersCubit = PublishersCubit()..fetchPublishers();
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return BlocProvider.value(
                                    value: publishersCubit,
                                    child: PeopleMultiSelectSheet<PublishersCubit, PublishersState>(
                                      title: l10n.publisher,
                                      cubit: publishersCubit,
                                      initiallySelected: selectedPublishersList,
                                      onConfirm: (selected) {
                                        setModalState(() {
                                          selectedPublishersList = selected;
                                          cubit.setPublishers(selected.map((a) => a.idAsInt).whereType<int>().toList());
                                        });
                                      },
                                      getPeopleFromState: (state) => state.maybeWhen(success: (publishers) => publishers, orElse: () => []),
                                      isLoading: (state) => state.maybeWhen(loading: () => true, orElse: () => false),
                                      getError: (state) => state.maybeWhen(error: (msg) => msg, orElse: () => null),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.s16),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.colorScheme.surface,
                              foregroundColor: context.colorScheme.onSurface,
                            ),
                            child: Text(l10n.cancel),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.s16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(l10n.applyFilter),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

final List<Map<String, dynamic>> books = [
  {
    'title': 'اثر مرکب',
    'author': 'دارن هاردی',
    'rating': 4.8,
    'reviewCount': 120,
    'oldPrice': '۲۰۰,۰۰۰',
    'discount': '۳۰%',
    'newPrice': '۱۴۰,۰۰۰',
    'showDiscount': true,
  },
  {
    'title': 'خرده عادت‌ها',
    'author': 'جیمز کلیر',
    'rating': 4.5,
    'reviewCount': 300,
    'oldPrice': '۱۸۰,۰۰۰',
    'discount': '۴۰%',
    'newPrice': '۱۰۸,۰۰۰',
    'showDiscount': false,
  },
  {
    'title': 'باشگاه ۵ صبحی‌ها',
    'author': 'رابین شارما',
    'rating': 4.7,
    'reviewCount': 180,
    'oldPrice': '۲۵۰,۰۰۰',
    'discount': '۲۰%',
    'newPrice': '۲۰۰,۰۰۰',
    'showDiscount': true,
  },
  {
    'title': 'هنر ظریف بی‌خیالی',
    'author': 'مارک منسن',
    'rating': 4.6,
    'reviewCount': 220,
    'oldPrice': '۱۵۰,۰۰۰',
    'discount': '۵۰%',
    'newPrice': '۷۵,۰۰۰',
    'showDiscount': false,
  },
];

Widget filterItem(
  BuildContext context, {
  required String title,
  required bool isActive,
  required VoidCallback onTap,
}) {
  return Container(
    height: context.fullHeight * 0.09,
    padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: context.colorScheme.shadow, width: 1),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400)),
        GestureDetector(
          onTap: onTap,
          child: customSwitch(context, isActive: isActive, onChanged: (_) => onTap()),
        ),
      ],
    ),
  );
}

Widget customSwitch(BuildContext context, {required bool isActive, required Function(bool) onChanged}) {
  return GestureDetector(
    onTap: () => onChanged(!isActive),
    child: AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 50,
      height: 28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.corner20),
        border: Border.all(color: context.colorScheme.secondary, width: 1),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            left: isActive ? 24 : 2,
            right: isActive ? 2 : 24,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? context.colorScheme.primary : context.colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget navigationItem(BuildContext context, {required String title, required bool hasDivider, VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: context.fullHeight * 0.09,
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16),
      decoration: BoxDecoration(
        border: hasDivider
            ? Border(bottom: BorderSide(color: context.colorScheme.shadow, width: 1))
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400)),
          const Icon(Icons.keyboard_arrow_left),
        ],
      ),
    ),
  );
}
