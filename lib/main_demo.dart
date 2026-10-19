import 'package:flutter/material.dart';

import 'features/productos/producto.dart';
import 'features/productos/productos_repository_fake.dart';
import 'features/productos/productos_screen.dart';

void main() {
  const escenario = String.fromEnvironment('ESCENARIO', defaultValue: 'error');

  runApp(
    MaterialApp(
      home: ProductosScreen(
        repository: _RepositorioDemo(
          escenario: escenario == 'vacio'
              ? ProductosEscenario.vacio
              : ProductosEscenario.error,
        ),
      ),
    ),
  );
}

class _RepositorioDemo extends ProductosRepositoryFake {
  _RepositorioDemo({required super.escenario})
    : super(demora: const Duration(seconds: 2));

  @override
  Future<List<Producto>> obtenerProductos() async {
    try {
      return await super.obtenerProductos();
    } finally {
      escenario = ProductosEscenario.datos;
    }
  }
}
