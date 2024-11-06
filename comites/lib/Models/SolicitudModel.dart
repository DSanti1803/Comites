// ignore_for_file: file_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../source.dart';

final fechaActual = DateTime.now();

// Formatea la fecha y hora en un solo String
final fechaYHora =
    '${fechaActual.toIso8601String().split('T')[0]} ${fechaActual.hour.toString().padLeft(2, '0')}:${fechaActual.minute.toString().padLeft(2, '0')}';

/// Lista que almacena las solicitudes obtenidas de la API.
List<SolicitudModel> solicitud = [];

/// Clase que representa una solicitud en la aplicación.
class SolicitudModel {
  final int id;
  List<dynamic> aprendiz; // Asumiendo que es una lista de IDs
  final DateTime fechasolicitud;
  final String descripcion;
  final String observaciones;
  List<dynamic> responsable; // Asumiendo que es una lista de IDs
  List<dynamic> reglamento; // Asumiendo que es una lista de IDs
  final bool solicitudenviada;
  bool citacionenviada;
  bool comiteenviado;
  bool planmejoramiento;
  bool desicoordinador;
  bool desiabogada;
  bool finalizado;

  SolicitudModel({
    required this.id,
    required this.aprendiz,
    required this.fechasolicitud,
    required this.descripcion,
    required this.observaciones,
    required this.responsable,
    required this.reglamento,
    required this.solicitudenviada,
    required this.citacionenviada,
    required this.comiteenviado,
    required this.planmejoramiento,
    required this.desicoordinador,
    required this.desiabogada,
    required this.finalizado,
  });

  factory SolicitudModel.fromJson(Map<String, dynamic> json) {
    return SolicitudModel(
      id: json['id'],
      aprendiz: json['aprendiz'] ?? [],
      fechasolicitud: DateTime.parse(json['fechasolicitud']),
      descripcion: json['descripcion'],
      observaciones: json['observaciones'],
      responsable: json['responsable'] ?? [],
      reglamento: json['reglamento'] ?? [],
      solicitudenviada: json['solicitudenviada'] ?? true,
      citacionenviada: json['citacionenviada'] ?? false,
      comiteenviado: json['comiteenviado'] ?? false,
      planmejoramiento: json['planmejoramiento'] ?? false,
      desicoordinador: json['desicoordinador'] ?? false,
      desiabogada: json['desiabogada'] ?? false,
      finalizado: json['finalizado'] ?? false,
    );
  }
}

Future<List<SolicitudModel>> getSolicitudesByUser(int userId) async {
  // URL para obtener todas las solicitudes
  final url = Uri.parse('http://127.0.0.1:8000/api/Solicitud/');

  // Realizar la solicitud GET a la URL para obtener las solicitudes
  final response = await http.get(url);

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Decodificar la respuesta en UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    final List<dynamic> data = json.decode(responseBodyUtf8);

    // Mapear las solicitudes y filtrar donde el usuario sea aprendiz o responsable
    return data
        .map((json) => SolicitudModel.fromJson(json))
        .where((solicitud) => solicitud.responsable.contains(userId))
        .toList();
  } else {
    throw Exception('Error al cargar las solicitudes');
  }
}

/// Método para obtener los datos de las solicitudes desde la API.
Future<List<SolicitudModel>> getSolicitud() async {
  // URL para obtener las solicitudes de la API
  String url = "$sourceApi/api/Solicitud/";

  // Realizar una solicitud GET a la URL para obtener las solicitudes
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    solicitud.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista de solicitudes con datos
    for (var solicitudData in decodedData) {
      solicitud.add(
        SolicitudModel.fromJson(solicitudData),
      );
    }
    // Devolver la lista de solicitudes
    return solicitud;
  } else {
    // Si el código de estado no es 200, se lanza una excepción
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
