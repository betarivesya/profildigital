import 'package:flutter_test/flutter_test.dart';

import 'package:kartu/main.dart';

void main() {
  testWidgets('profile page can follow a user', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Betari Vesya Candra'), findsOneWidget);
    expect(find.text('1200'), findsOneWidget);
    expect(find.text('Ikuti'), findsOneWidget);

    await tester.tap(find.text('Ikuti'));
    await tester.pumpAndSettle();

    expect(find.text('1201'), findsOneWidget);
    expect(find.text('Mengikuti'), findsOneWidget);
  });
}
