import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdm_s14_ci_estados/features/categorias/categorias_repository_fake.dart';
import 'package:pdm_s14_ci_estados/features/categorias/pantalla_categorias.dart';

void main() {
  testWidgets('Muestra error y permite reintentar', (tester) async {
    final repositorio = CategoriasRepositoryFake(
      escenario: CategoriasEscenario.error,
    );

    await tester.pumpWidget(
      MaterialApp(home: PantallaCategorias(repositorio: repositorio)),
    );

    await tester.pumpAndSettle();

    expect(find.text('No pudimos cargar las categorías.'), findsOneWidget);

    repositorio.escenario = CategoriasEscenario.datos;

    await tester.tap(find.text('Reintentar'));
    await tester.pumpAndSettle();

    expect(find.text('Bebidas'), findsOneWidget);
    expect(repositorio.llamadas, 2);
  });

  testWidgets('Estado vacío con acción funcional', (tester) async {
    final repositorio = CategoriasRepositoryFake(
      escenario: CategoriasEscenario.vacio,
    );

    await tester.pumpWidget(
      MaterialApp(home: PantallaCategorias(repositorio: repositorio)),
    );

    await tester.pumpAndSettle();

    expect(find.text('Aún no hay categorías.'), findsOneWidget);

    repositorio.escenario = CategoriasEscenario.datos;

    await tester.tap(find.text('Actualizar'));
    await tester.pumpAndSettle();

    expect(find.text('Bebidas'), findsOneWidget);
    expect(repositorio.llamadas, 2);
  });

  testWidgets('Muestra datos', (tester) async {
    final repositorio = CategoriasRepositoryFake();

    await tester.pumpWidget(
      MaterialApp(home: PantallaCategorias(repositorio: repositorio)),
    );

    await tester.pumpAndSettle();

    expect(find.text('Bebidas'), findsOneWidget);
    expect(find.text('Snacks'), findsOneWidget);
  });

  testWidgets('Muestra cargando', (tester) async {
    final repositorio = CategoriasRepositoryFake(
      demora: const Duration(seconds: 1),
    );

    await tester.pumpWidget(
      MaterialApp(home: PantallaCategorias(repositorio: repositorio)),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('Bebidas'), findsOneWidget);
  });
}
