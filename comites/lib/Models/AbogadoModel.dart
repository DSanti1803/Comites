// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../source.dart';

class AbogadoModel {
  final int id;
  final String nombres;
  final String apellidos;
  final String tipoDocumento;
  final String numeroDocumento;
  final String correoElectronico;
  final String rol1;
  final bool estado;

  AbogadoModel({
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

List<AbogadoModel> abogado = [];

// Método para obtener los datos de los usuarios
Future<List<AbogadoModel>> getAbogado() async {
  /// URL para obtener los datos de los usuarios de la API.
  ///
  /// Esta URL se utiliza para realizar una solicitud GET a la API y obtener los datos de los usuarios.
  String url = "";

  // Construir la URL de la API utilizando la variable de configuración [sourceApi]
  url = "$sourceApi/api/Abogado/";

  // Realizar una solicitud GET a la URL para obtener los datos de los usuarios
  // El método [http.get] devuelve una promesa que se resuelve en una instancia de la clase [http.Response].
  // La respuesta de la solicitud se almacena en la variable [response].
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    abogado.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista con los datos decodificados
    for (var abogadoData in decodedData) {
      abogado.add(
        AbogadoModel(
          id: abogadoData['id'] ?? 0,
          nombres: abogadoData['nombres'] ?? "",
          apellidos: abogadoData['apellidos'] ?? "",
          tipoDocumento: abogadoData['tipoDocumento'] ?? "",
          numeroDocumento: abogadoData['numeroDocumento'] ?? "",
          correoElectronico: abogadoData['correoElectronico'] ?? "",
          rol1: abogadoData['rol1'] ?? "",
          estado: abogadoData['estado'] ?? true,
        ),
      );
    }

    // Devolver la lista de usuarios
    return abogado;
  } else {
    // Si la respuesta no fue exitosa, se lanza una excepción
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
