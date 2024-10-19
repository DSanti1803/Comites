// ignore_for_file: use_full_hex_values_for_flutter_colors, file_names
// Ignora las advertencias sobre el uso completo de valores hexadecimales y nombres de archivos.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Definición de colores constantes utilizados en el tema de la aplicación.
// Color principal de la aplicación.
const primaryColor = Color(0xFF4CAF50);
// Color de fondo personalizado.
const background1 = Color(0xFFFF2F0F2);
// Color claro para botones.
const botonClaro = Color(0xFF00FF00);
// Color oscuro para botones.
const botonOscuro = Color(0xFF008000);
// Color de sombra para botones.
const botonSombra = Color(0xFF32CD32);
// Color secundario de la aplicación.
const secondaryColor = Color(0xFF000000);
// Valor de padding por defecto.
const defaultPadding = 16.0;

const textosClaros = Color(0xffffffff);

const textosOscuros = Color(0xfff0c1609);

// Definición del tema de la aplicación claro.
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light, // Establece el tema como claro.
  primaryColor: primaryColor, // Establece el color principal.
  canvasColor: secondaryColor, // Establece el color del lienzo.
  // Ignorar el uso de miembros obsoletos, ya que se ha migrado a un nuevo enfoque.
  // ignore: deprecated_member_use
  scaffoldBackgroundColor: Colors.white, // Color de fondo para Scaffold.
  // Definición del tema para el cajón de navegación.
  drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xFFFF2F0F2)), // Tema para el Drawer.
  // Configuración del tema de texto utilizando Google Fonts con el color principal.
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontFamily: 'Calibri',
        fontWeight: FontWeight.normal,
        color: primaryColor), // Estilo de texto grande.
    displayMedium: TextStyle(
        fontFamily: 'Calibri',
        fontWeight: FontWeight.normal,
        color: primaryColor), // Estilo de texto mediano.
    displaySmall: TextStyle(
        fontFamily: 'Calibri',
        fontWeight: FontWeight.normal,
        color: primaryColor), // Estilo de texto pequeño.
    headlineLarge: TextStyle(
        fontFamily: 'Calibri-Bold',
        fontWeight: FontWeight.bold,
        color: primaryColor), // Estilo de encabezado grande.
    headlineMedium: TextStyle(
        fontFamily: 'Calibri-Bold',
        fontWeight: FontWeight.bold,
        color: primaryColor), // Estilo de encabezado mediano.
    headlineSmall: TextStyle(
        fontFamily: 'Calibri-Bold',
        fontWeight: FontWeight.bold,
        color: primaryColor), // Estilo de encabezado pequeño.
    titleLarge: TextStyle(
        fontFamily: 'Calibri',
        fontWeight: FontWeight.normal,
        color: primaryColor), // Estilo de título grande.
    titleMedium: TextStyle(
        fontFamily: 'Calibri',
        fontWeight: FontWeight.normal,
        color: primaryColor), // Estilo de título mediano.
    titleSmall: TextStyle(
        fontFamily: 'Calibri-Italic',
        fontStyle: FontStyle.italic,
        color: Colors.grey), // Estilo de título pequeño e itálico.
    bodyLarge: TextStyle(
        fontFamily: 'Calibri',
        fontWeight: FontWeight.normal,
        color: primaryColor), // Estilo de cuerpo de texto grande.
    bodyMedium: TextStyle(
        fontFamily: 'Calibri',
        fontWeight: FontWeight.normal,
        color: primaryColor), // Estilo de cuerpo de texto mediano.
    bodySmall: TextStyle(
        fontFamily: 'Calibri',
        fontWeight: FontWeight.normal,
        color: primaryColor), // Estilo de cuerpo de texto pequeño.
    labelLarge: TextStyle(
        fontFamily: 'Calibri',
        fontWeight: FontWeight.normal,
        color: primaryColor), // Estilo de etiqueta grande.
    labelMedium: TextStyle(
        fontFamily: 'Calibri',
        fontWeight: FontWeight.normal,
        color: primaryColor), // Estilo de etiqueta mediana.
    labelSmall: TextStyle(
        fontFamily: 'Calibri-Light',
        fontWeight: FontWeight.w300,
        color: primaryColor), // Estilo de etiqueta pequeña y ligera.
  ),
  // Configuración del tema de botón elevado con el color principal.
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          WidgetStatePropertyAll(primaryColor), // Color de fondo del botón.
      foregroundColor:
          WidgetStatePropertyAll(Colors.white), // Color del texto del botón.
    ),
  ),
  // Configuración del tema del checkbox con el color principal.
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return primaryColor; // Color de fondo cuando está seleccionado.
      }
      return Colors.transparent; // Color de fondo cuando no está seleccionado.
    }),
  ),
  // Configuración del tema del botón flotante de acción con colores específicos.
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFFF2F0F2),
      foregroundColor: primaryColor), // Colores del FAB.
  progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryColor), // Color del indicador de progreso.
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: primaryColor, // Color del cursor de texto.
  ),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: primaryColor), // Color del borde cuando no está enfocado.
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: primaryColor), // Color del borde cuando está enfocado.
    ),
  ),
);

/// Formato para los números con configuración regional específica.
/// Usa el formato de moneda para el idioma español de Colombia y elimina el símbolo,
/// establece 2 dígitos decimales.
final formatter = NumberFormat.currency(
  locale: 'es_CO',
  symbol: '',
  decimalDigits: 2,
);

/// Asegura que los números tengan al menos dos dígitos.
String twoDigits(int n) => n.toString().padLeft(2, '0');

/// Formatea las fechas y horas, asegurando un formato consistente.
/// Si la fecha y hora no es válida, devuelve 'Fecha inválida'.
String formatFechaHora(String fechaString) {
  try {
    DateTime fecha =
        DateTime.parse(fechaString); // Parsea la fecha desde una cadena.
    return '${twoDigits(fecha.day)}-${twoDigits(fecha.month)}-${fecha.year} ${twoDigits(fecha.hour)}:${twoDigits(fecha.minute)}';
  } catch (e) {
    return '';
  }
}
