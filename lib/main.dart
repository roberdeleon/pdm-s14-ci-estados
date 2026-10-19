import 'package:flutter/material.dart';

import 'features/categorias/categorias_repository_fake.dart';
import 'features/categorias/pantalla_categorias.dart';
import 'features/productos/productos_repository_fake.dart';
import 'features/productos/productos_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laboratorio S14',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const InicioScreen(),
    );
  }
}

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Laboratorio S14')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.inventory_2_outlined),
            title: const Text('Productos'),
            subtitle: const Text('Consultar el listado de productos'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => ProductosScreen(
                    repository: ProductosRepositoryFake(
                      demora: const Duration(seconds: 2),
                    ),
                  ),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.category_outlined),
            title: const Text('Categorías'),
            subtitle: const Text('Consultar el listado de categorías'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => PantallaCategorias(
                    repositorio: CategoriasRepositoryFake(
                      demora: const Duration(seconds: 2),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
