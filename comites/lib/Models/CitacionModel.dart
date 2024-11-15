// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../source.dart';

/// Lista que almacena las citaciones obtenidas de la API.
List<CitacionModel> citaciones = [];

/// Clase que representa una citación en la aplicación.
class CitacionModel {
  final int id;
  final int solicitud; // Usamos el ID de la solicitud
  final DateTime diacitacion;
  final String horainicio;
  final String horafin;
  final String lugarcitacion;
  final String enlacecitacion;
  final bool actarealizada;

  CitacionModel(
      {required this.id,
      required this.solicitud,
      required this.diacitacion,
      required this.horainicio,
      required this.horafin,
      required this.lugarcitacion,
      required this.enlacecitacion,
      required this.actarealizada});

  factory CitacionModel.fromJson(Map<String, dynamic> json) {
    return CitacionModel(
      id: json['id'],
      solicitud: json['solicitud'],
      diacitacion: DateTime.parse(json['diacitacion']),
      horainicio: json['horacitacion'],
      horafin: json['horacitacion'], // Almacenar como String
      lugarcitacion: json['lugarcitacion'],
      enlacecitacion: json['enlacecitacion'],
      actarealizada: json['actarealizada'],
    );
  }
}

/// Método para obtener los datos de las citaciones desde la API.
Future<List<CitacionModel>> getCitacion() async {
  // URL para obtener las citaciones de la API
  String url = "$sourceApi/api/Citacion/";

  // Realizar una solicitud GET a la URL para obtener las citaciones
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    citaciones.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista de citaciones con datos
    for (var citacionData in decodedData) {
      citaciones.add(
        CitacionModel.fromJson(citacionData),
      );
    }
    // Devolver la lista de citaciones
    return citaciones;
  } else {
    // Si el código de estado no es 200, se lanza una excepción
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}