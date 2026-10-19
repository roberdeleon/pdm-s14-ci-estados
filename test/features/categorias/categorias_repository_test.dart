import 'package:flutter_test/flutter_test.dart';
import 'package:pdm_s14_ci_estados/features/categorias/categoria.dart';
import 'package:pdm_s14_ci_estados/features/categorias/categorias_repository.dart';
import 'package:pdm_s14_ci_estados/features/categorias/categorias_repository_fake.dart';

void main() {
  test('Categoria conserva sus campos', () {
    const categoria = Categoria(id: 7, nombre: 'Lácteos');

    expect(categoria.id, 7);
    expect(categoria.nombre, 'Lácteos');
  });

  test('devuelve categorías de prueba por defecto', () async {
    final CategoriasRepository repositorio = CategoriasRepositoryFake();

    final resultado = await repositorio.obtenerCategorias();

    expect(resultado, isNotEmpty);
  });

  test('devuelve las categorías configuradas', () async {
    const categorias = [Categoria(id: 3, nombre: 'Verduras')];
    final repositorio = CategoriasRepositoryFake(categorias: categorias);

    final resultado = await repositorio.obtenerCategorias();

    expect(resultado, hasLength(1));
    expect(resultado.single.id, 3);
    expect(resultado.single.nombre, 'Verduras');
  });

  test('devuelve una lista vacía', () async {
    final repositorio = CategoriasRepositoryFake(
      escenario: CategoriasEscenario.vacio,
    );

    expect(await repositorio.obtenerCategorias(), isEmpty);
  });

  test('lanza una excepción en el escenario de error', () async {
    final repositorio = CategoriasRepositoryFake(
      escenario: CategoriasEscenario.error,
    );

    await expectLater(repositorio.obtenerCategorias(), throwsException);
  });

  test('no responde hasta que termina la demora', () async {
    final repositorio = CategoriasRepositoryFake(
      demora: const Duration(milliseconds: 100),
    );
    var terminada = false;

    final consulta = repositorio.obtenerCategorias().whenComplete(
      () => terminada = true,
    );
    await Future<void>.delayed(Duration.zero);

    expect(terminada, isFalse);
    await consulta;
    expect(terminada, isTrue);
  });

  test('cuenta cada consulta realizada', () async {
    final repositorio = CategoriasRepositoryFake();

    await repositorio.obtenerCategorias();
    await repositorio.obtenerCategorias();

    expect(repositorio.llamadas, 2);
  });

  test('una nueva consulta puede tener éxito después de un error', () async {
    final repositorio = CategoriasRepositoryFake(
      escenario: CategoriasEscenario.error,
    );

    await expectLater(repositorio.obtenerCategorias(), throwsException);
    repositorio.escenario = CategoriasEscenario.datos;

    expect(await repositorio.obtenerCategorias(), isNotEmpty);
  });
}
