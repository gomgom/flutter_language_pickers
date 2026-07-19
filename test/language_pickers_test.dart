import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:language_pickers/language_pickers.dart';

void main() {
  test('getLanguageByIsoCode returns the right language', () {
    final language = LanguagePickerUtils.getLanguageByIsoCode('ko');
    expect(language.name, 'Korean');
    expect(language.isoCode, 'ko');
  });

  test('defaultLanguagesList has no duplicated isoCode', () {
    final isoCodes = defaultLanguagesList.map((item) => item['isoCode']);
    expect(isoCodes.toSet().length, isoCodes.length);
  });

  testWidgets('LanguagePickerDropdown builds', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: LanguagePickerDropdown(initialValue: 'ko'),
      ),
    ));
    expect(find.text('Korean (ko)'), findsOneWidget);
  });

  testWidgets('LanguagePickerCupertino builds in dark mode',
      (WidgetTester tester) async {
    await tester.pumpWidget(CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.dark),
      home: LanguagePickerCupertino(),
    ));
    expect(find.byType(LanguagePickerCupertino), findsOneWidget);
  });
}
