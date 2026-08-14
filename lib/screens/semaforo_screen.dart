import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum _Luz { rojo, amarillo, verde }

class SemaforoScreen extends StatefulWidget {
  const SemaforoScreen({super.key});

  @override
  State<SemaforoScreen> createState() => _SemaforoScreenState();
}

class _SemaforoScreenState extends State<SemaforoScreen> {
  _Luz _luzActual = _Luz.rojo;

  void _cambiarLuz() {
    setState(() {
      switch (_luzActual) {
        case _Luz.rojo:
          _luzActual = _Luz.verde;
          break;
        case _Luz.verde:
          _luzActual = _Luz.amarillo;
          break;
        case _Luz.amarillo:
          _luzActual = _Luz.rojo;
          break;
      }
    });
  }

  String get _mensaje {
    switch (_luzActual) {
      case _Luz.rojo:
        return 'Detengase';
      case _Luz.amarillo:
        return 'Preparese';
      case _Luz.verde:
        return 'Puede avanzar';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semaforo interactivo'),
        actions: const [Padding(padding: EdgeInsets.only(right: 16), child: Icon(Icons.traffic_outlined))],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2B2B2B),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 16, offset: const Offset(0, 8)),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildLuz(Colors.red, _luzActual == _Luz.rojo),
                      const SizedBox(height: 18),
                      _buildLuz(Colors.amber, _luzActual == _Luz.amarillo),
                      const SizedBox(height: 18),
                      _buildLuz(Colors.green, _luzActual == _Luz.verde),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  _mensaje,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: _cambiarLuz,
                  icon: const Icon(Icons.autorenew),
                  label: const Text('Cambiar luz'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLuz(Color color, bool activa) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: activa ? color : color.withOpacity(0.2),
        boxShadow: activa
            ? [BoxShadow(color: color.withOpacity(0.7), blurRadius: 24, spreadRadius: 2)]
            : [],
      ),
    );
  }
}
