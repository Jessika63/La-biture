import 'package:flutter_test/flutter_test.dart';

import 'package:biture/main.dart';

void main() {
  testWidgets('Home screen shows the app title and start button', (WidgetTester tester) async {
    await tester.pumpWidget(const BitureApp());

    expect(find.text('Biture'), findsOneWidget);
    expect(find.text('Nouvelle partie'), findsOneWidget);
  });
}

