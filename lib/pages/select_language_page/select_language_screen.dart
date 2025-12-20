import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:academic/core/router/router.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/l10n/app_localizations.dart';

import '../../data/model/language_model.dart';

import 'bloc/language_bloc.dart';

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageBloc = context.read<LanguageBloc>();
    final selectedLanguage =
        context.watch<LanguageBloc>().state.selectedLanguage;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.s24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)?.exampleText ?? '',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.redAccent),
            ),
            const SizedBox(height: AppSpacing.s32),
            Center(
              child: DropdownButton<Language>(
                value: selectedLanguage,
                icon: const Icon(Icons.arrow_drop_down),
                onChanged: (Language? newLanguage) {
                  if (newLanguage != null) {
                    languageBloc
                        .add(ChangeLanguage(selectedLanguage: newLanguage));
                  }
                },
                items: Language.values.map((Language lang) {
                  return DropdownMenuItem<Language>(
                    value: lang,
                    child: Text(
                      lang.text,
                      style: const TextStyle(fontSize: AppSpacing.s16),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: AppSpacing.s24),
            Text(
              'اینجا با هر کلیک، سفری تازه آغاز می‌شود.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {

              },
              child: const Text('ورود به برنامه'),
            ),
          ],
        ),
      ),
    );
  }
}
