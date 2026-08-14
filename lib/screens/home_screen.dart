import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/exercise_card.dart';
import 'presentacion_screen.dart';
import 'contador_screen.dart';
import 'edad_screen.dart';
import 'propinas_screen.dart';
import 'temperatura_screen.dart';
import 'semaforo_screen.dart';
import 'estudiante_screen.dart';
import 'compras_screen.dart';
import 'catalogo_screen.dart';
import 'tareas_screen.dart';

class _Ejercicio {
  final int numero;
  final String titulo;
  final String descripcion;
  final IconData icono;
  final Color color;
  final WidgetBuilder builder;

  const _Ejercicio({
    required this.numero,
    required this.titulo,
    required this.descripcion,
    required this.icono,
    required this.color,
    required this.builder,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<_Ejercicio> get _ejercicios => [
        _Ejercicio(
          numero: 1,
          titulo: 'Tarjeta de presentacion',
          descripcion: 'Perfil personal con datos de contacto',
          icono: Icons.badge_outlined,
          color: AppColors.oldRose,
          builder: (_) => const PresentacionScreen(),
        ),
        _Ejercicio(
          numero: 2,
          titulo: 'Contador de personas',
          descripcion: 'Control de aforo con limite',
          icono: Icons.groups_outlined,
          color: AppColors.coolSteel,
          builder: (_) => const ContadorScreen(),
        ),
        _Ejercicio(
          numero: 3,
          titulo: 'Calculadora de edad',
          descripcion: 'Calcula la edad aproximada',
          icono: Icons.cake_outlined,
          color: AppColors.taupeGrey,
          builder: (_) => const EdadScreen(),
        ),
        _Ejercicio(
          numero: 4,
          titulo: 'Calculadora de propinas',
          descripcion: 'Calcula propina y total a pagar',
          icono: Icons.attach_money,
          color: AppColors.paleSlate,
          builder: (_) => const PropinasScreen(),
        ),
        _Ejercicio(
          numero: 5,
          titulo: 'Conversor de temperatura',
          descripcion: 'Convierte grados C a F y viceversa',
          icono: Icons.thermostat_outlined,
          color: AppColors.oldRose,
          builder: (_) => const TemperaturaScreen(),
        ),
        _Ejercicio(
          numero: 6,
          titulo: 'Semaforo interactivo',
          descripcion: 'Simulacion de luces de transito',
          icono: Icons.traffic_outlined,
          color: AppColors.coolSteel,
          builder: (_) => const SemaforoScreen(),
        ),
        _Ejercicio(
          numero: 7,
          titulo: 'Registro de estudiante',
          descripcion: 'Formulario completo con validaciones',
          icono: Icons.school_outlined,
          color: AppColors.taupeGrey,
          builder: (_) => const EstudianteScreen(),
        ),
        _Ejercicio(
          numero: 8,
          titulo: 'Lista de compras',
          descripcion: 'Administra productos por comprar',
          icono: Icons.shopping_cart_outlined,
          color: AppColors.paleSlate,
          builder: (_) => const ComprasScreen(),
        ),
        _Ejercicio(
          numero: 9,
          titulo: 'Catalogo de productos',
          descripcion: 'Explora productos con detalles',
          icono: Icons.storefront_outlined,
          color: AppColors.oldRose,
          builder: (_) => const CatalogoScreen(),
        ),
        _Ejercicio(
          numero: 10,
          titulo: 'Tareas pendientes',
          descripcion: 'Organiza tareas por prioridad',
          icono: Icons.checklist_outlined,
          color: AppColors.coolSteel,
          builder: (_) => const TareasScreen(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final int columnas = constraints.maxWidth > 700
                        ? 4
                        : constraints.maxWidth > 480
                            ? 3
                            : 2;
                    return GridView.builder(
                      itemCount: _ejercicios.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columnas,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 0.82,
                      ),
                      itemBuilder: (context, index) {
                        final ejercicio = _ejercicios[index];
                        return ExerciseCard(
                          numero: ejercicio.numero,
                          titulo: ejercicio.titulo,
                          descripcion: ejercicio.descripcion,
                          icono: ejercicio.icono,
                          color: ejercicio.color,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: ejercicio.builder),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 26),
      decoration: const BoxDecoration(
        color: AppColors.taupeGrey,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Mis Ejercicios Flutter',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Practicas de desarrollo movil',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
