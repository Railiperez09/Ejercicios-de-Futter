import 'package:flutter/material.dart';

/// Paleta de colores oficial de la aplicacion.
/// Para cambiar los colores de toda la app, modifica los valores aqui.
class AppColors {
  AppColors._();

  static const Color softBlush = Color(0xFFFFDBDA); // Fondo principal
  static const Color oldRose = Color(0xFFDB7F8E); // Botones, tarjetas y acentos
  static const Color paleSlate = Color(0xFFD5C5C8); // Tarjetas especiales / acentos
  static const Color coolSteel = Color(0xFF9DA3A4); // Botones y tarjetas
  static const Color taupeGrey = Color(0xFF604D53); // AppBar, titulos y elementos principales

  static const Color textDark = Color(0xFF3A2C30);
  static const Color textLight = Colors.white;

  /// Devuelve el color de texto (claro u oscuro) con mejor contraste
  /// sobre el color de fondo dado. Como esta paleta mezcla tonos pastel
  /// muy claros (softBlush, paleSlate) con tonos oscuros (taupeGrey),
  /// el texto no puede asumirse siempre blanco: se calcula segun el
  /// brillo percibido del color de fondo.
  static Color contrastText(Color background) {
    final double luminance =
        (0.299 * background.red + 0.587 * background.green + 0.114 * background.blue) / 255;
    return luminance > 0.6 ? textDark : Colors.white;
  }
}
