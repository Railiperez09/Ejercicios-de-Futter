import 'package:flutter/material.dart';
import '../models/tarea.dart';
import '../theme/app_colors.dart';
import 'tarea_form_screen.dart';

class TareasScreen extends StatefulWidget {
  const TareasScreen({super.key});

  @override
  State<TareasScreen> createState() => _TareasScreenState();
}

class _TareasScreenState extends State<TareasScreen> {
  final List<Tarea> _tareas = [];

  int get _totales => _tareas.length;
  int get _completadas => _tareas.where((t) => t.completada).length;
  int get _pendientes => _totales - _completadas;

  Future<void> _abrirFormulario({Tarea? tareaExistente, int? index}) async {
    final Tarea? resultado = await Navigator.push<Tarea>(
      context,
      MaterialPageRoute(builder: (_) => TareaFormScreen(tarea: tareaExistente)),
    );

    if (resultado != null) {
      setState(() {
        if (index != null) {
          _tareas[index] = resultado;
        } else {
          _tareas.add(resultado);
        }
      });
    }
  }

  Future<void> _confirmarEliminar(int index) async {
    final bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Eliminar tarea'),
        content: Text('¿Eliminar la tarea "${_tareas[index].titulo}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Eliminar')),
        ],
      ),
    );

    if (confirmar == true) {
      setState(() => _tareas.removeAt(index));
    }
  }

  Color _colorPrioridad(Prioridad prioridad) {
    switch (prioridad) {
      case Prioridad.alta:
        return Colors.redAccent;
      case Prioridad.media:
        return Colors.orangeAccent;
      case Prioridad.baja:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tareas pendientes')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.taupeGrey,
        onPressed: () => _abrirFormulario(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(child: _buildResumen('Total', _totales, AppColors.taupeGrey)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildResumen('Pendientes', _pendientes, AppColors.coolSteel)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildResumen('Completadas', _completadas, AppColors.paleSlate)),
                ],
              ),
            ),
            Expanded(
              child: _tareas.isEmpty
                  ? const Center(child: Text('No hay tareas registradas.', style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: _tareas.length,
                      itemBuilder: (context, index) {
                        final tarea = _tareas[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: tarea.completada,
                                      activeColor: AppColors.taupeGrey,
                                      onChanged: (valor) => setState(() => tarea.completada = valor ?? false),
                                    ),
                                    Expanded(
                                      child: Text(
                                        tarea.titulo,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          decoration: tarea.completada ? TextDecoration.lineThrough : null,
                                          color: tarea.completada ? Colors.grey : AppColors.textDark,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: _colorPrioridad(tarea.prioridad).withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        tarea.prioridad.etiqueta,
                                        style: TextStyle(
                                          color: _colorPrioridad(tarea.prioridad),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (tarea.descripcion.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40, top: 2, bottom: 4),
                                    child: Text(tarea.descripcion,
                                        style: const TextStyle(color: AppColors.textDark, fontSize: 13.5)),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.event_outlined, size: 14, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${tarea.fechaLimite.day}/${tarea.fechaLimite.month}/${tarea.fechaLimite.year}',
                                        style: const TextStyle(fontSize: 12.5, color: Colors.grey),
                                      ),
                                      const Spacer(),
                                      TextButton.icon(
                                        onPressed: () => _abrirFormulario(tareaExistente: tarea, index: index),
                                        icon: const Icon(Icons.edit_outlined, size: 16),
                                        label: const Text('Editar'),
                                        style: TextButton.styleFrom(foregroundColor: AppColors.coolSteel, padding: EdgeInsets.zero),
                                      ),
                                      TextButton.icon(
                                        onPressed: () => _confirmarEliminar(index),
                                        icon: const Icon(Icons.delete_outline, size: 16),
                                        label: const Text('Eliminar'),
                                        style: TextButton.styleFrom(foregroundColor: Colors.redAccent, padding: EdgeInsets.zero),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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

  Widget _buildResumen(String etiqueta, int valor, Color color) {
    final Color textoPrincipal = AppColors.contrastText(color);
    final Color textoSecundario = textoPrincipal.withOpacity(0.75);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text('$valor', style: TextStyle(color: textoPrincipal, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(etiqueta, style: TextStyle(color: textoSecundario, fontSize: 12)),
        ],
      ),
    );
  }
}
