import 'dart:io';

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('Usage: create <page_name> <type>');
    return;
  }

  final pageName = arguments[0];

  final folderName = _toSnakeCase(pageName);
  final className = _toPascalCase(pageName);
  final basePath = 'lib/pages/$folderName';

  // Create folder structure
  Directory(basePath).createSync(recursive: true);
  Directory('$basePath/logic').createSync(recursive: true);

  // Create UI file
  final pageFile = File('$basePath/${folderName}_page.dart');
  pageFile.writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/${folderName}_cubit.dart';

class ${className}Page extends StatelessWidget {
  const ${className}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<${className}Cubit, ${className}State>(
      builder: (context, state) {
        return Placeholder();
      },
    );
  }
}
''');

  // Create Cubit file
  final cubitFile = File('$basePath/logic/${folderName}_cubit.dart');
  cubitFile.writeAsStringSync('''
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '${folderName}_state.dart';
part '${folderName}_event.dart'; // Add event part
part '${folderName}_cubit.freezed.dart'; // Add freezed part

class ${className}Cubit extends Cubit<${className}State> {
  ${className}Cubit() : super(const ${className}State.initial());
}
''');

  // Create State file
  final stateFile = File('$basePath/logic/${folderName}_state.dart');
  stateFile.writeAsStringSync('''
part of '${folderName}_cubit.dart';

@freezed
class ${className}State with _\$${className}State {
  const factory ${className}State.initial() = _Initial;
}
''');

  // Create Event file
  final eventFile = File('$basePath/logic/${folderName}_event.dart');
  eventFile.writeAsStringSync('''
part of '${folderName}_cubit.dart';

@freezed
class ${className}Event with _\$${className}Event {
  const factory ${className}Event.changeLanguage({
    required String selectedLanguage,
  }) = ChangeLanguage;
}
''');

  // Create GoRouter file
  final routerFile = File('lib/core/router/pages/${folderName}.p.dart');
  routerFile.writeAsStringSync('''
part of '../router.dart';

@TypedGoRoute<${className}Route>(
  path: PathRoute.${_toCamelCase(folderName)}Route,
)
class ${className}Route extends GoRouteData {
  const ${className}Route();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ${className}Page();
  }
}
''');

  // Update router.dart
  final routerPath = 'lib/core/router/router.dart';
  final routerContent = File(routerPath).readAsStringSync();

  if (!routerContent.contains("part 'pages/${folderName}.p.dart';")) {
    final updatedRouter = routerContent.replaceFirst(
      "part 'router.g.dart';\n",
      "part 'router.g.dart';\npart 'pages/${folderName}.p.dart';\n",
    );

    File(routerPath).writeAsStringSync(updatedRouter);
  }

  if (!routerContent.contains("static const String ${_toCamelCase(folderName)}Route")) {
    final updatedRouter = File(routerPath).readAsStringSync().replaceFirst(
      'class PathRoute {',
      '''class PathRoute {
  static const String ${_toCamelCase(folderName)}Route = '/${_toCamelCase(folderName)}';''',
    );

    File(routerPath).writeAsStringSync(updatedRouter);
  }

  if (!routerContent.contains("import '../../pages/$folderName/${folderName}_page.dart';")) {
    final updatedRouter = File(routerPath).readAsStringSync().replaceFirst(
      RegExp(r'(import .*;\n)(?=part )'), // وارد کردن ایمپورت جدید قبل از قسمت part ها
      "import '../../pages/$folderName/${folderName}_page.dart';\n",
    );

    File(routerPath).writeAsStringSync(updatedRouter);
  }


  print('Page $pageName created successfully!');

  // Run build_runner command
  await _runBuildRunner();
}

Future<void> _runBuildRunner() async {
  print('Running build_runner...');
  final result = await Process.run(
    'flutter',
    ['pub', 'run', 'build_runner', 'build', '--delete-conflicting-outputs'],
    workingDirectory: Directory.current.path,
  );

  if (result.exitCode == 0) {
    print('build_runner executed successfully!');
  } else {
    print('build_runner failed: ${result.stderr}');
  }
}

String _toSnakeCase(String input) {
  return input.replaceAllMapped(
    RegExp(r'[A-Z]'),
        (match) => '_${match.group(0)!.toLowerCase()}',
  ).replaceFirst('_', '');
}

String _toPascalCase(String input) {
  return input.split('_').map((word) {
    final lowercasedWord = word.toLowerCase();
    return lowercasedWord[0].toUpperCase() + lowercasedWord.substring(1);
  }).join('');
}

String _toCamelCase(String input) {
  final words = input.split('_');
  return words.first + words.skip(1).map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase()).join();
}
