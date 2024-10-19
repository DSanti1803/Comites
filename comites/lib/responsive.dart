// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

// Esta clase `Responsive` extiende StatelessWidget y se usa para adaptar la UI según el tamaño de la pantalla.
class Responsive extends StatelessWidget {
  // Widgets para diferentes tamaños de pantalla
  final Widget mobile; // Widget para dispositivos móviles
  final Widget? tablet; // Widget opcional para tablets
  final Widget desktop; // Widget para dispositivos de escritorio

  // Constructor para inicializar los widgets correspondientes
  const Responsive({
    super.key, // Clave opcional para identificar el widget
    required this.mobile, // Widget móvil es obligatorio
    this.tablet, // Widget tablet es opcional
    required this.desktop, // Widget de escritorio es obligatorio
  });

  // Método estático para verificar si el dispositivo es móvil
  /// Verifica si el ancho de la pantalla es menor a 700 pixeles.
  ///
  /// Devuelve un booleano indicando si es móvil.
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 700;

  // Método estático para verificar si el dispositivo es una tablet
  /// Verifica si el ancho de la pantalla es mayor a 700 pixeles y menor a 1100 pixeles.
  ///
  /// Devuelve un booleano indicando si es una tablet.
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 700;

  // Método estático para verificar si el dispositivo es de escritorio
  /// Verifica si el ancho de la pantalla es mayor o igual a 1100 pixeles.
  ///
  /// Devuelve un booleano indicando si es de escritorio.
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    // Obtiene el tamaño de la pantalla
    final Size _size = MediaQuery.of(context).size;

    // Devuelve el widget de escritorio si el ancho es mayor o igual a 1100
    if (_size.width >= 1100) {
      return desktop;
    }
    // Devuelve el widget de tablet si el ancho es mayor o igual a 850 y tablet no es nulo
    else if (_size.width >= 850 && tablet != null) {
      return tablet!;
    }
    // Devuelve el widget móvil en otros casos
    else {
      return mobile;
    }
  }
}
