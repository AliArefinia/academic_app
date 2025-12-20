import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/data/api/people/model/person_model.dart';
import '../logic/authors_cubit.dart';

class AuthorMultiSelectSheet extends StatefulWidget {
  final List<PersonModel> initiallySelected;
  final void Function(List<PersonModel>) onConfirm;

  const AuthorMultiSelectSheet({
    Key? key,
    required this.initiallySelected,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<AuthorMultiSelectSheet> createState() => _AuthorMultiSelectSheetState();
}

class _AuthorMultiSelectSheetState extends State<AuthorMultiSelectSheet> {
  final TextEditingController _searchController = TextEditingController();
  late List<PersonModel> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List.of(widget.initiallySelected);
    context.read<AuthorsCubit>().fetchAuthors();
  }

  void _onSearchChanged(String value) {
    context.read<AuthorsCubit>().fetchAuthors(query: value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 8),
                const Text('انتخاب نویسنده', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: const InputDecoration(
                hintText: 'جستجو در نویسنده‌ها...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<AuthorsCubit, AuthorsState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const Center(child: CircularProgressIndicator()),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (msg) => Center(child: Text(msg)),
                    success: (authors) {
                      if (authors.isEmpty) {
                        return const Center(child: Text('نویسنده‌ای یافت نشد.'));
                      }
                      return ListView.builder(
                        itemCount: authors.length,
                        itemBuilder: (context, index) {
                          final author = authors[index];
                          final isSelected = _selected.any((a) => a.id == author.id);
                          return CheckboxListTile(
                            value: isSelected,
                            onChanged: (checked) {
                              setState(() {
                                if (checked == true) {
                                  _selected.add(author);
                                } else {
                                  _selected.removeWhere((a) => a.id == author.id);
                                }
                              });
                            },
                            title: Text(author.name),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onConfirm(_selected);
                      Navigator.of(context).pop();
                    },
                    child: const Text('تایید'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 