import 'package:flutter/material.dart';
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
    expect(find.widgetWithText(OutlinedButton, 'Mengikuti'), findsOneWidget);
  });

  testWidgets('saving edits updates the profile name and bio', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byTooltip('Edit profil'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Nama Baru');
    await tester.enterText(find.byType(TextFormField).at(1), 'Bio baru');
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    expect(find.text('Nama Baru'), findsOneWidget);
    expect(find.text('Bio baru'), findsOneWidget);
  });

  testWidgets('cancelling edits leaves the profile unchanged', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byTooltip('Edit profil'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'Nama Sementara');
    await tester.tap(find.text('Batal'));
    await tester.pumpAndSettle();

    expect(find.text('Betari Vesya Candra'), findsOneWidget);
    expect(find.text('Nama Sementara'), findsNothing);
  });

  testWidgets('back navigation leaves the profile unchanged', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byTooltip('Edit profil'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'Nama Sementara');
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('Betari Vesya Candra'), findsOneWidget);
    expect(find.text('Nama Sementara'), findsNothing);
  });

  testWidgets('empty name shows validation and keeps edit page open', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byTooltip('Edit profil'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, '   ');
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    expect(find.text('Nama tidak boleh kosong'), findsOneWidget);
    expect(find.text('Edit Profil'), findsOneWidget);
  });
}
