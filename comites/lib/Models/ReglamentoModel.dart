// ignore_for_file: file_names
import 'dart:convert';

class ReglamentoModel {
  final int id;
  final String capitulo;
  final String numeral;
  final String descripcion;
  final bool academico;
  final bool disciplinario;
  final String gravedad;

  ReglamentoModel({
    required this.id,
    required this.capitulo,
    required this.numeral,
    required this.descripcion,
    required this.academico,
    required this.disciplinario,
    required this.gravedad,
  });

  factory ReglamentoModel.fromJson(Map<String, dynamic> json) {
    return ReglamentoModel(
      id: json['id'] ?? 0,
      capitulo: json['capitulo'] != null
          ? utf8.decode(json['capitulo'].toString().runes.toList())
          : "",
      numeral: json['numeral'] != null
          ? utf8.decode(json['numeral'].toString().runes.toList())
          : "",
      descripcion: json['descripcion'] != null
          ? utf8.decode(json['descripcion'].toString().runes.toList())
          : "",
      academico: json['academico'] ?? false,
      disciplinario: json['disciplinario'] ?? false,
      gravedad: json['gravedad'] != null
          ? utf8.decode(json['gravedad'].toString().runes.toList())
          : "leve", // Valor por defecto
    );
  }

  // Get para obtener el tipo de falta
  String get tipoFalta {
    if (disciplinario) {
      return 'Disciplinario';
    } else if (academico) {
      return 'Académico';
    } else {
      return 'Desconocido'; // Si ambos son falsos muestra que es reglamento desconocido
    }
  }
}