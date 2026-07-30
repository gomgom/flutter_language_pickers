import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:language_pickers/language_pickers.dart';

/// The language the dropdown is actually showing as selected.
///
/// [find.text] is not enough: a [DropdownButton] keeps every item in the tree,
/// so the text of an unselected language is found too.
Language _selectionOf(WidgetTester tester) => tester
    .widget<DropdownButton<Language>>(
      find.byType(DropdownButton<Language>),
    )
    .value!;

void main() {
  test('getLanguageByIsoCode returns the right language', () {
    // ignore: deprecated_member_use_from_same_package
    final language = LanguagePickerUtils.getLanguageByIsoCode('ko');
    expect(language.name, 'Korean');
    expect(language.isoCode, 'ko');
  });

  test('defaultLanguagesList has no duplicated isoCode', () {
    // ignore: deprecated_member_use_from_same_package
    final isoCodes = defaultLanguagesList.map((item) => item['isoCode']);
    expect(isoCodes.toSet().length, isoCodes.length);
  });

  testWidgets('LanguagePickerDropdown builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: LanguagePickerDropdown(initialValue: 'ko'),
      ),
    ));
    expect(find.text('Korean (ko)'), findsOneWidget);
  });

  testWidgets('LanguagePickerDialog search finds middle of name',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: LanguagePickerDialog(isSearchable: true),
    ));
    await tester.enterText(find.byType(TextField), 'orea');
    await tester.pump();
    expect(find.text('Korean'), findsOneWidget);
  });

  testWidgets('LanguagePickerCupertino builds in dark mode',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.dark),
      home: LanguagePickerCupertino(),
    ));
    expect(find.byType(LanguagePickerCupertino), findsOneWidget);
  });

  group('Language', () {
    test('equal languages are ==, share hashCode, work as Set/Map keys', () {
      const a = Language('ko', 'Korean', '한국어');
      final b = Language.fromMap({'isoCode': 'ko', 'name': 'Korean'});
      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect({a, b}.length, 1);
      expect({a: 1}[b], 1);
    });

    test('equality is the code alone, ignoring case', () {
      // 'nb' was renamed from 'Norwegian' to 'Norwegian Bokmål' in 0.4.0. A
      // Language kept from 0.3.0 has to keep matching the built-in entry.
      expect(const Language('nb', 'Norwegian'), Languages.norwegianBokmal);
      expect(const Language('KO', 'Korean'), Languages.korean);
      expect(
          const Language('KO', 'Korean').hashCode, Languages.korean.hashCode);
      expect(const Language('ko', 'Korean'),
          isNot(const Language('en', 'Korean')));
    });

    test('nativeName falls back to name', () {
      const a = Language('ko', 'Korean');
      expect(a.nativeName, 'Korean');
      final b = Language.fromMap({'isoCode': 'ko', 'name': 'Korean'});
      expect(b.nativeName, 'Korean');
    });

    test('fromIsoCode finds the language, case-insensitively', () {
      expect(Language.fromIsoCode('ko').name, 'Korean');
      expect(Language.fromIsoCode('KO').nativeName, '한국어');
      expect(() => Language.fromIsoCode('zzz'), throwsArgumentError);
    });
  });

  group('Languages.defaultLanguages', () {
    test('has 185 entries with no duplicated isoCode or name', () {
      const list = Languages.defaultLanguages;
      expect(list.length, 185);
      expect(list.map((l) => l.isoCode).toSet().length, list.length);
      // 'nb' and 'no' were both named 'Norwegian' before 0.4.0.
      expect(list.map((l) => l.name).toSet().length, list.length);
    });

    test('every language has a non-empty nativeName', () {
      for (final l in Languages.defaultLanguages) {
        expect(l.nativeName, isNotEmpty, reason: l.isoCode);
      }
    });

    test('deprecated defaultLanguagesList still mirrors the new list', () {
      // ignore: deprecated_member_use_from_same_package
      final legacy = defaultLanguagesList;
      expect(legacy.length, Languages.defaultLanguages.length);
      expect(legacy.first['isoCode'], Languages.defaultLanguages.first.isoCode);
      expect(legacy.first['nativeName'], isNotNull);
      // It used to be a growable list, and some people narrow it in place.
      expect(() => legacy.removeWhere((item) => item['isoCode'] == 'ko'),
          returnsNormally);
    });
  });

  testWidgets('dropdown accepts a freshly built equal Language',
      (WidgetTester tester) async {
    // Before 0.4.0 Language had no ==, so this died with the DropdownButton
    // "There should be exactly one item with [DropdownButton]'s value" assert.
    final languages = [
      Language.fromMap({'isoCode': 'ko', 'name': 'Korean'}),
      Language.fromMap({'isoCode': 'en', 'name': 'English'}),
    ];
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: LanguagePickerDropdown(languages: languages, initialValue: 'ko'),
      ),
    ));
    expect(tester.takeException(), isNull);
    expect(find.text('Korean (ko)'), findsOneWidget);
    expect(_selectionOf(tester).isoCode, 'ko');
  });

  testWidgets('dropdown still takes the deprecated languagesList',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: LanguagePickerDropdown(
          // ignore: deprecated_member_use_from_same_package
          languagesList: [
            {'isoCode': 'ko', 'name': 'Korean'},
            {'isoCode': 'en', 'name': 'English'},
          ],
          initialValue: 'en',
        ),
      ),
    ));
    expect(_selectionOf(tester).isoCode, 'en');
  });

  testWidgets('controller changes the selection', (WidgetTester tester) async {
    final controller =
        LanguagePickerDropdownController(initialValue: Languages.korean);
    addTearDown(controller.dispose);
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: LanguagePickerDropdown(controller: controller)),
    ));
    expect(_selectionOf(tester), Languages.korean);

    controller.value = Languages.english;
    await tester.pump();
    expect(_selectionOf(tester), Languages.english);
  });

  testWidgets('controller follows a selection it cannot hold',
      (WidgetTester tester) async {
    // Japanese is not in the list, so the dropdown shows Korean. The
    // controller has to agree with what is on the screen.
    final controller =
        LanguagePickerDropdownController(initialValue: Languages.japanese);
    addTearDown(controller.dispose);
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: LanguagePickerDropdown(
          controller: controller,
          languages: const [Languages.korean, Languages.english],
        ),
      ),
    ));
    expect(_selectionOf(tester), Languages.korean);
    expect(controller.value, Languages.korean);
  });

  testWidgets('controller snaps back when set to a language not in the list',
      (WidgetTester tester) async {
    final controller =
        LanguagePickerDropdownController(initialValue: Languages.korean);
    addTearDown(controller.dispose);
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: LanguagePickerDropdown(
          controller: controller,
          languages: const [Languages.korean, Languages.english],
        ),
      ),
    ));

    controller.value = Languages.japanese;
    await tester.pump();
    expect(_selectionOf(tester), Languages.korean);
    expect(controller.value, Languages.korean);
  });

  testWidgets('a listener elsewhere in the tree sees the reconciled value',
      (WidgetTester tester) async {
    // The ValueListenableBuilder above the dropdown listens to the same
    // controller. It has to converge on the language the dropdown shows.
    final controller =
        LanguagePickerDropdownController(initialValue: Languages.japanese);
    addTearDown(controller.dispose);
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            ValueListenableBuilder<Language>(
              valueListenable: controller,
              builder: (_, Language language, __) => Text(language.name),
            ),
            LanguagePickerDropdown(
              controller: controller,
              languages: const [Languages.korean, Languages.english],
            ),
          ],
        ),
      ),
    ));
    expect(tester.takeException(), isNull);

    await tester.pump();
    expect(find.text('Korean'), findsOneWidget);
    expect(controller.value, Languages.korean);
  });

  testWidgets('reconciling after an update does not break listeners elsewhere',
      (WidgetTester tester) async {
    // Only the dropdown's subtree rebuilds here. Writing to the controller
    // synchronously from didUpdateWidget would make the outside
    // ValueListenableBuilder call setState during that build, which throws.
    // The write must wait for the end of the frame.
    final controller =
        LanguagePickerDropdownController(initialValue: Languages.korean);
    addTearDown(controller.dispose);
    late StateSetter rebuildDropdown;
    List<Language> languages = const [Languages.korean, Languages.english];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            ValueListenableBuilder<Language>(
              valueListenable: controller,
              builder: (_, Language language, __) =>
                  Text('shown: ${language.name}'),
            ),
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                rebuildDropdown = setState;
                return LanguagePickerDropdown(
                  controller: controller,
                  languages: languages,
                );
              },
            ),
          ],
        ),
      ),
    ));

    // Narrow the list, so that the controller's language drops out of it.
    languages = const [Languages.english, Languages.japanese];
    rebuildDropdown(() {});
    await tester.pump();
    expect(tester.takeException(), isNull);

    await tester.pump();
    expect(controller.value, Languages.english);
    expect(find.text('shown: English'), findsOneWidget);
  });

  testWidgets('dropdown keeps the selection when an equal list is rebuilt',
      (WidgetTester tester) async {
    // A parent rebuilding with a fresh but equal list must not reset what the
    // user picked back to initialValue. List.of, so that every build really
    // makes a new list: a const one would be canonicalized to the same
    // instance and the widget would not even be updated.
    Widget build() => MaterialApp(
          home: Scaffold(
            body: LanguagePickerDropdown(
              initialValue: 'ko',
              languages: List<Language>.of(const <Language>[
                Languages.korean,
                Languages.english,
                Languages.japanese,
              ]),
            ),
          ),
        );

    await tester.pumpWidget(build());
    await tester.tap(find.byType(DropdownButton<Language>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Japanese (ja)').last);
    await tester.pumpAndSettle();
    expect(_selectionOf(tester), Languages.japanese);

    await tester.pumpWidget(build());
    expect(_selectionOf(tester), Languages.japanese);
  });

  testWidgets('dropdown follows initialValue after it is built',
      (WidgetTester tester) async {
    Widget build(String isoCode) => MaterialApp(
          home: Scaffold(
            body: LanguagePickerDropdown(initialValue: isoCode),
          ),
        );

    await tester.pumpWidget(build('ko'));
    expect(_selectionOf(tester), Languages.korean);

    await tester.pumpWidget(build('ja'));
    expect(_selectionOf(tester), Languages.japanese);
  });

  testWidgets('dropdown does not throw when languages drop initialValue',
      (WidgetTester tester) async {
    // Re-resolving must never throw from didUpdateWidget: an exception while
    // the element tree updates takes the whole subtree down.
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: LanguagePickerDropdown(
          initialValue: 'ko',
          languages: [Languages.korean, Languages.english],
        ),
      ),
    ));
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: LanguagePickerDropdown(
          initialValue: 'ko',
          languages: [Languages.english, Languages.japanese],
        ),
      ),
    ));
    expect(tester.takeException(), isNull);
    expect(_selectionOf(tester), Languages.english);
  });

  testWidgets('dialog search matches nativeName', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: LanguagePickerDialog(isSearchable: true),
    ));
    await tester.enterText(find.byType(TextField), '한국');
    await tester.pump();
    expect(find.text('Korean'), findsOneWidget);
  });
}
