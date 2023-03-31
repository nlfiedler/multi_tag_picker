import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:multi_tag_picker/multi_tag_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MultiPicker Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedValuesJson = 'are yet to be found...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MultiPicker Demo'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlutterTagging<Language>(
              textFieldConfiguration: const TextFieldConfiguration(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  hintText: 'Enter a query',
                  labelText: 'Select Tags',
                ),
              ),
              findSuggestions: getLanguages,
              additionCallback: (value) {
                return Language(
                  name: value,
                  position: 0,
                );
              },
              configureSuggestion: (lang) {
                return SuggestionConfiguration(
                  title: Text(lang.name),
                  subtitle: Text(lang.position.toString()),
                  additionWidget: const Chip(
                    avatar: Icon(
                      Icons.add_circle,
                    ),
                    label: Text('Add New Tag'),
                  ),
                );
              },
              placeholderItem: const Language(
                name: 'dummy',
                position: 0,
              ),
              configureChip: (lang) {
                return ChipConfiguration(
                  label: Text(lang.name),
                );
              },
              onChanged: (values) {
                setState(() {
                  if (values.isEmpty) {
                    _selectedValuesJson = 'have left us...';
                  } else {
                    _selectedValuesJson = values
                        .map<String>((lang) => '\n${lang.toJson()}')
                        .toList()
                        .toString()
                        .replaceFirst('}]', '}\n]');
                  }
                });
              },
            ),
          ),
          const Text(
            'The Chosen',
            style: TextStyle(fontSize: 18.0),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                ),
                child: SyntaxView(
                  code: _selectedValuesJson,
                  syntax: Syntax.JAVASCRIPT,
                  fontSize: 16.0,
                  expanded: true,
                  withLinesCount: false,
                  syntaxTheme: SyntaxTheme.standard(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Mocks fetching language from network API with delay of 500ms.
Future<List<Language>> getLanguages(String query) async {
  if (query.isEmpty) {
    return const [];
  }
  await Future.delayed(const Duration(milliseconds: 500), null);
  final lowercaseQuery = query.toLowerCase();
  return const <Language>[
    Language(name: 'Rust', position: 1),
    Language(name: 'Dart', position: 2),
    Language(name: 'Scheme', position: 3),
    Language(name: 'Swift', position: 4),
    Language(name: 'Erlang', position: 5),
    Language(name: 'Go', position: 6),
    Language(name: 'F#', position: 7),
    Language(name: 'Java', position: 8),
    Language(name: 'C#', position: 9),
    Language(name: 'JavaScript', position: 10),
    Language(name: 'APL', position: 11),
    Language(name: 'Python', position: 12),
    Language(name: 'Haxe', position: 13),
    Language(name: 'Io', position: 14),
    Language(name: 'Lua', position: 15),
    Language(name: 'OCaml', position: 16),
    Language(name: 'C++', position: 17),
    Language(name: 'Prolog', position: 18),
    Language(name: 'TypeScript', position: 19),
    Language(name: 'Zig', position: 20),
  ]
      .where((lang) => lang.name.toLowerCase().contains(lowercaseQuery))
      .toList(growable: false)
    ..sort((a, b) => a.name
        .toLowerCase()
        .indexOf(lowercaseQuery)
        .compareTo(b.name.toLowerCase().indexOf(lowercaseQuery)));
}

/// Language represents a programming language.
///
/// Note that this class overrides the `==` operator and `hashCode` method in
/// order to provide sensible equality with other values of the same type.
class Language {
  final String name;
  final int position;

  const Language({
    required this.name,
    required this.position,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Language &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name;
  }

  String toJson() => '''  {
    "name": $name,\n
    "position": $position\n
  }''';
}
