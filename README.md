# Mis Ejercicios Flutter

Aplicación educativa con 10 ejercicios prácticos de Flutter, accesibles desde un menú principal.

## 1. Cómo ejecutar el proyecto

1. Asegúrate de tener Flutter instalado (`flutter --version`).
2. Crea un proyecto nuevo o usa esta carpeta directamente:
   ```bash
   flutter create ejercicios_flutter
   ```
3. Reemplaza el contenido de la carpeta `lib/` generada por el `lib/` de este paquete
   (y reemplaza también `pubspec.yaml` si quieres usar el mismo nombre de proyecto).
4. Instala las dependencias:
   ```bash
   flutter pub get
   ```
5. Ejecuta la app en un emulador o dispositivo conectado:
   ```bash
   flutter run
   ```

No se requieren paquetes externos adicionales: solo Flutter y Dart estándar
(`cupertino_icons` viene incluido por defecto en cualquier proyecto nuevo).

## 2. Estructura del proyecto

```
lib/
├── main.dart
├── theme/
│   └── app_colors.dart
├── models/
│   ├── producto.dart
│   └── tarea.dart
├── screens/
│   ├── home_screen.dart
│   ├── presentacion_screen.dart      (Ejercicio 1)
│   ├── contador_screen.dart          (Ejercicio 2)
│   ├── edad_screen.dart              (Ejercicio 3)
│   ├── propinas_screen.dart          (Ejercicio 4)
│   ├── temperatura_screen.dart       (Ejercicio 5)
│   ├── semaforo_screen.dart          (Ejercicio 6)
│   ├── estudiante_screen.dart        (Ejercicio 7)
│   ├── compras_screen.dart           (Ejercicio 8)
│   ├── catalogo_screen.dart          (Ejercicio 9)
│   ├── catalogo_detalle_screen.dart  (Ejercicio 9 - detalle)
│   ├── tareas_screen.dart            (Ejercicio 10)
│   └── tarea_form_screen.dart        (Ejercicio 10 - formulario)
└── widgets/
    └── exercise_card.dart
```

## 3. Dónde modificar los colores

Todos los colores de la app están centralizados en:

```
lib/theme/app_colors.dart
```

Ahí encontrarás las 5 constantes de la paleta actual:

| Constante    | Hex       | Uso principal                          |
|--------------|-----------|-----------------------------------------|
| `softBlush`  | `#FFDBDA` | Fondo principal                         |
| `oldRose`    | `#DB7F8E` | Botones, tarjetas y acentos             |
| `paleSlate`  | `#D5C5C8` | Tarjetas especiales / acentos           |
| `coolSteel`  | `#9DA3A4` | Botones y tarjetas                      |
| `taupeGrey`  | `#604D53` | AppBar, títulos y elementos principales |

Cambia esos valores hexadecimales y el cambio se reflejará en toda la aplicación
automáticamente, ya que el resto de las pantallas importan y usan `AppColors` en
lugar de colores sueltos.

También existe `AppColors.contrastText(color)`, un helper que calcula si el texto
sobre un color de fondo debe ser claro u oscuro según su brillo. Se usa en las
tarjetas del menú y en los recuadros de resumen para que el texto siga siendo
legible sin importar qué tan clara u oscura sea la variante de paleta que elijas.

El tema general (AppBar, botones, campos de texto) se configura en `lib/main.dart`
dentro del `ThemeData`, también usando `AppColors`.

## 4. Notas de implementación

- Cada ejercicio es una pantalla independiente con su propio `AppBar` y botón de regreso.
- La navegación usa `Navigator.push` / `Navigator.pop` en todos los casos.
- El menú principal (`home_screen.dart`) usa `GridView.builder` con columnas
  responsivas según el ancho de pantalla (`LayoutBuilder`).
- El Ejercicio 9 usa `Image.network` con `errorBuilder`, por lo que la app sigue
  funcionando aunque no haya conexión a internet o una imagen falle al cargar.
- Ningún ejercicio usa Firebase, bases de datos ni paquetes externos: todo el estado
  vive en memoria mientras la app está abierta (con `StatefulWidget` / `setState`).
