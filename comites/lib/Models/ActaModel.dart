// ignore_for_file: file_names, constant_identifier_names

/// Enum para la clasificación de la información del acta.
enum Clasificacion { PUBLICA, PRIVADO, SEMIPRIVADO, SENSIBLE }

/// Clase que representa un acta en la aplicación.
class ActaModel {
  final int id;
  final int citacion; // Usamos el ID de la citación
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