import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/data/api/my_book_cases/model/my_book_case_model.dart';
import 'package:academic/pages/product/logic/add_to_shelf_cubit.dart';
import 'package:academic/data/repo/book_case_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class AddToShelfBottomSheet extends StatelessWidget {
  final int bookId;

  const AddToShelfBottomSheet({
    super.key,
    required this.bookId,
  });

  @override
  Widget build(BuildContext context) {
    return Provider<BookCaseRepository>(
      create: (_) => GetIt.I<BookCaseRepository>(),
      child: BlocProvider(
        create: (context) => AddToShelfCubit(context.read()),
        child: BlocConsumer<AddToShelfCubit, AddToShelfState>(
          listener: (context, state) {
            state.maybeWhen(
              bookAdded: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.bookAddedToShelf),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(AppSpacing.s20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppRadius.corner20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.addToShelf,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s16),
                  state.when(
                    initial: () => const SizedBox(),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (message) => Center(
                      child: Text(
                        message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    bookAdded: () => const SizedBox(),
                    success: (shelves) => Column(
                      children: [
                        ...shelves.map((shelf) => _ShelfItem(
                              shelf: shelf,
                              onTap: () {
                                context
                                    .read<AddToShelfCubit>()
                                    .addBookToShelf(bookId, shelf.id);
                              },
                            )),
                        const SizedBox(height: AppSpacing.s16),
                        _CreateNewShelfButton(
                          onCreate: (name) {
                            context.read<AddToShelfCubit>().createNewShelf(name);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ShelfItem extends StatelessWidget {
  final BookCase shelf;
  final VoidCallback onTap;

  const _ShelfItem({
    required this.shelf,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.s12,
          horizontal: AppSpacing.s16,
        ),
        margin: const EdgeInsets.only(bottom: AppSpacing.s8),
        decoration: BoxDecoration(
          border: Border.all(color: context.subtleBorder),
          borderRadius: BorderRadius.circular(AppRadius.corner12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              shelf.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              l10n.booksCount(shelf.booksCount.toString()),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateNewShelfButton extends StatelessWidget {
  final Function(String) onCreate;

  const _CreateNewShelfButton({
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => _CreateShelfDialog(
            onCreate: onCreate,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.s12,
          horizontal: AppSpacing.s16,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(AppRadius.corner12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: AppSpacing.s8),
            Text(
              l10n.createNewShelfTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateShelfDialog extends StatefulWidget {
  final Function(String) onCreate;

  const _CreateShelfDialog({
    required this.onCreate,
  });

  @override
  State<_CreateShelfDialog> createState() => _CreateShelfDialogState();
}

class _CreateShelfDialogState extends State<_CreateShelfDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(l10n.createNewShelfTitle),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: l10n.enterShelfName,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              widget.onCreate(_controller.text);
              Navigator.pop(context);
            }
          },
          child: Text(l10n.create),
        ),
      ],
    );
  }
} 