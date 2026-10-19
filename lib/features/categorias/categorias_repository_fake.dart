import 'categoria.dart';
import 'categorias_repository.dart';

enum CategoriasEscenario { datos, vacio, error }

class CategoriasRepositoryFake implements CategoriasRepository {
  CategoriasRepositoryFake({
    this.escenario = CategoriasEscenario.datos,
    this.demora = Duration.zero,
    List<Categoria>? categorias,
  }) : _categorias = List.unmodifiable(categorias ?? _categoriasDePrueba);

  static const _categoriasDePrueba = [
    Categoria(id: 1, nombre: 'Bebidas'),
    Categoria(id: 2, nombre: 'Panadería'),
    Categoria(id: 3, nombre: 'Snacks'),
  ];

  /// Resultado de la próxima consulta. Es modificable para simular que un
  /// error se resuelve antes de pulsar Reintentar.
  CategoriasEscenario escenario;
  final Duration demora;

  /// Cuántas veces se consultó; permite comprobar que Reintentar vuelve a
  /// consultar.
  int llamadas = 0;

  final List<Categoria> _categorias;

  @override
  Future<List<Categoria>> obtenerCategorias() async {
    llamadas++;
    final escenarioDeLaConsulta = escenario;
    await Future<void>.delayed(demora);

    switch (escenarioDeLaConsulta) {
      case CategoriasEscenario.datos:
        return List<Categoria>.of(_categorias);
      case CategoriasEscenario.vacio:
        return [];
      case CategoriasEscenario.error:
        throw Exception('Error simulado al obtener categorías');
    }
  }
}
