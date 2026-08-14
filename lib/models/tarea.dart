enum Prioridad { baja, media, alta }

extension PrioridadExtension on Prioridad {
  String get etiqueta {
    switch (this) {
      case Prioridad.baja:
        return 'Baja';
      case Prioridad.media:
        return 'Media';
      case Prioridad.alta:
        return 'Alta';
    }
  }
}

class Tarea {
  String titulo;
  String descripcion;
  DateTime fechaLimite;
  Prioridad prioridad;
  bool completada;

  Tarea({
    required this.titulo,
    required this.descripcion,
    required this.fechaLimite,
    required this.prioridad,
    this.completada = false,
  });
}
