import 'producto.dart';
import 'productos_repository.dart';

enum ProductosEscenario { datos, vacio, error }

class ProductosRepositoryFake implements ProductosRepository {
  ProductosRepositoryFake({
    this.escenario = ProductosEscenario.datos,
    this.demora = Duration.zero,
    List<Producto>? productos,
  }) : _productos = List.unmodifiable(productos ?? _productosDePrueba);

  static const _productosDePrueba = [
    Producto(id: 1, nombre: 'Café', precio: 15.0),
    Producto(id: 2, nombre: 'Té', precio: 12.5),
  ];

  ProductosEscenario escenario;
  final Duration demora;
  final List<Producto> _productos;

  @override
  Future<List<Producto>> obtenerProductos() async {
    await Future<void>.delayed(demora);

    switch (escenario) {
      case ProductosEscenario.datos:
        return List<Producto>.of(_productos);
      case ProductosEscenario.vacio:
        return [];
      case ProductosEscenario.error:
        throw Exception('Error simulado al obtener productos');
    }
  }
}
