import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdm_s14_ci_estados/features/productos/productos_repository_fake.dart';
import 'package:pdm_s14_ci_estados/features/productos/productos_screen.dart';

void main() {
  testWidgets('muestra error cuando el repositorio falla', (tester) async {
    final repository = ProductosRepositoryFake(
      escenario: ProductosEscenario.error,
    );

    await tester.pumpWidget(
      MaterialApp(home: ProductosScreen(repository: repository)),
    );

    await tester.pumpAndSettle();

    expect(find.text('No pudimos cargar los productos.'), findsOneWidget);

    expect(find.text('Reintentar'), findsOneWidget);
  });

  testWidgets('reintentar vuelve a consultar y muestra los datos', (
    tester,
  ) async {
    final repository = ProductosRepositoryFake(
      escenario: ProductosEscenario.error,
    );

    await tester.pumpWidget(
      MaterialApp(home: ProductosScreen(repository: repository)),
    );

    await tester.pumpAndSettle();

    expect(find.text('No pudimos cargar los productos.'), findsOneWidget);

    repository.escenario = ProductosEscenario.datos;

    await tester.tap(find.text('Reintentar'));

    await tester.pumpAndSettle();

    expect(find.text('Café'), findsOneWidget);

    expect(find.text('Té'), findsOneWidget);
  });

  testWidgets('el estado vacio permite volver a cargar y mostrar datos', (
    tester,
  ) async {
    final repository = ProductosRepositoryFake(
      escenario: ProductosEscenario.vacio,
    );

    await tester.pumpWidget(
      MaterialApp(home: ProductosScreen(repository: repository)),
    );

    await tester.pumpAndSettle();

    expect(find.text('Aún no hay productos.'), findsOneWidget);

    expect(find.text('Volver a cargar'), findsOneWidget);

    repository.escenario = ProductosEscenario.datos;

    await tester.tap(find.text('Volver a cargar'));

    await tester.pumpAndSettle();

    expect(find.text('Café'), findsOneWidget);

    expect(find.text('Té'), findsOneWidget);
  });
}
