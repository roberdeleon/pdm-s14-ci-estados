import 'package:flutter/material.dart';

class PantallaCategorias extends StatefulWidget {
  final Future<List<String>> Function() cargarCategorias;

  const PantallaCategorias({super.key, required this.cargarCategorias});

  @override
  State<PantallaCategorias> createState() => _PantallaCategoriasState();
}

class _PantallaCategoriasState extends State<PantallaCategorias> {
  late Future<List<String>> categorias;

  @override
  void initState() {
    super.initState();
    categorias = widget.cargarCategorias();
  }

  void reintentar() {
    setState(() {
      categorias = widget.cargarCategorias();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorías')),
      body: FutureBuilder<List<String>>(
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

          final lista = snapshot.data ?? [];

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
                title: Text(lista[index]),
              );
            },
          );
        },
      ),
    );
  }
}
