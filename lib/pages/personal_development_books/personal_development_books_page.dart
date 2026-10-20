import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:academic/core/helper/app_helper.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/data/model/book_model.dart';
import 'package:academic/widgets/book_discount_card.dart';
import 'package:academic/widgets/other_booksBy_author_widget.dart';
import 'package:academic/widgets/search_input_field.dart';
import '../../gen/assets.gen.dart';
import 'logic/personal_development_books_cubit.dart';

class CategoryProductsPage extends StatefulWidget {
  final int categoryId;
  final String categoryTitle;
  const CategoryProductsPage({super.key, required this.categoryId, required this.categoryTitle});

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonaldevelopmentbooksCubit,
        PersonaldevelopmentbooksState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => MyAppHelper().hideKeyboard(context),
          child: Scaffold(
            appBar: AppBar(
              title: Text(l10n.personalDevelopmentBooks),
              leading: IconButton(
                onPressed: () {

                },
                // onPressed: () => const ProductRoute(bookModel: Bookm).push(context),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
              child: Column(
                children: [
                  SearchInputField(
                    controller: TextEditingController(),
                    Text: l10n.searchInApp,
                  ),
                  const SizedBox(height: AppSpacing.s20),
                  Container(
                    height: context.fullHeight * 0.07,
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      borderRadius: BorderRadius.circular(AppRadius.corner12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s24),
                      child: GestureDetector(
                        onTap: () => showFiltersDialog(context),

                        child: Row(
                          children: [
                            SvgPicture.asset(Assets.icFilter),
                            const SizedBox(width: AppSpacing.s8),
                            Row(
                              children: [
                                Text(l10n.filterLabel,
                                    style: context.textTheme.titleMedium
                                        ?.copyWith(fontSize: 15)),
                                const SizedBox(width: AppSpacing.s32),
                                SvgPicture.asset(Assets.icBest),
                              ],
                            ),
                            const SizedBox(width: AppSpacing.s8),
                            Text(l10n.bestSelling,
                                style: context.textTheme.titleMedium
                                    ?.copyWith(fontSize: 15)),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<PersonaldevelopmentbooksCubit>()
                                    .toggleViewMode(false);
                              },
                              child: SvgPicture.asset(
                                state.isGridView
                                    ? Assets.icVertical
                                    : Assets.icVerticalFull,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.s16),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<PersonaldevelopmentbooksCubit>()
                                    .toggleViewMode(true);
                              },
                              child: SvgPicture.asset(
                                state.isGridView
                                    ? Assets.icHorizontal
                                    : Assets.icHorizontalVacant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: state.isGridView
                  //       ? GridView.builder(
                  //           physics: const BouncingScrollPhysics(),
                  //           itemCount: fakeBookModelList.length,
                  //           gridDelegate:
                  //               const SliverGridDelegateWithFixedCrossAxisCount(
                  //             crossAxisCount: 2,
                  //             crossAxisSpacing: 8.0,
                  //             childAspectRatio: 0.59,
                  //           ),
                  //           itemBuilder: (context, index) {
                  //             return OtherBooksByAuthorWidget(
                  //               bookModel: fakeBookModelList[index],
                  //             );
                  //           },
                  //         )
                  //       : ListView.builder(
                  //           physics: const BouncingScrollPhysics(),
                  //           itemCount: books.length,
                  //           itemBuilder: (context, index) {
                  //             final book = books[index];
                  //             return BookDiscountCard(
                  //               title: book['title'],
                  //               author: book['author'],
                  //               rating: book['rating'],
                  //               reviewCount: book['reviewCount'],
                  //               oldPrice: book['oldPrice'],
                  //               discount: book['discount'],
                  //               newPrice: book['newPrice'],
                  //               showDiscount: book['showDiscount'],
                  //             );
                  //           },
                  //         ),
                  // ),
                ],
              ),
            ),
          ),
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

void showFiltersDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(AppRadius.corner20)),
    ),
    builder: (context) {
      return BlocProvider(
        create: (context) => PersonaldevelopmentbooksCubit(),
        child: BlocBuilder<PersonaldevelopmentbooksCubit,
            PersonaldevelopmentbooksState>(
          builder: (context, state) {
            return Container(
              height: context.fullHeight * 0.47,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: AppSpacing.s20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.s20),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          l10n.filters,
                          style: context.textTheme.headlineMedium,
                        )),
                  ),
                  SizedBox(
                    height: AppSpacing.s20,
                  ),
                  Divider(color: context.colorScheme.primary, thickness: 2),
                  filterItem(
                    context,
                    title: l10n.textBooks,
                    isActive: state.isTextBooksActive,
                    onTap: () => context
                        .read<PersonaldevelopmentbooksCubit>()
                        .toggleTextBooks(),
                  ),
                  filterItem(
                    context,
                    title: l10n.audioBooks,
                    isActive: state.isAudioBooksActive,
                    onTap: () => context
                        .read<PersonaldevelopmentbooksCubit>()
                        .toggleAudioBooks(),
                  ),
                  const SizedBox(height: 16),
                  navigationItem(
                    context,
                    title: l10n.authorTranslatorNarrator,
                    hasDivider: true,
                    onTap: () {
                      const AuthorbookRoute().push(context);
                    },
                  ),
                  navigationItem(
                    context,
                    title: l10n.publisher,
                    hasDivider: false,
                    onTap: () {
                      const BookpublisherRoute().push(context);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

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
          bottom: BorderSide(color: context.colorScheme.shadow, width: 1)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: context.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.w400)),
        GestureDetector(
          onTap: onTap,
          child: customSwitch(context,
              isActive: isActive, onChanged: (_) => onTap()),
        ),
      ],
    ),
  );
}

Widget customSwitch(BuildContext context,
    {required bool isActive, required Function(bool) onChanged}) {
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
                color: isActive
                    ? context.colorScheme.primary
                    : context.colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget navigationItem(BuildContext context,
    {required String title, required bool hasDivider, VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: context.fullHeight * 0.09,
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16),
      decoration: BoxDecoration(
        border: hasDivider
            ? Border(
                bottom: BorderSide(color: context.colorScheme.shadow, width: 1))
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: context.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w400)),
          const Icon(Icons.keyboard_arrow_left),
        ],
      ),
    ),
  );
}
