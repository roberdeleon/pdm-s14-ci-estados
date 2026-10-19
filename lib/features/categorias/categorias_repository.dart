import 'categoria.dart';

abstract class CategoriasRepository {
  Future<List<Categoria>> obtenerCategorias();
}
