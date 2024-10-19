// ignore_for_file: file_names

import 'dart:math';

/// Genera un código aleatorio de 6 dígitos.
///
/// Utiliza la clase [Random] para generar números aleatorios,
/// y luego los convierte a strings para concatenarlos en un código.
///
/// Retorna el código generado.
String generateRandomCode() {
  // Instancia de la clase Random para generar números aleatorios.
  final random = Random();

  // Cadena donde se almacenará el código generado.
  String code = '';

  // Genera un código de 6 dígitos.
  for (int i = 0; i < 6; i++) {
    // Genera un número aleatorio entre 0 y 9,
    // lo convierte a string y lo agrega al código.
    code += random.nextInt(10).toString();
  }

  // Retorna el código generado.
  return code;
}
