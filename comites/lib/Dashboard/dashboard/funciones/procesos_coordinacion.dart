import 'dart:convert';

import 'package:comites/Models/AprendizModel.dart';
import 'package:comites/Models/CoordinadorModel.dart';
import 'package:comites/Models/ReglamentoModel.dart';
import 'package:comites/Models/instructormodel.dart';
import 'package:comites/pdf/generar_pdf.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:comites/Models/SolicitudModel.dart';
import 'package:comites/provider.dart';
import 'package:http/http.dart' as http;
import '../../../source.dart';

class SolicitudesCoordinacion extends StatefulWidget {
  const SolicitudesCoordinacion({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SolicitudesCoordinacionState createState() =>
      _SolicitudesCoordinacionState();
}

class _SolicitudesCoordinacionState extends State<SolicitudesCoordinacion> {
  late Future<List<SolicitudModel>> futureSolicitudes;
  late String coordinacionActual;

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

  Future<void> _loadSolicitudes() async {
    final appState = Provider.of<AppState>(context, listen: false);
    final userId = appState.userId;
    if (userId != null) {
      // Obtener la coordinación del coordinador actual
      final coordinador = await getCoordinador().then(
          (coordinadores) => coordinadores.firstWhere((c) => c.id == userId));
      coordinacionActual = coordinador.coordinacion;

      // Obtener todos los instructores de la misma coordinación
      final aprendicesMismaCoordinacion = await getAprendiz().then(
          (aprendices) => aprendices
              .where((i) => i.coordinacion == coordinacionActual)
              .toList());

      // Obtener todas las solicitudes
      final todasLasSolicitudes = await getSolicitud();

      // Filtrar las solicitudes de los instructores de la misma coordinación
      setState(() {
        futureSolicitudes = Future.value(todasLasSolicitudes
            .where((solicitud) => aprendicesMismaCoordinacion
                .any((aprendiz) => solicitud.aprendiz.contains(aprendiz.id)))
            .toList());
      });
    } else {
      setState(() {
        futureSolicitudes = Future.error('Usuario no autenticado');
      });
    }
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

  void _showSolicitudDetails(SolicitudModel solicitud) {
    // ... (mantener el mismo código que tenías para mostrar detalles)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Solicitudes de Instructores en Coordinación $coordinacionActual',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: _buildSolicitudesList()),
        ],
      ),
    );
  }

