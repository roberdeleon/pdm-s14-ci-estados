import 'producto.dart';

abstract class ProductosRepository {
  Future<List<Producto>> obtenerProductos();
}
