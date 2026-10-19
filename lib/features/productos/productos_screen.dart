import 'package:flutter/material.dart';

import 'producto.dart';
import 'productos_repository.dart';

class ProductosScreen extends StatefulWidget {
  const ProductosScreen({super.key, required this.repository});

  final ProductosRepository repository;

  @override
  State<ProductosScreen> createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductosScreen> {
  late Future<List<Producto>> _futureProductos;

  @override
  void initState() {
    super.initState();
    _cargarProductos();
  }

  void _cargarProductos() {
    _futureProductos = widget.repository.obtenerProductos();
  }

  void _reintentar() {
    setState(() {
      _cargarProductos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listado de productos')),
      body: FutureBuilder<List<Producto>>(
        future: _futureProductos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const _EstadoCargando();
          }

          if (snapshot.hasError) {
            return _EstadoError(onRetry: _reintentar);
          }

          final productos = snapshot.data ?? [];

          if (productos.isEmpty) {
            return _EstadoVacio(onReload: _reintentar);
          }

          return _ListaProductos(productos: productos);
        },
      ),
    );
  }
}

class _EstadoCargando extends StatelessWidget {
  const _EstadoCargando();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Cargando productos...'),
        ],
      ),
    );
  }
}

class _EstadoError extends StatelessWidget {
  const _EstadoError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 16),
            const Text(
              'No pudimos cargar los productos.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('Reintentar')),
          ],
        ),
      ),
    );
  }
}

class _EstadoVacio extends StatelessWidget {
  const _EstadoVacio({required this.onReload});

  final VoidCallback onReload;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.inventory_2_outlined, size: 48),
            const SizedBox(height: 16),
            const Text('Aún no hay productos.', textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onReload,
              child: const Text('Volver a cargar'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListaProductos extends StatelessWidget {
  const _ListaProductos({required this.productos});

  final List<Producto> productos;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: productos.length,
      separatorBuilder: (_, _) => const Divider(),
      itemBuilder: (context, index) {
        final producto = productos[index];

        return ListTile(
          title: Text(producto.nombre),
          subtitle: Text('ID: ${producto.id}'),
          trailing: Text('Q${producto.precio.toStringAsFixed(2)}'),
        );
      },
    );
  }
}
