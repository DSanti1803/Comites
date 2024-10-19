
// ignore_for_file: file_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../source.dart';

class UsuarioAprendizModel {
  final int id;
  final String nombres;
  final String apellidos;
  final String tipoDocumento;
  final String numeroDocumento;
  final String ficha;
  final String programa;
  final String correoElectronico;
  final String rol1;
  final bool estado;
  final String coordinacion;
  UsuarioAprendizModel({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.tipoDocumento,
    required this.numeroDocumento,
    required this.ficha,
    required this.programa,
    required this.correoElectronico,
    required this.rol1,
    required this.estado,
    required this.coordinacion,
  });
  factory UsuarioAprendizModel.fromJson(Map<String, dynamic> json) {
    return UsuarioAprendizModel(
      id: json['id'] ?? 0,
      nombres: json['nombres'] ?? "",
      apellidos: json['apellidos'] ?? "",
      tipoDocumento: json['tipoDocumento'] ?? "",
      numeroDocumento: json['numeroDocumento'] ?? "",
      ficha: json['ficha'] ?? "",
      programa: json['programa'] ?? "",
      correoElectronico: json['correoElectronico'] ?? "",
      rol1: json['rol1'] ?? "",
      estado: json['estado'] ?? true,
      coordinacion: json['coordinacion'] ?? "",

    );
  }
}

List<UsuarioAprendizModel> aprendices = [];

// Método para obtener los datos de los usuarios
Future<List<UsuarioAprendizModel>> getAprendiz() async {
  /// URL para obtener los datos de los usuarios de la API.
  ///
  /// Esta URL se utiliza para realizar una solicitud GET a la API y obtener los datos de los usuarios.
  String url = "";


  // Construir la URL de la API utilizando la variable de configuración [sourceApi]
  url = "$sourceApi/api/UsuarioAprendiz/";

  // Realizar una solicitud GET a la URL para obtener los datos de los usuarios
  // El método [http.get] devuelve una promesa que se resuelve en una instancia de la clase [http.Response].
  // La respuesta de la solicitud se almacena en la variable [response].
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    aprendices.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista con los datos decodificados
    for (var aprendizdata in decodedData) {
      aprendices.add(
        UsuarioAprendizModel(
          id: aprendizdata['id'] ?? 0,
          nombres: aprendizdata['nombres'] ?? "",
          apellidos: aprendizdata['apellidos'] ?? "",
          tipoDocumento: aprendizdata['tipoDocumento'] ?? "",
          numeroDocumento: aprendizdata['numeroDocumento'] ?? "",
          ficha: aprendizdata['ficha'] ?? "",
          programa: aprendizdata['programa'] ?? "",
          correoElectronico: aprendizdata['correoElectronico'] ?? "",
          rol1: aprendizdata['rol1'] ?? "",
          estado: aprendizdata['estado'] ?? true,
          coordinacion: aprendizdata['coordinacion'] ?? "",

        ),
      );
    }

    // Devolver la lista de usuarios
    return aprendices;
  } else {
    // Si la respuesta no fue exitosa, se lanza una excepción
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}