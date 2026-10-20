import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/helper/app_helper.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/core/theme/theme.dart';
import 'package:academic/widgets/main_button.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import '../../generated/assets.dart';
import '../../data/api/my_book_cases/model/my_book_case_model.dart';
import 'logic/my_shelves_cubit.dart';

class MyshelvesPage extends StatelessWidget {
  const MyshelvesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyshelvesCubit, MyshelvesState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => MyAppHelper().hideKeyboard(context),
          child: Scaffold(
            appBar: CustomAppBar(
              title: l10n.myShelvesTitle,
              icon: Icons.bookmarks_rounded,
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.s16),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
                    child: Text(l10n.myShelvesTitle,
                        style: context.textTheme.titleLarge),
                  ),
                  const SizedBox(height: AppSpacing.s20),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
                    child: GestureDetector(
                      onTap: () => _showAddShelfDialog(context),
                      child: Container(
                        width: double.infinity,
                        height: context.fullHeight * 0.09,
                        padding: const EdgeInsets.all(AppSpacing.s12),
                        decoration: BoxDecoration(
                          color: context.colorScheme.surface,
                          borderRadius:
                              BorderRadius.circular(AppRadius.corner16),
                          boxShadow: [
                            BoxShadow(
                              color: context.colorScheme.shadow,
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: AppSpacing.s10),
                                SvgPicture.asset(Assets.assetsIcPlus),
                                const SizedBox(width: AppSpacing.s10),
                                Text(
                                  l10n.createNewShelf,
                                  style: context.textTheme.labelLarge
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Icon(Icons.keyboard_arrow_left,
                                color: context.colorScheme.secondary),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s16),
                  Expanded(
                    child: state.when(
                      initial: () => const SizedBox.shrink(),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (msg) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline,
                                size: 64, color: Colors.red[300]),
                            const SizedBox(height: 16),
                            Text(
                              l10n.errorLoadingShelves,
                              style: context.textTheme.titleMedium?.copyWith(
                                color: Colors.red[700],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              msg,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.secondaryText,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                context.read<MyshelvesCubit>().fetchShelves();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: context.colorScheme.primary,
                                foregroundColor: context.colorScheme.onPrimary,
                              ),
                              child: Text(l10n.retry),
                            ),
                          ],
                        ),
                      ),
                      success: (shelves) => shelves.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.book_outlined,
                                    size: 64,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    l10n.noShelvesCreatedYet,
                                    style: context.textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: AppSpacing.s8),
                                  Text(
                                    l10n.createShelfFirstToAddBooks,
                                    style:
                                        context.textTheme.bodyMedium?.copyWith(
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppSpacing.s20,
                                    ),
                                    child: ElevatedButton.icon(
                                      onPressed: () =>
                                          _showAddShelfDialog(context),
                                      icon: const Icon(Icons.add),
                                      label: Text(l10n.createNewShelf),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: context.colorScheme.primary,
                                        foregroundColor: context.colorScheme.onPrimary,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppSpacing.s24,
                                          vertical: AppSpacing.s12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () async {
                                context.read<MyshelvesCubit>().fetchShelves();
                              },
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.s20),
                                itemCount: shelves.length,
                                itemBuilder: (context, index) {
                                  return CustomBookWidget(
                                    bookCase: shelves[index],
                                  );
                                },
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
    );
  }
}

void _showAddShelfDialog(BuildContext parentContext) {
  TextEditingController shelfController = TextEditingController();

  showModalBottomSheet(
    context: parentContext,
    shape: const RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(AppRadius.corner32)),
    ),
    backgroundColor: parentContext.colorScheme.surface,
    isScrollControlled: true,
    builder: (context) {
      return BlocProvider.value(
        value: parentContext.read<MyshelvesCubit>(),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: AppSpacing.s16,
            right: AppSpacing.s16,
            top: AppSpacing.s20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(l10n.createShelf,
                    style: parentContext.textTheme.headlineMedium),
              ),
              const SizedBox(height: AppSpacing.s20),
              Divider(thickness: 0.8, color: AppTheme.outlineColor),
              const SizedBox(height: AppSpacing.s24),
              TextField(
                controller: shelfController,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: l10n.writeShelfName,
                  labelStyle: parentContext.textTheme.bodyLarge,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.corner8),
                    borderSide: const BorderSide(color: AppTheme.shadow),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.corner8),
                    borderSide: const BorderSide(color: AppTheme.shadow),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.corner8),
                    borderSide: BorderSide(
                      color: parentContext.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.s24),
              MainButton(
                text: l10n.submit,
                backgroundColor: parentContext.colorScheme.primary,
                textColor: parentContext.colorScheme.onPrimary,
                onPressed: () {
                  if (shelfController.text.isNotEmpty) {
                    parentContext
                        .read<MyshelvesCubit>()
                        .createBookCase(shelfController.text);
                    Navigator.pop(context);
                  }
                },
              ),
              const SizedBox(height: AppSpacing.s16),
            ],
          ),
        ),
      );
    },
  );
}

void _showDeleteConfirmation(BuildContext context, BookCase bookCase) {
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.corner16),
      ),
      title: Text(
        l10n.deleteShelf,
        textAlign: TextAlign.right,
      ),
      content: Text(
        l10n.confirmDeleteShelf(bookCase.name.toString()),
        textAlign: TextAlign.right,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () {
            context.read<MyshelvesCubit>().deleteBookCase(bookCase.id);
            Navigator.pop(dialogContext);
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
          ),
          child: Text(l10n.delete),
        ),
      ],
    ),
  );
}

class CustomBookWidget extends StatelessWidget {
  final BookCase bookCase;

  const CustomBookWidget({
    super.key,
    required this.bookCase,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BookCaseDetailRoute(id: bookCase.id, name: bookCase.name).push(context);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.s12),
        padding: const EdgeInsets.all(AppSpacing.s20),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.corner20),
          border: Border.all(
            color: context.colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.shadow.withOpacity(0.15),
              blurRadius: 16,
              offset: const Offset(0, 6),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: context.colorScheme.shadow.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with name and book count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    bookCase.name,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: context.colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s10,
                        vertical: AppSpacing.s6,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(AppRadius.corner16),
                      ),
                      child: Text(
                        "${bookCase.booksCount}",
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.s8),
                    GestureDetector(
                      onTap: () => _showDeleteConfirmation(context, bookCase),
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.s6),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppRadius.corner8),
                        ),
                        child: Icon(
                          Icons.delete_outline,
                          size: 20,
                          color: Colors.red[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.s16),

            // Books preview - simplified
            if (bookCase.books.isNotEmpty) ...[
              Text(
                l10n.latestBooks,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurface.withOpacity(0.6),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSpacing.s8),
              // Show up to 2 books as preview with cleaner design
              ...bookCase.books.take(2).map((book) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.s8),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.s12),
                        Expanded(
                          child: Text(
                            book.name ?? '',
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontSize: 13,
                              color: context.colorScheme.onSurface.withOpacity(0.8),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )),

              if (bookCase.books.length > 2)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.s4),
                  child: Text(
                    l10n.moreBooksCount(bookCase.books.length - 2),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.primary,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ] else ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.s12,
                  horizontal: AppSpacing.s16,
                ),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.corner12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.book_outlined,
                      size: 16,
                      color: context.colorScheme.onSurface.withOpacity(0.4),
                    ),
                    const SizedBox(width: AppSpacing.s8),
                    Text(
                      l10n.shelfEmpty,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurface.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
