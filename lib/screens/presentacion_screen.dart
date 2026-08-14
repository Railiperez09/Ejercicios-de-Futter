import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PresentacionScreen extends StatelessWidget {
  const PresentacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarjeta de presentacion')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.oldRose,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Railivi Michelle Perez Helleis',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Ingeniera en Software',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.taupeGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          _buildInfoRow(Icons.phone, 'Telefono', '+1 809 416 0556'),
                          const Divider(height: 24),
                          _buildInfoRow(Icons.email, 'Correo', '2023-0215@unad.edu.do'),
                          const Divider(height: 24),
                          _buildInfoRow(Icons.location_on, 'Ubicacion',
                              'Santo Domingo, Rep. Dominicana'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Card(
                    elevation: 2,
                    color: AppColors.oldRose.withOpacity(0.35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline, color: AppColors.taupeGrey),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Apasionada por la tecnologia movil y el diseno de interfaces. '
                              'Con mas de 3 anos de experiencia creando aplicaciones con Flutter, '
                              'disfruto resolver problemas y aprender cosas nuevas cada dia.',
                              style: TextStyle(
                                  fontSize: 14, color: AppColors.textDark, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.coolSteel.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.taupeGrey, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(
                value,
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.textDark),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
