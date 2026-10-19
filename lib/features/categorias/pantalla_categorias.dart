import 'package:flutter/material.dart';

import 'categoria.dart';
import 'categorias_repository.dart';

class PantallaCategorias extends StatefulWidget {
  final CategoriasRepository repositorio;

  const PantallaCategorias({super.key, required this.repositorio});

  @override
  State<PantallaCategorias> createState() => _PantallaCategoriasState();
}

class _PantallaCategoriasState extends State<PantallaCategorias> {
  late Future<List<Categoria>> categorias;

  @override
  void initState() {
    super.initState();
    categorias = widget.repositorio.obtenerCategorias();
  }

  void reintentar() {
    setState(() {
      categorias = widget.repositorio.obtenerCategorias();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorías')),
      body: FutureBuilder<List<Categoria>>(
        future: categorias,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No pudimos cargar las categorías.'),
                  ElevatedButton(
                    onPressed: reintentar,
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          final lista = snapshot.data ?? <Categoria>[];

          if (lista.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Aún no hay categorías.'),
                  ElevatedButton(
                    onPressed: reintentar,
                    child: const Text('Actualizar'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.category),
                title: Text(lista[index].nombre),
              );
            },
          );
        },
      ),
    );
  }
}
