import 'package:flutter_test/flutter_test.dart';

import 'package:language_pickers_example/main.dart';

void main() {
  testWidgets('the example app builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('language_pickers Example'), findsOneWidget);
  });
}
