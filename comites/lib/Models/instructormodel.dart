import 'dart:convert';
import 'package:http/http.dart' as http;
import '../source.dart';

class InstructorModel {
  final int id;
  final String nombres;
  final String apellidos;
  final String tipoDocumento;
  final String numeroDocumento;
  final String correoElectronico;
  final String rol1;
  final String coordinacion;
  final bool estado;

  InstructorModel({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.tipoDocumento,
    required this.numeroDocumento,
    required this.correoElectronico,
    required this.rol1,
    required this.coordinacion,
    required this.estado,
  });

  factory InstructorModel.fromJson(Map<String, dynamic> json) {
    return InstructorModel(
      id: json['id'] ?? 0,
      nombres: json['nombres'] ?? "",
      apellidos: json['apellidos'] ?? "",
      tipoDocumento: json['tipoDocumento'] ?? "",
      numeroDocumento: json['numeroDocumento'] ?? "",
      correoElectronico: json['correoElectronico'] ?? "",
      rol1: json['rol1'] ?? "",
      coordinacion: json['coordinacion'],
      estado: json['estado'] ?? true,
    );
  }
}

List<InstructorModel> instructor = [];

// Método para obtener los datos de los usuarios
Future<List<InstructorModel>> getIntructor() async {
  /// URL para obtener los datos de los usuarios de la API.
  ///
  /// Esta URL se utiliza para realizar una solicitud GET a la API y obtener los datos de los usuarios.
  String url = "";

  // Construir la URL de la API utilizando la variable de configuración [sourceApi]
  url = "$sourceApi/api/Instructor/";

  // Realizar una solicitud GET a la URL para obtener los datos de los usuarios
  // El método [http.get] devuelve una promesa que se resuelve en una instancia de la clase [http.Response].
  // La respuesta de la solicitud se almacena en la variable [response].
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    instructor.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista con los datos decodificados
    for (var instructordata in decodedData) {
      instructor.add(
        InstructorModel(
          id: instructordata['id'] ?? 0,
          nombres: instructordata['nombres'] ?? "",
          apellidos: instructordata['apellidos'] ?? "",
          tipoDocumento: instructordata['tipoDocumento'] ?? "",
          numeroDocumento: instructordata['numeroDocumento'] ?? "",
          correoElectronico: instructordata['correoElectronico'] ?? "",
          rol1: instructordata['rol1'] ?? "",
          coordinacion: instructordata['coordinacion'] ?? "",
          estado: instructordata['estado'] ?? true,
        ),
      );
    }

    // Devolver la lista de usuarios
    return instructor;
  } else {
    // Si la respuesta no fue exitosa, se lanza una excepción
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
