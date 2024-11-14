// ignore_for_file: file_names, constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../source.dart';

List<ActaModel> actas = [];

/// Enum para la clasificación de la información del acta.
enum Clasificacion { PUBLICA, PRIVADO, SEMIPRIVADO, SENSIBLE }

/// Clase que representa un acta en la aplicación.
class ActaModel {
  final int id;
  final int citacion;
  final String verificacionquorom;
  final String verificacionasistenciaaprendiz;
  final String verificacionbeneficio;
  final String reporte;
  final String descargos;
  final String pruebas;
  final String deliberacion;
  final String votos;
  final String conclusiones;
  final Clasificacion clasificacioninformacion;

  // Constructor
  ActaModel({
    required this.id,
    required this.citacion,
    required this.verificacionquorom,
    required this.verificacionasistenciaaprendiz,
    required this.verificacionbeneficio,
    required this.reporte,
    required this.descargos,
    required this.pruebas,
    required this.deliberacion,
    required this.votos,
    required this.conclusiones,
    required this.clasificacioninformacion,
  });

  // Método toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'citacion': {
        'id': citacion
      }, // Aquí, citacion es un objeto con la clave 'id'
      'verificacionquorom': verificacionquorom,
      'verificacionasistenciaaprendiz': verificacionasistenciaaprendiz,
      'verificacionbeneficio': verificacionbeneficio,
      'reporte': reporte,
      'descargos': descargos,
      'pruebas': pruebas,
      'deliberacion': deliberacion,
      'votos': votos,
      'conclusiones': conclusiones,
      'clasificacioninformacion': clasificacioninformacion
          .toString()
          .split('.')
          .last, // Convertir el enum a String
    };
  }

  /// Método para convertir un JSON en una instancia de ActaModel.
  factory ActaModel.fromJson(Map<String, dynamic> json) {
    return ActaModel(
      id: json['id'],
      citacion: json['citacion'],
      verificacionquorom: json['verificacionquorom'],
      verificacionasistenciaaprendiz: json['verificacionasistenciaaprendiz'],
      verificacionbeneficio: json['verificacionbeneficio'],
      reporte: json['reporte'],
      descargos: json['descargos'],
      pruebas: json['pruebas'],
      deliberacion: json['deliberacion'],
      votos: json['votos'],
      conclusiones: json['conclusiones'],
      clasificacioninformacion:
          _mapClasificacion(json['lasificacioninformacion']),
    );
  }

  /// Método auxiliar para mapear el valor de clasificación de String a enum Clasificacion.
  static Clasificacion _mapClasificacion(String clasificacion) {
    switch (clasificacion.toUpperCase()) {
      case 'PUBLICA':
        return Clasificacion.PUBLICA;
      case 'PRIVADO':
        return Clasificacion.PRIVADO;
      case 'SEMIPRIVADO':
        return Clasificacion.SEMIPRIVADO;
      case 'SENSIBLE':
        return Clasificacion.SENSIBLE;
      default:
        throw Exception('Clasificación desconocida: $clasificacion');
    }
  }
}

Future<List<ActaModel>> getActa() async {
  // URL para obtener las citaciones de la API
  String url = "$sourceApi/api/Acta/";

  // Realizar una solicitud GET a la URL para obtener las citaciones
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    actas.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista de citaciones con datos
    for (var actaData in decodedData) {
      actas.add(
        ActaModel.fromJson(actaData),
      );
    }
    // Devolver la lista de citaciones
    return actas;
  } else {
    // Si el código de estado no es 200, se lanza una excepción
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
