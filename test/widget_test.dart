import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdm_s14_ci_estados/main.dart';

void main() {
  testWidgets('abre Productos desde el inicio', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Laboratorio S14'), findsOneWidget);
    expect(find.text('Productos'), findsOneWidget);
    expect(find.text('Categorías'), findsOneWidget);

    await tester.tap(find.text('Productos'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Listado de productos'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Café'), findsOneWidget);
    expect(find.text('Té'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('abre Categorías desde el inicio', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Categorías'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Bebidas'), findsOneWidget);
    expect(find.text('Snacks'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
