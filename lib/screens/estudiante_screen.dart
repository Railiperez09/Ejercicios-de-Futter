import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum _Sexo { masculino, femenino }

class EstudianteScreen extends StatefulWidget {
  const EstudianteScreen({super.key});

  @override
  State<EstudianteScreen> createState() => _EstudianteScreenState();
}

class _EstudianteScreenState extends State<EstudianteScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();

  String? _carreraSeleccionada;
  _Sexo? _sexoSeleccionado;
  bool _aceptaTerminos = false;
  bool _intentoEnviar = false;

  final List<String> _carreras = const [
    'Ingenieria en Sistemas',
    'Ingenieria Civil',
    'Administracion de Empresas',
    'Medicina',
    'Derecho',
  ];

  @override
  void dispose() {
    _matriculaController.dispose();
    _nombreController.dispose();
    _correoController.dispose();
    _edadController.dispose();
    super.dispose();
  }

  void _limpiarFormulario() {
    setState(() {
      _matriculaController.clear();
      _nombreController.clear();
      _correoController.clear();
      _edadController.clear();
      _carreraSeleccionada = null;
      _sexoSeleccionado = null;
      _aceptaTerminos = false;
      _intentoEnviar = false;
    });
    _formKey.currentState?.reset();
  }

  void _registrar() {
    setState(() => _intentoEnviar = true);

    final bool formularioValido = _formKey.currentState?.validate() ?? false;

    if (!formularioValido || _sexoSeleccionado == null || !_aceptaTerminos) {
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Registro exitoso'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildResumenItem('Matricula', _matriculaController.text),
              _buildResumenItem('Nombre', _nombreController.text),
              _buildResumenItem('Correo', _correoController.text),
              _buildResumenItem('Carrera', _carreraSeleccionada ?? ''),
              _buildResumenItem('Edad', _edadController.text),
              _buildResumenItem(
                  'Sexo', _sexoSeleccionado == _Sexo.masculino ? 'Masculino' : 'Femenino'),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _limpiarFormulario();
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  Widget _buildResumenItem(String label, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: AppColors.textDark, fontSize: 14),
          children: [
            TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: valor),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de estudiante')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _matriculaController,
                  decoration: const InputDecoration(
                    labelText: 'Matricula',
                    prefixIcon: Icon(Icons.badge_outlined),
                  ),
                  validator: (valor) =>
                      (valor == null || valor.trim().isEmpty) ? 'La matricula es obligatoria.' : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre completo',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (valor) =>
                      (valor == null || valor.trim().isEmpty) ? 'El nombre es obligatorio.' : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _correoController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Correo electronico',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (valor) {
                    if (valor == null || valor.trim().isEmpty) {
                      return 'El correo es obligatorio.';
                    }
                    if (!valor.contains('@') || !valor.contains('.')) {
                      return 'Introduzca un correo valido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  value: _carreraSeleccionada,
                  decoration: const InputDecoration(
                    labelText: 'Carrera',
                    prefixIcon: Icon(Icons.school_outlined),
                  ),
                  items: _carreras
                      .map((carrera) => DropdownMenuItem(value: carrera, child: Text(carrera)))
                      .toList(),
                  onChanged: (valor) => setState(() => _carreraSeleccionada = valor),
                  validator: (valor) => valor == null ? 'Seleccione una carrera.' : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _edadController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Edad',
                    prefixIcon: Icon(Icons.numbers_outlined),
                  ),
                  validator: (valor) {
                    if (valor == null || valor.trim().isEmpty) {
                      return 'La edad es obligatoria.';
                    }
                    final int? edad = int.tryParse(valor);
                    if (edad == null || edad <= 0) {
                      return 'Introduzca una edad valida.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                const Text('Sexo', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
                RadioListTile<_Sexo>(
                  title: const Text('Masculino'),
                  value: _Sexo.masculino,
                  groupValue: _sexoSeleccionado,
                  activeColor: AppColors.taupeGrey,
                  onChanged: (valor) => setState(() => _sexoSeleccionado = valor),
                ),
                RadioListTile<_Sexo>(
                  title: const Text('Femenino'),
                  value: _Sexo.femenino,
                  groupValue: _sexoSeleccionado,
                  activeColor: AppColors.taupeGrey,
                  onChanged: (valor) => setState(() => _sexoSeleccionado = valor),
                ),
                if (_intentoEnviar && _sexoSeleccionado == null)
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text('Seleccione el sexo.', style: TextStyle(color: Colors.red, fontSize: 12)),
                  ),
                const SizedBox(height: 6),
                CheckboxListTile(
                  title: const Text('Acepto los terminos y condiciones'),
                  value: _aceptaTerminos,
                  activeColor: AppColors.taupeGrey,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (valor) => setState(() => _aceptaTerminos = valor ?? false),
                ),
                if (_intentoEnviar && !_aceptaTerminos)
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text('Debe aceptar los terminos.', style: TextStyle(color: Colors.red, fontSize: 12)),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: _registrar, child: const Text('Registrar')),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: _limpiarFormulario,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.taupeGrey,
                    side: const BorderSide(color: AppColors.taupeGrey),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Limpiar formulario'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
