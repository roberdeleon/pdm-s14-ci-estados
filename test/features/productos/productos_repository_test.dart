import 'package:flutter_test/flutter_test.dart';
import 'package:pdm_s14_ci_estados/features/productos/producto.dart';
import 'package:pdm_s14_ci_estados/features/productos/productos_repository.dart';
import 'package:pdm_s14_ci_estados/features/productos/productos_repository_fake.dart';

void main() {
  test('Producto conserva sus campos', () {
    const producto = Producto(id: 7, nombre: 'Pan', precio: 8.5);

    expect(producto.id, 7);
    expect(producto.nombre, 'Pan');
    expect(producto.precio, 8.5);
  });

  test('devuelve los productos configurados', () async {
    const productos = [Producto(id: 3, nombre: 'Jugo', precio: 10.0)];
    final ProductosRepository repositorio = ProductosRepositoryFake(
      productos: productos,
    );

    final resultado = await repositorio.obtenerProductos();

    expect(resultado, hasLength(1));
    expect(resultado.single.id, 3);
    expect(resultado.single.nombre, 'Jugo');
    expect(resultado.single.precio, 10.0);
  });

  test('devuelve una lista vacía', () async {
    final repositorio = ProductosRepositoryFake(
      escenario: ProductosEscenario.vacio,
    );

    expect(await repositorio.obtenerProductos(), isEmpty);
  });

  test('lanza una excepción en el escenario de error', () async {
    final repositorio = ProductosRepositoryFake(
      escenario: ProductosEscenario.error,
    );

    await expectLater(repositorio.obtenerProductos(), throwsException);
  });

  test('permite configurar una demora', () async {
    const demora = Duration(milliseconds: 20);
    final repositorio = ProductosRepositoryFake(demora: demora);
    final reloj = Stopwatch()..start();

    await repositorio.obtenerProductos();
    reloj.stop();

    expect(reloj.elapsed, greaterThanOrEqualTo(demora));
  });

  test('una nueva consulta puede tener éxito después de un error', () async {
    final repositorio = ProductosRepositoryFake(
      escenario: ProductosEscenario.error,
    );

    await expectLater(repositorio.obtenerProductos(), throwsException);
    repositorio.escenario = ProductosEscenario.datos;

    expect(await repositorio.obtenerProductos(), isNotEmpty);
  });
}
