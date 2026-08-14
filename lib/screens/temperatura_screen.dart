import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum _TipoConversion { celsiusAFahrenheit, fahrenheitACelsius }

class TemperaturaScreen extends StatefulWidget {
  const TemperaturaScreen({super.key});

  @override
  State<TemperaturaScreen> createState() => _TemperaturaScreenState();
}

class _TemperaturaScreenState extends State<TemperaturaScreen> {
  final TextEditingController _valorController = TextEditingController();
  _TipoConversion _tipo = _TipoConversion.celsiusAFahrenheit;
  String? _resultado;
  String? _error;

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  void _convertir() {
    final String texto = _valorController.text.trim();
    final double? valor = double.tryParse(texto);

    setState(() {
      _resultado = null;
      _error = null;

      if (texto.isEmpty || valor == null) {
        _error = 'Introduzca un valor numerico valido.';
        return;
      }

      if (_tipo == _TipoConversion.celsiusAFahrenheit) {
        final double fahrenheit = (valor * 9 / 5) + 32;
        _resultado = '${fahrenheit.toStringAsFixed(2)} °F';
      } else {
        final double celsius = (valor - 32) * 5 / 9;
        _resultado = '${celsius.toStringAsFixed(2)} °C';
      }
    });
  }

  void _cambiarTipo(_TipoConversion? nuevoTipo) {
    if (nuevoTipo == null) return;
    setState(() {
      _tipo = nuevoTipo;
      _resultado = null;
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversor de temperatura')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _valorController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                decoration: const InputDecoration(
                  labelText: 'Temperatura',
                  prefixIcon: Icon(Icons.thermostat_outlined),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                child: Column(
                  children: [
                    RadioListTile<_TipoConversion>(
                      title: const Text('Celsius → Fahrenheit'),
                      value: _TipoConversion.celsiusAFahrenheit,
                      groupValue: _tipo,
                      activeColor: AppColors.taupeGrey,
                      onChanged: _cambiarTipo,
                    ),
                    RadioListTile<_TipoConversion>(
                      title: const Text('Fahrenheit → Celsius'),
                      value: _TipoConversion.fahrenheitACelsius,
                      groupValue: _tipo,
                      activeColor: AppColors.taupeGrey,
                      onChanged: _cambiarTipo,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              ElevatedButton(onPressed: _convertir, child: const Text('Convertir')),
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
              if (_resultado != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.oldRose.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.oldRose),
                  ),
                  child: Text(
                    _resultado!,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.taupeGrey),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
