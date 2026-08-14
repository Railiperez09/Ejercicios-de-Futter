import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ContadorScreen extends StatefulWidget {
  const ContadorScreen({super.key});

  @override
  State<ContadorScreen> createState() => _ContadorScreenState();
}

class _ContadorScreenState extends State<ContadorScreen> {
  int _contador = 0;
  static const int _capacidadMaxima = 20;

  void _agregar() {
    setState(() {
      if (_contador < _capacidadMaxima) {
        _contador++;
      }
    });
  }

  void _restar() {
    setState(() {
      if (_contador > 0) {
        _contador--;
      }
    });
  }

  Future<void> _confirmarReinicio() async {
    final bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Reiniciar contador'),
        content: const Text('¿Esta seguro de que desea reiniciar el contador a cero?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Reiniciar')),
        ],
      ),
    );

    if (confirmar == true) {
      setState(() => _contador = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool capacidadAlcanzada = _contador >= _capacidadMaxima;

    return Scaffold(
      appBar: AppBar(title: const Text('Contador de personas')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Personas dentro', style: TextStyle(fontSize: 18, color: AppColors.textDark)),
                const SizedBox(height: 10),
                Builder(builder: (context) {
                  final Color colorCirculo =
                      capacidadAlcanzada ? AppColors.taupeGrey : AppColors.oldRose;
                  return Container(
                    width: 200,
                    height: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorCirculo,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Text(
                      '$_contador',
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: AppColors.contrastText(colorCirculo),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 16),
                AnimatedOpacity(
                  opacity: capacidadAlcanzada ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: const Text(
                    'Capacidad alcanzada',
                    style: TextStyle(color: AppColors.taupeGrey, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: capacidadAlcanzada ? null : _agregar,
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.coolSteel),
                        icon: const Icon(Icons.add),
                        label: const Text('Agregar'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _contador == 0 ? null : _restar,
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.taupeGrey),
                        icon: const Icon(Icons.remove),
                        label: const Text('Restar'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _confirmarReinicio,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.taupeGrey,
                      side: const BorderSide(color: AppColors.taupeGrey),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reiniciar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
