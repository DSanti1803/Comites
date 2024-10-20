// ignore_for_file: use_build_context_synchronously, use_full_hex_values_for_flutter_colors

import 'package:comites/Models/AprendizModel.dart';
import 'package:comites/Models/ReglamentoModel.dart';
import 'package:comites/Models/instructormodel.dart';
import 'package:comites/constantsDesign.dart';
import 'package:comites/pdf/generar_pdf.dart';
import 'package:comites/source.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comites/Models/SolicitudModel.dart';
import 'package:comites/provider.dart'; // El archivo donde está AppState y la función getSolicitudesByUser
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ProcesosRealizados extends StatefulWidget {
  const ProcesosRealizados({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProcesosRealizadosState createState() => _ProcesosRealizadosState();
}

class _ProcesosRealizadosState extends State<ProcesosRealizados> {
  late Future<List<SolicitudModel>> futureSolicitudes;

  @override
  void initState() {
    super.initState();
    _loadSolicitudes();
  }

  Future<UsuarioAprendizModel> _getAprendizDetails(int id) async {
    final response =
        await http.get(Uri.parse('$sourceApi/api/UsuarioAprendiz/$id'));
    if (response.statusCode == 200) {
      return UsuarioAprendizModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load aprendiz details');
    }
  }

  Future<InstructorModel> _getInstructorDetails(int id) async {
    final response = await http.get(Uri.parse('$sourceApi/api/Instructor/$id'));
    if (response.statusCode == 200) {
      return InstructorModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load instructor details');
    }
  }

  Future<ReglamentoModel> _getReglamentoDetails(int id) async {
    final response = await http.get(Uri.parse('$sourceApi/api/Reglamento/$id'));
    if (response.statusCode == 200) {
      return ReglamentoModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load reglamento details');
    }
  }

  void _showSolicitudDetails(SolicitudModel solicitud) async {
    // Mostrar un indicador de carga
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: SkeletonLoader());
      },
    );

    try {
      // Cargar detalles
      List<UsuarioAprendizModel> aprendices = await Future.wait(
          solicitud.aprendiz.map((id) => _getAprendizDetails(id)));
      List<InstructorModel> responsables = await Future.wait(
          solicitud.responsable.map((id) => _getInstructorDetails(id)));
      List<ReglamentoModel> reglamentos = await Future.wait(
          solicitud.reglamento.map((id) => _getReglamentoDetails(id)));

      // Cerrar el indicador de carga
      Navigator.of(context).pop();

      // Mostrar el diálogo con los detalles
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Detalles de la Solicitud ${solicitud.id}'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Id Solicitud: ${solicitud.id}'),
                  Text(
                      'Fecha de Solicitud: ${DateFormat('yyyy-MM-dd HH:mm').format(solicitud.fechasolicitud)}'),
                  const Text('Aprendiz/Aprendices:'),
                  ...aprendices.map((a) => Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text('${a.nombres} ${a.apellidos}'),
                      )),
                  Text('Descripción: ${solicitud.descripcion}'),
                  Text('Observaciones: ${solicitud.observaciones}'),
                  const Text('Responsables:'),
                  ...responsables.map((r) => Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text('${r.nombres} ${r.apellidos}'),
                      )),
                  const Text('Reglamento Incumplido:'),
                  ...reglamentos.map((r) => Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                            '${r.capitulo} - ${r.numeral}: ${r.descripcion}'),
                      )),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('PDF'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _generatePdf(solicitud);
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Cerrar el indicador de carga
      Navigator.of(context).pop();
      // Mostrar un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar los detalles: $e')),
      );
    }
  }

  Future<void> _generatePdf(SolicitudModel solicitud) async {
    // Cargar detalles
    List<UsuarioAprendizModel> aprendices = await Future.wait(
        solicitud.aprendiz.map((id) => _getAprendizDetails(id)));
    List<InstructorModel> responsables = await Future.wait(
        solicitud.responsable.map((id) => _getInstructorDetails(id)));
    List<ReglamentoModel> reglamentos = await Future.wait(
        solicitud.reglamento.map((id) => _getReglamentoDetails(id)));

    final pdfGenerator = PdfGenerator(
      solicitud: solicitud,
      aprendices: aprendices,
      responsables: responsables,
      reglamentos: reglamentos,
    );
    await pdfGenerator.generatePdf();
  }

  void showWorkFlowModal(BuildContext context, SolicitudModel solicitud) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'WorkFlow',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  _buildLargeWorkFlowStep(
                    context,
                    solicitud.solicitudenviada,
                    "Enviado",
                    solicitud.solicitudenviada
                        ? "El estado 'Enviado' se ha completado exitosamente."
                        : "El estado 'Enviado' aún no se ha completado.",
                  ),
                  _buildLargeWorkFlowStep(
                    context,
                    solicitud.citacionenviada,
                    "Citado",
                    solicitud.citacionenviada
                        ? "El estado 'Citado' se ha completado exitosamente."
                        : "El estado 'Citado' aún no se ha completado.",
                  ),
                  _buildLargeWorkFlowStep(
                    context,
                    solicitud.comiteenviado,
                    "Comité",
                    solicitud.comiteenviado
                        ? "El estado 'Comité' se ha completado exitosamente."
                        : "El estado 'Comité' aún no se ha completado.",
                  ),
                  _buildLargeWorkFlowStep(
                    context,
                    solicitud.planmejoramiento,
                    "Plan",
                    solicitud.planmejoramiento
                        ? "El estado 'Plan de Mejoramiento' se ha completado exitosamente."
                        : "El estado 'Plan de Mejoramiento' aún no se ha completado.",
                  ),
                  _buildLargeWorkFlowStep(
                    context,
                    solicitud.desicoordinador,
                    "Coordinador",
                    solicitud.desicoordinador
                        ? "El estado 'Decisión del Coordinador' se ha completado exitosamente."
                        : "El estado 'Decisión del Coordinador' aún no se ha completado.",
                  ),
                  _buildLargeWorkFlowStep(
                    context,
                    solicitud.desiabogada,
                    "Abogado",
                    solicitud.desiabogada
                        ? "El estado 'Decisión del Abogado' se ha completado exitosamente."
                        : "El estado 'Decisión del Abogado' aún no se ha completado.",
                  ),
                  _buildLargeWorkFlowStep(
                    context,
                    solicitud.finalizado,
                    "Finalizado",
                    solicitud.finalizado
                        ? "El estado 'Finalizado' se ha completado exitosamente."
                        : "El estado 'Finalizado' aún no se ha completado.",
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 12.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cerrar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLargeWorkFlowStep(
      BuildContext context, bool status, String label, String description) {
    return GestureDetector(
      onTap: () {
        _showStepDetails(context, label, description);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Círculo
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: status
                      ? [Colors.green, Colors.lightGreenAccent]
                      : [Colors.grey, Colors.black26],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Icon(
                status ? Icons.check : Icons.radio_button_unchecked,
                size: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            // Cuadro con el proceso
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: status
                      ? Colors.green.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: status ? Colors.green : Colors.grey,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: status ? Colors.green : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: status
                            ? Colors.green.shade700
                            : Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showStepDetails(
      BuildContext context, String label, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(label),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadSolicitudes() async {
    final userId = Provider.of<AppState>(context, listen: false).userId;
    if (userId != null) {
      setState(() {
        futureSolicitudes = getSolicitudesByUser(userId);
      });
    } else {
      setState(() {
        futureSolicitudes = Future.error('Usuario no autenticado');
      });
    }
  }

  Widget _buildWorkFlow(bool status, String label, {bool isModal = false}) {
    final double screenWidth =
        MediaQuery.of(context).size.width; // Tamaño de la pantalla
    final double iconSize =
        isModal ? (screenWidth > 400 ? 40.0 : 30.0) : 24.0; // Tamaño adaptable
    final double fontSize = isModal ? (screenWidth > 400 ? 16.0 : 14.0) : 12.0;

    return Column(
      children: [
        Icon(
          status ? Icons.check_circle : Icons.radio_button_unchecked,
          color: status ? Colors.green : Colors.grey,
          size: iconSize,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: fontSize, color: Colors.black),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<AppState>(context).userId;
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'Solicitudes Que Haz Realizado',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text('Tu ID: $userId'),
          const SizedBox(height: 30),
          Expanded(child: _buildSolicitudesList()),
        ],
      ),
    );
  }

  Widget _buildSkeletonLoader() {
  return GridView.builder(
    padding: const EdgeInsets.all(10.0),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, // cantidad de loaders
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      childAspectRatio: 1,
    ),
    itemCount: 1, // Número de skeletons que deseas mostrar
    itemBuilder: (context, index) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonLoader(height: 20, width: 120), // Simula el título
              SizedBox(height: 10),
              SkeletonLoader(height: 15, width: 80), // Simula una línea de descripción
              SizedBox(height: 10),
              SkeletonLoader(height: 15, width: 100), // Simula otra línea de texto
              SizedBox(height: 10),
              SkeletonLoader(height: 15, width: 60), // Simula un dato adicional
            ],
          ),
        ),
      );
    },
  );
}


  Widget _buildSolicitudesList() {
  return FutureBuilder<List<SolicitudModel>>(
    future: futureSolicitudes,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Muestra el Skeleton Loader en lugar del SkeletonLoader
        return _buildSkeletonLoader();
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No hay solicitudes disponibles'));
      } else {
        final solicitudes = snapshot.data!;
        return _buildGrid(solicitudes);
      }
    },
  );
}


 Widget _buildGrid(List<SolicitudModel> solicitudes) {
  double maxCardWidth = 400; // Ancho máximo para cada tarjeta
  double cardAspectRatio = 4 / 4; // Ajuste de la proporción de la tarjeta

  return GridView.builder(
    padding: const EdgeInsets.all(10.0),
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: maxCardWidth,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      childAspectRatio: cardAspectRatio,
    ),
    itemCount: solicitudes.length,
    itemBuilder: (context, index) {
      final solicitud = solicitudes[index];

      return FutureBuilder<List<UsuarioAprendizModel>>(
        future: Future.wait(
          solicitud.aprendiz.map((id) => _getAprendizDetails(id)),
        ),
        builder: (context, aprendizSnapshot) {
          if (aprendizSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: SkeletonLoader());
          } else if (aprendizSnapshot.hasError) {
            return Center(child: Text('Error: ${aprendizSnapshot.error}'));
          } else if (!aprendizSnapshot.hasData || aprendizSnapshot.data!.isEmpty) {
            return const Center(child: Text('No hay aprendices disponibles'));
          } else {
            final aprendices = aprendizSnapshot.data!;

            return FutureBuilder<List<ReglamentoModel>>(
              future: Future.wait(
                solicitud.reglamento.map((id) => _getReglamentoDetails(id)),
              ),
              builder: (context, reglamentoSnapshot) {
                if (reglamentoSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: SkeletonLoader());
                } else if (reglamentoSnapshot.hasError) {
                  return Center(child: Text('Error: ${reglamentoSnapshot.error}'));
                } else if (!reglamentoSnapshot.hasData || reglamentoSnapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay reglamentos disponibles'));
                } else {
                  final reglamentos = reglamentoSnapshot.data!;
                  int academicosCount = reglamentos.where((r) => r.academico).length;
                  int disciplinariosCount = reglamentos.where((r) => r.disciplinario).length;

                  bool isHovered = false;

                  return StatefulBuilder(
                    builder: (context, setState) {
                      return MouseRegion(
                        onEnter: (_) => setState(() => isHovered = true),
                        onExit: (_) => setState(() => isHovered = false),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isHovered
                                ? const Color(0xffe1f5fe)
                                : const Color(0xFFFf0fee6),
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: isHovered
                                ? const Color(0xffe1f5fe)
                                : const Color(0xff6de458),
                                spreadRadius: 2,
                                blurRadius: 1,
                                offset: const Offset(0, 5),
                              ),
                              BoxShadow(
                                color: isHovered
                                    ? const Color(0xffe1f5fe).withOpacity(0.1)
                                    : const Color(0xff6de458).withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 15,
                                offset: const Offset(0, -5),
                              ),
                            ],
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 0,
                            child: InkWell(
                              onTap: () => _showSolicitudDetails(solicitud),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildRow(
                                      icon: Icons.calendar_today,
                                      label:
                                          'Fecha: ${DateFormat('yyyy-MM-dd').format(solicitud.fechasolicitud)}',
                                      isHovered: isHovered,
                                    ),
                                    const SizedBox(height: 10),
                                    _buildRow(
                                      icon: Icons.numbers,
                                      label:
                                          'Ficha: ${aprendices.isNotEmpty ? aprendices[0].ficha : 'No disponible'}',
                                      isHovered: isHovered,
                                    ),
                                    const SizedBox(height: 10),
                                    _buildRow(
                                      icon: Icons.people,
                                      label: 'Aprendices: ${aprendices.length}',
                                      isHovered: isHovered,
                                    ),
                                    const SizedBox(height: 10),
                                    _buildRow(
                                      icon: Icons.book,
                                      label:
                                          'Reglamentos Académicos: $academicosCount',
                                      isHovered: isHovered,
                                    ),
                                    const SizedBox(height: 10),
                                    _buildRow(
                                      icon: Icons.book,
                                      label:
                                          'Reglamentos Disciplinarios: $disciplinariosCount',
                                      isHovered: isHovered,
                                    ),
                                    const SizedBox(height: 20),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: [
                                        _buildWorkFlow(
                                            solicitud.solicitudenviada, "",
                                            isModal: false),
                                        _buildWorkFlow(
                                            solicitud.citacionenviada, "",
                                            isModal: false),
                                        _buildWorkFlow(
                                            solicitud.comiteenviado, "",
                                            isModal: false),
                                        _buildWorkFlow(
                                            solicitud.planmejoramiento, "",
                                            isModal: false),
                                        _buildWorkFlow(
                                            solicitud.desicoordinador, "",
                                            isModal: false),
                                        _buildWorkFlow(
                                            solicitud.desiabogada, "",
                                            isModal: false),
                                        _buildWorkFlow(
                                            solicitud.finalizado, "",
                                            isModal: false),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        _buildButton(
                                          label: 'WorkFlow',
                                          color: Colors.green,
                                          onPressed: () {
                                            showWorkFlowModal(
                                                context, solicitud);
                                          },
                                        ),
                                        const SizedBox(width: 10),
                                        _buildButton(
                                          label: 'PDF',
                                          color: Colors.blue,
                                          onPressed: () async {
                                            await _generatePdf(solicitud);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      );
    },
  );
}


  Widget _buildRow({
  required IconData icon,
  required String label,
  required bool isHovered,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: isHovered ? const Color.fromARGB(255, 17, 120, 255): const Color.fromARGB(255, 1, 187, 10)),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 17,
            color: isHovered ? primaryColor : textosOscuros, 
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
    ],
  );
}

Widget _buildButton({
  required String label,
  required Color color,
  required VoidCallback onPressed,
}) {
  return Flexible(
    child: TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
        side: BorderSide(color: color, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(color: Colors.white)),
    ),
  );
}

}

class SkeletonLoader extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius borderRadius;

  const SkeletonLoader({
    super.key,
    this.height = 20.0,
    this.width = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