  Widget _buildSolicitudesList() {
    return FutureBuilder<List<SolicitudModel>>(
      future: futureSolicitudes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text(
                  'No hay solicitudes disponibles para esta coordinación'));
        } else {
          final solicitudes = snapshot.data!;
          return _buildGrid(solicitudes);
        }
      },
    );
  }

  Widget _buildGrid(List<SolicitudModel> solicitudes) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    int crossAxisCount = 5;
    double childAspectRatio = 1;

    if (screenWidth < 600) {
      crossAxisCount = 2;
      childAspectRatio = screenWidth / (screenHeight / 1.5);
    } else if (screenWidth >= 600 && screenWidth < 1200) {
      crossAxisCount = 3;
      childAspectRatio = screenWidth / (screenHeight);
    } else if (screenWidth >= 1200 && screenWidth < 1900) {
      crossAxisCount = 4;
      childAspectRatio = screenWidth / (screenHeight * 1.5);
    }

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: solicitudes.length,
      itemBuilder: (context, index) {
        final solicitud = solicitudes[index];

        return FutureBuilder<List<UsuarioAprendizModel>>(
          future: Future.wait(
              solicitud.aprendiz.map((id) => _getAprendizDetails(id))),
          builder: (context, aprendizSnapshot) {
            if (aprendizSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (aprendizSnapshot.hasError) {
              return Center(child: Text('Error: ${aprendizSnapshot.error}'));
            } else if (!aprendizSnapshot.hasData ||
                aprendizSnapshot.data!.isEmpty) {
              return const Center(child: Text('No hay aprendices disponibles'));
            } else {
              final aprendices = aprendizSnapshot.data!;

              return FutureBuilder<List<ReglamentoModel>>(
                  future: Future.wait(solicitud.reglamento
                      .map((id) => _getReglamentoDetails(id))),
                  builder: (context, reglamentoSnapshot) {
                    if (reglamentoSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (reglamentoSnapshot.hasError) {
                      return Center(
                          child: Text('Error: ${reglamentoSnapshot.error}'));
                    } else if (!reglamentoSnapshot.hasData ||
                        reglamentoSnapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No hay reglamentos disponibles'));
                    } else {
                      final reglamentos = reglamentoSnapshot.data!;
                      int academicosCount =
                          reglamentos.where((r) => r.academico).length;
                      int disciplinariosCount =
                          reglamentos.where((r) => r.disciplinario).length;

                      // Estado para manejar el color de la tarjeta
                      bool isHovered = false;

                      return StatefulBuilder(builder: (context, setState) {
                        return MouseRegion(
                            onEnter: (_) => setState(() => isHovered = true),
                            onExit: (_) => setState(() => isHovered = false),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.green,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                elevation: 8,
                                shadowColor: Colors.grey.withOpacity(0.5),
                                color: isHovered
                                    ? Colors.green
                                    : const Color(
                                        0xFFFF6701), // Cambio de color
                                child: InkWell(
                                  onTap: () {
                                    _showSolicitudDetails(solicitud);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // FECHA
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.calendar_today,
                                                        color: Colors.green),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: Text(
                                                        'Fecha: ${DateFormat('yyyy-MM-dd').format(solicitud.fechasolicitud)}',
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),

                                                // DESCRIPCIÓN
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Icon(
                                                        Icons.description,
                                                        color: Colors.blue),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: Text(
                                                        'Descripción: ${solicitud.descripcion}',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),

                                                // FICHA
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Icon(Icons.numbers),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      'Ficha: ${aprendices.isNotEmpty ? aprendices[0].ficha : 'No disponible'}',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),

                                                // APRENDICES
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Icon(Icons.people,
                                                        color: Colors.grey),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      'Aprendices: ${aprendices.length}',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),

                                                // REGLAMENTOS ACADÉMICOS
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Icon(Icons.book,
                                                        color: Color.fromARGB(
                                                            255,
                                                            165,
                                                            117,
                                                            101)),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: Text(
                                                        'Reglamentos Académicos: $academicosCount',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),

                                                // REGLAMENTOS DISCIPLINARIOS
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Icon(Icons.book,
                                                        color: Color.fromARGB(
                                                            255,
                                                            165,
                                                            117,
                                                            101)),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: Text(
                                                        'Reglamentos Disciplinarios: $disciplinariosCount',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 20),

                                                // INDICADORES DE ESTADO (BOOL)
                                                Wrap(
                                                  children: [
                                                    _buildWorkFlow(
                                                        solicitud
                                                            .solicitudenviada,
                                                        "",
                                                        isModal: false),
                                                    const SizedBox(width: 8),
                                                    _buildWorkFlow(
                                                        solicitud
                                                            .citacionenviada,
                                                        "",
                                                        isModal: false),
                                                    const SizedBox(width: 8),
                                                    _buildWorkFlow(
                                                        solicitud.comiteenviado,
                                                        "",
                                                        isModal: false),
                                                    const SizedBox(width: 8),
                                                    _buildWorkFlow(
                                                        solicitud
                                                            .planmejoramiento,
                                                        "",
                                                        isModal: false),
                                                    const SizedBox(width: 8),
                                                    _buildWorkFlow(
                                                        solicitud
                                                            .desicoordinador,
                                                        "",
                                                        isModal: false),
                                                    const SizedBox(width: 8),
                                                    _buildWorkFlow(
                                                        solicitud.desiabogada,
                                                        "",
                                                        isModal: false),
                                                    const SizedBox(width: 8),
                                                    _buildWorkFlow(
                                                        solicitud.finalizado,
                                                        "",
                                                        isModal: false),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Flexible(
                                                      child: TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          backgroundColor: Colors
                                                              .green, // Color de fondo del botón
                                                          side: const BorderSide(
                                                              color:
                                                                  Colors.green,
                                                              width:
                                                                  2), // Borde
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 16.0,
                                                              vertical:
                                                                  8.0), // Padding interno
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0), // Borde redondeado
                                                          ),
                                                        ),
                                                        child: const Text(
                                                            'WorkFlow',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        onPressed: () {
                                                          showWorkFlowModal(
                                                              context,
                                                              solicitud);
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        width:
                                                            10), // Separador entre los botones
                                                    Flexible(
                                                      child: TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          backgroundColor: Colors
                                                              .blue, // Color de fondo del botón
                                                          side: const BorderSide(
                                                              color:
                                                                  Colors.blue,
                                                              width:
                                                                  2), // Borde
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 16.0,
                                                              vertical:
                                                                  8.0), // Padding interno
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0), // Borde redondeado
                                                          ),
                                                        ),
                                                        child: const Text('PDF',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        onPressed: () async {
                                                          await _generatePdf(
                                                              solicitud);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ));
                      });
                    }
                  });
            }
          },
        );
      },
    );
  }
}
