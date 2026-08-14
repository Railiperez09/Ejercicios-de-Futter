import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class EdadScreen extends StatefulWidget {
  const EdadScreen({super.key});

  @override
  State<EdadScreen> createState() => _EdadScreenState();
}

class _EdadScreenState extends State<EdadScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _anioController = TextEditingController();

  String? _resultado;
  String? _error;

  @override
  void dispose() {
    _nombreController.dispose();
    _anioController.dispose();
    super.dispose();
  }

  void _calcularEdad() {
    final String nombre = _nombreController.text.trim();
    final String anioTexto = _anioController.text.trim();

    setState(() {
      _resultado = null;
      _error = null;

      if (nombre.isEmpty) {
        _error = 'Debe introducir un nombre.';
        return;
      }
      if (anioTexto.isEmpty) {
        _error = 'Debe introducir el ano de nacimiento.';
        return;
      }

      final int? anio = int.tryParse(anioTexto);
      if (anio == null) {
        _error = 'El ano debe ser un valor numerico.';
        return;
      }

      final int anioActual = DateTime.now().year;

      if (anio <= 1900) {
        _error = 'El ano debe ser mayor que 1900.';
        return;
      }
      if (anio > anioActual) {
        _error = 'El ano no puede ser superior al ano actual.';
        return;
      }

      final int edad = anioActual - anio;
      _resultado = '$nombre, tienes aproximadamente $edad anos.';
    });
  }

  void _limpiar() {
    setState(() {
      _nombreController.clear();
      _anioController.clear();
      _resultado = null;
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de edad')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _anioController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Ano de nacimiento',
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(onPressed: _calcularEdad, child: const Text('Calcular edad')),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _limpiar,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.taupeGrey,
                        side: const BorderSide(color: AppColors.taupeGrey),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('Limpiar'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (_resultado != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.oldRose.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.oldRose),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: AppColors.taupeGrey),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(_resultado!, style: const TextStyle(fontSize: 16, color: AppColors.textDark)),
                      ),
                    ],
                  ),
                ),
              if (_error != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red.shade700),
                      const SizedBox(width: 12),
                      Expanded(child: Text(_error!, style: TextStyle(fontSize: 15, color: Colors.red.shade700))),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
