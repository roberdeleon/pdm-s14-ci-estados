import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdm_s14_ci_estados/features/categorias/pantalla_categorias.dart';

class RepositorioFalso {
  bool fallar = true;
  int consultas = 0;

  Future<List<String>> obtenerCategorias() async {
    consultas++;

    if (fallar) {
      throw Exception('Error simulado');
    }

    return ['Electrónica', 'Ropa'];
  }
}

void main() {
  testWidgets('Muestra error y permite reintentar', (tester) async {
    final repositorio = RepositorioFalso();

    await tester.pumpWidget(
      MaterialApp(
        home: PantallaCategorias(
          cargarCategorias: repositorio.obtenerCategorias,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('No pudimos cargar las categorías.'), findsOneWidget);

    expect(find.text('Reintentar'), findsOneWidget);

    repositorio.fallar = false;

    await tester.tap(find.text('Reintentar'));
    await tester.pumpAndSettle();

    expect(find.text('Electrónica'), findsOneWidget);
    expect(repositorio.consultas, 2);
  });

  testWidgets('Estado vacío con acción funcional', (tester) async {
    int consultas = 0;

    Future<List<String>> cargar() async {
      consultas++;

      if (consultas == 1) {
        return [];
      }

      return ['Hogar'];
    }

    await tester.pumpWidget(
      MaterialApp(home: PantallaCategorias(cargarCategorias: cargar)),
    );

    await tester.pumpAndSettle();

    expect(find.text('Aún no hay categorías.'), findsOneWidget);

    await tester.tap(find.text('Actualizar'));
    await tester.pumpAndSettle();

    expect(find.text('Hogar'), findsOneWidget);
    expect(consultas, 2);
  });
}
