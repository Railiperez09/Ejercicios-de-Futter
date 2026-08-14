import 'package:flutter/material.dart';
import '../models/tarea.dart';
import '../theme/app_colors.dart';

class TareaFormScreen extends StatefulWidget {
  final Tarea? tarea;

  const TareaFormScreen({super.key, this.tarea});

  @override
  State<TareaFormScreen> createState() => _TareaFormScreenState();
}

class _TareaFormScreenState extends State<TareaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _tituloController;
  late final TextEditingController _descripcionController;
  DateTime? _fechaLimite;
  Prioridad _prioridad = Prioridad.media;

  bool get _esEdicion => widget.tarea != null;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.tarea?.titulo ?? '');
    _descripcionController = TextEditingController(text: widget.tarea?.descripcion ?? '');
    _fechaLimite = widget.tarea?.fechaLimite;
    _prioridad = widget.tarea?.prioridad ?? Prioridad.media;
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFecha() async {
    final DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: _fechaLimite ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (fecha != null) {
      setState(() => _fechaLimite = fecha);
    }
  }

  void _guardar() {
    final bool formularioValido = _formKey.currentState?.validate() ?? false;
    if (!formularioValido) return;

    if (_fechaLimite == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debe seleccionar la fecha limite.')),
      );
      return;
    }

    final nuevaTarea = Tarea(
      titulo: _tituloController.text.trim(),
      descripcion: _descripcionController.text.trim(),
      fechaLimite: _fechaLimite!,
      prioridad: _prioridad,
      completada: widget.tarea?.completada ?? false,
    );

    Navigator.pop(context, nuevaTarea);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_esEdicion ? 'Editar tarea' : 'Nueva tarea')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _tituloController,
                  decoration: const InputDecoration(
                    labelText: 'Titulo',
                    prefixIcon: Icon(Icons.title_outlined),
                  ),
                  validator: (valor) =>
                      (valor == null || valor.trim().isEmpty) ? 'El titulo es obligatorio.' : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _descripcionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Descripcion',
                    prefixIcon: Icon(Icons.notes_outlined),
                  ),
                ),
                const SizedBox(height: 14),
                InkWell(
                  onTap: _seleccionarFecha,
                  borderRadius: BorderRadius.circular(14),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Fecha limite',
                      prefixIcon: Icon(Icons.event_outlined),
                    ),
                    child: Text(
                      _fechaLimite == null
                          ? 'Seleccionar fecha'
                          : '${_fechaLimite!.day}/${_fechaLimite!.month}/${_fechaLimite!.year}',
                      style: TextStyle(
                        color: _fechaLimite == null ? Colors.grey : AppColors.textDark,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<Prioridad>(
                  value: _prioridad,
                  decoration: const InputDecoration(
                    labelText: 'Prioridad',
                    prefixIcon: Icon(Icons.flag_outlined),
                  ),
                  items: Prioridad.values.map((p) => DropdownMenuItem(value: p, child: Text(p.etiqueta))).toList(),
                  onChanged: (valor) {
                    if (valor != null) setState(() => _prioridad = valor);
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _guardar,
                  child: Text(_esEdicion ? 'Guardar cambios' : 'Agregar tarea'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
