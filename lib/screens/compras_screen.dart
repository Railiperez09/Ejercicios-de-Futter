// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class _ProductoCompra {
  String nombre;
  bool comprado;

  _ProductoCompra({required this.nombre, this.comprado = false});
}

class ComprasScreen extends StatefulWidget {
  const ComprasScreen({super.key});

  @override
  State<ComprasScreen> createState() => _ComprasScreenState();
}

class _ComprasScreenState extends State<ComprasScreen> {
  final TextEditingController _productoController = TextEditingController();
  final List<_ProductoCompra> _productos = [];

  @override
  void dispose() {
    _productoController.dispose();
    super.dispose();
  }

  int get _pendientes => _productos.where((p) => !p.comprado).length;

  void _agregarProducto() {
    final String nombre = _productoController.text.trim();
    if (nombre.isEmpty) return;

    setState(() {
      _productos.add(_ProductoCompra(nombre: nombre));
      _productoController.clear();
    });
  }

  Future<void> _confirmarEliminar(int index) async {
    final bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Eliminar producto'),
        content: Text('¿Eliminar "${_productos[index].nombre}" de la lista?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Eliminar')),
        ],
      ),
    );

    if (confirmar == true) {
      setState(() => _productos.removeAt(index));
    }
  }

  void _eliminarComprados() {
    setState(() => _productos.removeWhere((p) => p.comprado));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de compras')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _productoController,
                      decoration: const InputDecoration(
                        labelText: 'Nuevo producto',
                        prefixIcon: Icon(Icons.add_shopping_cart_outlined),
                      ),
                      onSubmitted: (_) => _agregarProducto(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _agregarProducto,
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18)),
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Productos pendientes: $_pendientes',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.taupeGrey, fontSize: 15),
                  ),
                  TextButton.icon(
                    onPressed: _productos.any((p) => p.comprado) ? _eliminarComprados : null,
                    icon: const Icon(Icons.delete_sweep_outlined, size: 18),
                    label: const Text('Eliminar comprados'),
                    style: TextButton.styleFrom(foregroundColor: AppColors.oldRose),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: _productos.isEmpty
                  ? const Center(child: Text('No hay productos en la lista.', style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      itemCount: _productos.length,
                      itemBuilder: (context, index) {
                        final producto = _productos[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 1.5,
                          child: ListTile(
                            leading: Checkbox(
                              value: producto.comprado,
                              activeColor: AppColors.taupeGrey,
                              onChanged: (valor) => setState(() => producto.comprado = valor ?? false),
                            ),
                            title: Text(
                              producto.nombre,
                              style: TextStyle(
                                decoration: producto.comprado ? TextDecoration.lineThrough : null,
                                color: producto.comprado ? Colors.grey : AppColors.textDark,
                                fontSize: 16,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                              onPressed: () => _confirmarEliminar(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
