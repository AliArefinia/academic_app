import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academic/data/api/people/model/person_model.dart';

class PeopleMultiSelectSheet<T extends Cubit<S>, S> extends StatefulWidget {
  final String title;
  final T cubit;
  final List<PersonModel> initiallySelected;
  final void Function(List<PersonModel>) onConfirm;
  final List<PersonModel> Function(S state) getPeopleFromState;
  final bool Function(S state) isLoading;
  final String? Function(S state) getError;

  const PeopleMultiSelectSheet({
    Key? key,
    required this.title,
    required this.cubit,
    required this.initiallySelected,
    required this.onConfirm,
    required this.getPeopleFromState,
    required this.isLoading,
    required this.getError,
  }) : super(key: key);

  @override
  State<PeopleMultiSelectSheet<T, S>> createState() => _PeopleMultiSelectSheetState<T, S>();
}

class _PeopleMultiSelectSheetState<T extends Cubit<S>, S> extends State<PeopleMultiSelectSheet<T, S>> {
  final TextEditingController _searchController = TextEditingController();
  late List<PersonModel> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List.of(widget.initiallySelected);
    // فرض بر این است که cubit یک متد fetch دارد
    // ignore: invalid_use_of_protected_member
    // ignore: invalid_use_of_visible_for_testing_member
    // باید دستی فراخوانی شود
    // (widget.cubit as dynamic).fetch();
  }

  void _onSearchChanged(String value) {
    // فراخوانی متد صحیح بر اساس نوع cubit
    if (widget.cubit.runtimeType.toString().contains('AuthorsCubit')) {
      (widget.cubit as dynamic).fetchAuthors(query: value);
    } else if (widget.cubit.runtimeType.toString().contains('SpeakersCubit')) {
      (widget.cubit as dynamic).fetchSpeakers(query: value);
    } else if (widget.cubit.runtimeType.toString().contains('PublishersCubit')) {
      (widget.cubit as dynamic).fetchPublishers(query: value);
    } else if (widget.cubit.runtimeType.toString().contains('TranslatorsCubit')) {
      (widget.cubit as dynamic).fetchTranslators(query: value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
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
                  Text(widget.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: l10n.searchInWithValue(widget.title.toString()),
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: BlocBuilder<T, S>(
                  bloc: widget.cubit,
                  builder: (context, state) {
                    if (widget.isLoading(state)) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final error = widget.getError(state);
                    if (error != null) {
                      return Center(child: Text(error));
                    }
                    final people = widget.getPeopleFromState(state);
                    if (people.isEmpty) {
                      return Center(child: Text(l10n.noneFoundWithValue(widget.title.toString())));
                    }
                    return ListView.builder(
                      itemCount: people.length,
                      itemBuilder: (context, index) {
                        final person = people[index];
                        final isSelected = _selected.any((a) => a.id == person.id);
                        return CheckboxListTile(
                          value: isSelected,
                          onChanged: (checked) {
                            setState(() {
                              if (checked == true) {
                                _selected.add(person);
                              } else {
                                _selected.removeWhere((a) => a.id == person.id);
                              }
                            });
                          },
                          title: Text(person.name),
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
                      child: Text(l10n.confirm),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 