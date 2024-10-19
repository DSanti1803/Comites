// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../source.dart';

/// Clase que representa un usuario en la aplicación.
///
/// Contiene información como el identificador único, los nombres, los apellidos,
/// el tipo de documento, el número de documento, el correo electrónico, la
/// ciudad, la dirección, el teléfono, el teléfono celular, el rol 1, el rol 2,
/// el rol 3, el estado, el cargo, la ficha, el vocero, la fecha de registro,
/// la sede a la que está asociado, el punto de venta al que está asociado y
/// la unidad de producción a la que está asociado.
class UsuarioModel {
  /// Identificador único del usuario.
  final int id;

  /// Nombre del usuario.
  final String nombres;

  /// Apellido del usuario.
  final String apellidos;

  /// Tipo de documento del usuario.
  final String tipoDocumento;

  /// Número de documento del usuario.
  final String numeroDocumento;

  /// Correo electrónico del usuario.
  final String correoElectronico;

  /// Rol 1 del usuario.
  final String rol1;

  /// Estado del usuario.
  final bool estado;

  /// Cargo del usuario.

  /// Crea un nuevo objeto [UsuarioModel] con los parámetros proporcionados.
  UsuarioModel({
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

/// Clase que representa un modelo de registro de usuario.
///
/// Esta clase contiene los atributos necesarios para el registro de un usuario,
/// como nombres, apellidos, correo electrónico, tipo de documento, número de documento,
/// y teléfono.

/// Indica si todos los atributos del modelo son completos.
///
/// Un modelo es completo si tiene valores para todos los atributos.

List<UsuarioModel> usuarios = [];

// Método para obtener los datos de los usuarios
Future<List<UsuarioModel>> getUsuarios() async {
  /// URL para obtener los datos de los usuarios de la API.
  ///
  /// Esta URL se utiliza para realizar una solicitud GET a la API y obtener los datos de los usuarios.
  String url = "";

  // Construir la URL de la API utilizando la variable de configuración [sourceApi]
  url = "$sourceApi/api/usuarios/";

  // Realizar una solicitud GET a la URL para obtener los datos de los usuarios
  // El método [http.get] devuelve una promesa que se resuelve en una instancia de la clase [http.Response].
  // La respuesta de la solicitud se almacena en la variable [response].
  final response = await http.get(Uri.parse(url));

  // Verificar el código de estado de la respuesta
  if (response.statusCode == 200) {
    // Limpiar la lista antes de llenarla con datos actualizados
    usuarios.clear();

    // Decodificar la respuesta JSON a UTF-8
    String responseBodyUtf8 = utf8.decode(response.bodyBytes);
    List<dynamic> decodedData = jsonDecode(responseBodyUtf8);

    // Llenar la lista con los datos decodificados
    for (var usuariodata in decodedData) {
      usuarios.add(
        UsuarioModel(
          id: usuariodata['id'] ?? 0,
          nombres: usuariodata['nombres'] ?? "",
          apellidos: usuariodata['apellidos'] ?? "",
          tipoDocumento: usuariodata['tipoDocumento'] ?? "",
          numeroDocumento: usuariodata['numeroDocumento'] ?? "",
          correoElectronico: usuariodata['correoElectronico'] ?? "",
          rol1: usuariodata['rol1'] ?? "",
          estado: usuariodata['estado'] ?? true,
        ),
      );
    }

    // Devolver la lista de usuarios
    return usuarios;
  } else {
    // Si la respuesta no fue exitosa, se lanza una excepción
    throw Exception(
        'Fallo la solicitud HTTP con código ${response.statusCode}');
  }
}
