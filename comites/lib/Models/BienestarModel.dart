// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../source.dart';

class BienestarModel {
  final int id;
  final String nombres;
  final String apellidos;
  final String tipoDocumento;
  final String numeroDocumento;
  final String correoElectronico;
  final String rol1;
  final bool estado;

  BienestarModel({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.tipoDocumento,
    required this.numeroDocumento,
    required this.correoElectronico,
    required this.rol1,
    required this.estado,
  });
}

List<BienestarModel> bienestar = [];

// Método para obtener los datos de los usuarios
Future<List<BienestarModel>> getBienestar() async {
  /// URL para obtener los datos de los usuarios de la API.
  ///
  /// Esta URL se utiliza para realizar una solicitud GET a la API y obtener los datos de los usuarios.
  String url = "";

  // Construir la URL de la API utilizando la variable de configuración [sourceApi]
  url = "$sourceApi/api/Bienestar/";

  // Realizar una solicitud GET a la URL para obtener los datos de los usuarios
  // El método [http.get] devuelve una promesa que se resuelve en una instancia de la clase [http.Response].
  // La respuesta de la solicitud se almacena en la variable [response].
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    bienestar.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista con los datos decodificados
    for (var bienestarData in decodedData) {
      bienestar.add(
        BienestarModel(
          id: bienestarData['id'] ?? 0,
          nombres: bienestarData['nombres'] ?? "",
          apellidos: bienestarData['apellidos'] ?? "",
          tipoDocumento: bienestarData['tipoDocumento'] ?? "",
          numeroDocumento: bienestarData['numeroDocumento'] ?? "",
          correoElectronico: bienestarData['correoElectronico'] ?? "",
          rol1: bienestarData['rol1'] ?? "",
          estado: bienestarData['estado'] ?? true,
        ),
      );
    }

    // Devolver la lista de usuarios
    return bienestar;
  } else {
    // Si la respuesta no fue exitosa, se lanza una excepción
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
