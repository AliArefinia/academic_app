import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/widgets/custom_list_view.dart';
import 'package:academic/widgets/custom_app_bar.dart';
import 'logic/text_books_cubit.dart';

class TextbooksPage extends StatelessWidget {
  const TextbooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextbooksCubit, TextbooksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: l10n.textBooksTitle,
            icon: Icons.menu_book_rounded,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: Column(
            children: [
              CustomListView(
                items: mainCategories,
                ixExpanded: true,
              ),
            ],
          ),
        );
      },
    );
  }
}

final List<Map<String, dynamic>> mainCategories = [
  {
    "title": "مدیریت و بازاریابی",
    "action": (BuildContext context) => {},
  },
  {
    "title": "مدیریت و بازاریابی",
    "action": (BuildContext context) => {},
  },
  {
    "title": "مدیریت و بازاریابی",
    "action": (BuildContext context) => {},

    // "action": (BuildContext context) =>
    //     const TextbooksRoute().pushReplacement(context),
  },
  {
    "title": "مدیریت و بازاریابی",
    "action": (BuildContext context) => {},
  },
  {
    "title": "مدیریت و بازاریابی",
    "action": (BuildContext context) => {},
  },
  {
    "title": "مدیریت و بازاریابی",
    "action": (BuildContext context) => {},
  },
  {
    "title": "مدیریت و بازاریابی",
    "action": (BuildContext context) => {},
  },
  {
    "title": "مدیریت و بازاریابی",
    "action": (BuildContext context) => {},
  },
  {
    "title": "مدیریت و بازاریابی",
    "action": (BuildContext context) => {},
  },
  {
    "title": "مدیریت و بازاریابی",
    "action": (BuildContext context) => {},
  },
  {
    "title": "مدیریت و بازاریابی",
    "action": (BuildContext context) => {},
  },
  {
    "title": "مدیریت و بازاریابی",
    "action": (BuildContext context) => {},
  },
  {
    "title": "مدیریت و بازاریابی",
    "action": (BuildContext context) => {},
  },
  {
    "title": "مدیریت و بازاریابی",
    "action": (BuildContext context) => {},
  },
  {
    "title": "مدیریت و بازاریابی",
    "action": (BuildContext context) => {},
  },
  {
    "title": "مدیریت و بازاریابی",
    "action": (BuildContext context) => {},
  },
  {
    "title": "مدیریت و بازاریابی",
    "action": (BuildContext context) => {},
  },
];
