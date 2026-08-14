import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PropinasScreen extends StatefulWidget {
  const PropinasScreen({super.key});

  @override
  State<PropinasScreen> createState() => _PropinasScreenState();
}

class _PropinasScreenState extends State<PropinasScreen> {
  final TextEditingController _montoController = TextEditingController();
  int _porcentajeSeleccionado = 10;
  double? _propina;
  double? _total;
  String? _error;

  final List<int> _porcentajes = const [5, 10, 15, 20];

  @override
  void dispose() {
    _montoController.dispose();
    super.dispose();
  }

  void _calcular() {
    final String montoTexto = _montoController.text.trim();
    final double? monto = double.tryParse(montoTexto);

    setState(() {
      _propina = null;
      _total = null;
      _error = null;

      if (montoTexto.isEmpty || monto == null) {
        _error = 'Introduzca un monto valido.';
        return;
      }
      if (monto <= 0) {
        _error = 'El monto debe ser mayor que cero.';
        return;
      }

      _propina = monto * (_porcentajeSeleccionado / 100);
      _total = monto + _propina!;
    });
  }

  void _reiniciar() {
    setState(() {
      _montoController.clear();
      _porcentajeSeleccionado = 10;
      _propina = null;
      _total = null;
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de propinas')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _montoController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Monto de la cuenta (RD\$)',
                  prefixIcon: Icon(Icons.receipt_long_outlined),
                ),
              ),
              const SizedBox(height: 18),
              const Text('Porcentaje de propina',
                  style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: _porcentajes.map((p) {
                  final bool seleccionado = p == _porcentajeSeleccionado;
                  return ChoiceChip(
                    label: Text('$p%'),
                    selected: seleccionado,
                    selectedColor: AppColors.taupeGrey,
                    labelStyle: TextStyle(
                      color: seleccionado ? Colors.white : AppColors.textDark,
                      fontWeight: FontWeight.w600,
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: AppColors.coolSteel.withOpacity(0.5)),
                    ),
                    onSelected: (_) => setState(() => _porcentajeSeleccionado = p),
                  );
                }).toList(),
              ),
              const SizedBox(height: 22),
              ElevatedButton(onPressed: _calcular, child: const Text('Calcular propina')),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: _reiniciar,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.taupeGrey,
                  side: const BorderSide(color: AppColors.taupeGrey),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('Reiniciar calculadora'),
              ),
              const SizedBox(height: 24),
              if (_error != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red.shade700),
                      const SizedBox(width: 10),
                      Expanded(child: Text(_error!, style: TextStyle(color: Colors.red.shade700))),
                    ],
                  ),
                ),
              if (_propina != null && _total != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.paleSlate.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.paleSlate),
                  ),
                  child: Column(
                    children: [
                      _buildResultRow('Propina', _propina!),
                      const Divider(height: 24),
                      _buildResultRow('Total a pagar', _total!, destacado: true),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, double valor, {bool destacado = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: destacado ? 18 : 15,
            fontWeight: destacado ? FontWeight.bold : FontWeight.w500,
            color: AppColors.textDark,
          ),
        ),
        Text(
          'RD\$${valor.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: destacado ? 20 : 16,
            fontWeight: FontWeight.bold,
            color: AppColors.taupeGrey,
          ),
        ),
      ],
    );
  }
}
