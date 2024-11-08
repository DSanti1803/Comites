// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, non_constant_identifier_names
import 'package:comites/Dashboard/dashboard/funciones/procesos_coordinacion.dart';
import 'package:comites/Models/AprendizModel.dart';
import 'package:comites/Models/CoordinadorModel.dart';
import 'package:comites/Models/instructormodel.dart';
import 'package:comites/Widgets/animacionSobresaliente.dart';
import 'package:comites/provider.dart';
import 'package:comites/source.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:comites/Models/SolicitudModel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CitacionesForm extends StatefulWidget {
  const CitacionesForm({super.key});

  @override
  _CitacionesFormState createState() => _CitacionesFormState();
}

class _CitacionesFormState extends State<CitacionesForm> {
  late Future<List<SolicitudModel>> futureSolicitudes;
  List<SolicitudModel> solicitudes = [];
  List<SolicitudModel> solicitudesPendientes = [];
  final TextEditingController _fechaController = TextEditingController();
  String? tipoCita; // Variable para almacenar el tipo de cita seleccionado
  final TextEditingController _horaInicioController = TextEditingController();
  final TextEditingController _horaFinController = TextEditingController();
  List<Map<String, dynamic>> citacionesGeneradas = [];
  String? coordinacionActual;

  @override
  void initState() {
    super.initState();
    futureSolicitudes = getSolicitud();
    _loadCoordinacion();
    _buildPendingSolicitudesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildPendingSolicitudesList(),
            const SizedBox(height: 20),
            _AgendarAutoButton(),
          ],
        ),
      ),
    );
  }

  Future<void> _loadCoordinacion() async {
    final appState = Provider.of<AppState>(context, listen: false);
    final userId = appState.userId;

    if (userId != null) {
      // Obtener la coordinación del coordinador actual
      final coordinador = await getCoordinador().then(
          (coordinadores) => coordinadores.firstWhere((c) => c.id == userId));

      setState(() {
        coordinacionActual =
            coordinador.coordinacion; // Guardar la coordinación actual
      });
    } else {
      // Manejar el error de usuario no autenticado
      setState(() {
        coordinacionActual = null;
      });
    }
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

 Widget _buildPendingSolicitudesList() {
  return FutureBuilder<List<SolicitudModel>>(
    future: futureSolicitudes,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: List.generate(5, (_) => 
              const SizedBox(
                width: 300, // Ancho aproximado de la tarjeta
                height: 20, // Altura aproximada de la tarjeta
                child: SkeletonLoader(),
              ),
            ),
          ),
        );
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (snapshot.hasData) {
        solicitudes = snapshot.data!;

        solicitudesPendientes = solicitudes.where((solicitud) {
          return solicitud.aprendiz.any((aprendizId) {
            final aprendiz = aprendices.firstWhere(
              (a) => a.id == aprendizId,
              orElse: () => UsuarioAprendizModel(
                  id: -1,
                  nombres: '',
                  apellidos: '',
                  tipoDocumento: '',
                  numeroDocumento: '',
                  ficha: '',
                  programa: '',
                  correoElectronico: '',
                  rol1: '',
                  estado: true,
                  coordinacion: ''), // Valor por defecto
            );
            return aprendiz.coordinacion == coordinacionActual &&
                !solicitud.citacionenviada;
          });
        }).toList();

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                alignment: WrapAlignment.start,
                children: solicitudesPendientes.map((solicitud) {
                  // Llamadas Future para obtener todos los detalles de aprendices y responsables
                  final aprendizFutures = solicitud.aprendiz
                      .map((id) => _getAprendizDetails(id))
                      .toList();
                  final responsableFutures = solicitud.responsable
                      .map((id) => _getInstructorDetails(id))
                      .toList();

                  return FutureBuilder(
                    future: Future.wait(
                        [...aprendizFutures, ...responsableFutures]),
                    builder:
                        (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          width: 300,
                          height: 20,
                          child: SkeletonLoader(),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        // Separar los detalles de aprendices y responsables
                        final aprendicesDetails = snapshot.data!
                            .sublist(0, solicitud.aprendiz.length)
                            .cast<UsuarioAprendizModel>();
                        final responsablesDetails = snapshot.data!
                            .sublist(solicitud.aprendiz.length)
                            .cast<InstructorModel>();

                        return SizedBox(
                          width: constraints.maxWidth > 600
                              ? 300
                              : constraints.maxWidth * 0.9,
                          child: AnimacionSobresaliente(
                            scaleFactor: 1.04,
                            child: Card(
                              elevation: 3,
                              margin:
                                  const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                title: Text(
                                  'Acta | ${DateFormat('yyyy-MM-dd').format(solicitud.fechasolicitud)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Aprendices:'),
                                    ...aprendicesDetails.take(5).map((aprendiz) => Text(
                                          '${aprendiz.nombres} ${aprendiz.apellidos}',
                                        )),
                                    if (aprendicesDetails.length > 5)
                                      Text('... y ${aprendicesDetails.length - 5} aprendices más'),
                                    const SizedBox(height: 8),
                                    const Text('Responsables:'),
                                    ...responsablesDetails.map((responsable) => Text(
                                          '${responsable.nombres} ${responsable.apellidos}',
                                        )),
                                  ],
                                ),
                                trailing: const Icon(
                                  Icons.pending_actions,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const Text('Cargando datos...');
                      }
                    },
                  );
                }).toList(),
              );
            },
          ),
        );
      } else {
        return const Text('No hay solicitudes pendientes');
      }
    },
  );
}


  Widget _AgendarAutoButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        // Verificar si hay solicitudes pendientes
        if (solicitudesPendientes.isEmpty) {
          // Mostrar mensaje si no hay solicitudes pendientes
          _SinSolicitudesPendientes();
        } else {
          // Continuar con el proceso normal si hay solicitudes
          _ModalAgendar();
        }
      },
      child: const Text(
        'Agendar Automáticamente',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  void _SinSolicitudesPendientes() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text('Sin solicitudes pendientes'),
          content:
              const Text('No tienes solicitudes pendientes en este momento.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _ModalAgendar() async {
    final DateTime? pickedDate = await showDatePicker(
      helpText: 'Dia Comité',
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate == null) return;

    _fechaController.text = pickedDate.toIso8601String().split('T')[0];

    final TimeOfDay? pickedStartTime = await showTimePicker(
      helpText: 'Hora Inicio',
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );

    if (pickedStartTime == null) return;

    _horaInicioController.text = pickedStartTime.format(context);

    final TimeOfDay? pickedEndTime = await showTimePicker(
      helpText: 'Hora Fin',
      context: context,
      initialTime: const TimeOfDay(hour: 16, minute: 0),
    );

    if (pickedEndTime == null) return;

    _horaFinController.text = pickedEndTime.format(context);

    _generateCitations(pickedDate, pickedStartTime, pickedEndTime);

    _ResumenCitaciones();
  }

  void _generateCitations(
      DateTime date, TimeOfDay startTime, TimeOfDay endTime) {
    citacionesGeneradas.clear();
    DateTime currentTime = DateTime(
        date.year, date.month, date.day, startTime.hour, startTime.minute);
    DateTime endDateTime =
        DateTime(date.year, date.month, date.day, endTime.hour, endTime.minute);

    for (var solicitud in solicitudesPendientes) {
      if (currentTime.add(const Duration(minutes: 20)).isAfter(endDateTime)) {
        break;
      }

      citacionesGeneradas.add({
        'solicitudId': solicitud.id,
        'fecha': date.toIso8601String().split('T')[0],
        'horaInicio':
            '${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}',
        'horaFin':
            '${currentTime.add(const Duration(minutes: 20)).hour.toString().padLeft(2, '0')}:${currentTime.add(const Duration(minutes: 20)).minute.toString().padLeft(2, '0')}',
        'tipoCitacion': null,
        'lugar': null,
        'enlace': null,
      });

      // Actualiza la solicitud como citación enviada
      solicitud.citacionenviada = true; // Marcar como citación enviada

      currentTime = currentTime.add(const Duration(minutes: 20));
    }

    // Actualiza la lista de solicitudes pendientes
    setState(() {
      solicitudesPendientes =
          solicitudes.where((s) => !s.citacionenviada).toList();
    });
  }

  void _ResumenCitaciones() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: const Text(
                'Resumen de Citaciones',
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: citacionesGeneradas.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> citacion = entry.value;
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Text('Solicitud ${citacion['solicitudId']}'),
                        subtitle: Text(
                            '${citacion['horaInicio']} - ${citacion['horaFin']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () =>
                                  _editCitation(index, citacion, setModalState),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // Llama a la función de eliminación y actualiza el estado
                                _deleteCitation(index, setModalState);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showCitationDetailsForm();
                  },
                  child: const Text('Confirmar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _editCitation(int index, Map<String, dynamic> citacion,
      StateSetter setModalState) async {
    DateTime currentStartTime = _parseTime(citacion['horaInicio']);
    DateTime currentEndTime = _parseTime(citacion['horaFin']);

    // Selección de la nueva hora de inicio
    TimeOfDay? newStartTime = await showTimePicker(
      helpText: 'Nueva Hora Inicio',
      context: context,
      initialTime: TimeOfDay.fromDateTime(currentStartTime),
    );

    if (newStartTime == null) return;

    // Selección de la nueva hora de fin
    TimeOfDay? newEndTime = await showTimePicker(
      helpText: 'Nueva Hora Fin',
      context: context,
      initialTime: TimeOfDay.fromDateTime(currentEndTime),
    );

    if (newEndTime == null) return;

    // Actualizar la hora de la citación seleccionada
    DateTime newStartDateTime = DateTime(
      currentStartTime.year,
      currentStartTime.month,
      currentStartTime.day,
      newStartTime.hour,
      newStartTime.minute,
    );

    DateTime newEndDateTime = DateTime(
      currentEndTime.year,
      currentEndTime.month,
      currentEndTime.day,
      newEndTime.hour,
      newEndTime.minute,
    );

    // Actualizar los datos de la citación editada
    setModalState(() {
      citacion['horaInicio'] =
          '${newStartDateTime.hour.toString().padLeft(2, '0')}:${newStartDateTime.minute.toString().padLeft(2, '0')}';
      citacion['horaFin'] =
          '${newEndDateTime.hour.toString().padLeft(2, '0')}:${newEndDateTime.minute.toString().padLeft(2, '0')}';
    });

    // Actualizar las citaciones posteriores
    for (var i = index + 1; i < citacionesGeneradas.length; i++) {
      DateTime prevEndTime = _parseTime(citacionesGeneradas[i - 1]['horaFin']);
      citacionesGeneradas[i]['horaInicio'] =
          '${prevEndTime.hour.toString().padLeft(2, '0')}:${prevEndTime.minute.toString().padLeft(2, '0')}';
      citacionesGeneradas[i]['horaFin'] =
          '${prevEndTime.add(const Duration(minutes: 20)).hour.toString().padLeft(2, '0')}:${prevEndTime.add(const Duration(minutes: 20)).minute.toString().padLeft(2, '0')}';
    }
  }

// Función para eliminar una citación seleccionada
  void _deleteCitation(int index, StateSetter setModalState) {
    setModalState(() {
      citacionesGeneradas.removeAt(index);
    });

    // Recalcular las horas de las citaciones después de la eliminación
    for (var i = index; i < citacionesGeneradas.length; i++) {
      DateTime prevEndTime = _parseTime(citacionesGeneradas[i - 1]['horaFin']);
      citacionesGeneradas[i]['horaInicio'] =
          '${prevEndTime.hour.toString().padLeft(2, '0')}:${prevEndTime.minute.toString().padLeft(2, '0')}';
      citacionesGeneradas[i]['horaFin'] =
          '${prevEndTime.add(const Duration(minutes: 20)).hour.toString().padLeft(2, '0')}:${prevEndTime.add(const Duration(minutes: 20)).minute.toString().padLeft(2, '0')}';
    }
  }

// Función para parsear las horas
  DateTime _parseTime(String time) {
    final parts = time.split(':');
    return DateTime(0, 1, 1, int.parse(parts[0]), int.parse(parts[1]));
  }

  void _showIncompleteFieldsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text('Campos Incompletos'),
          content: const Text(
            'Por favor, complete todos los campos obligatorios antes de confirmar la citación.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _showCitationDetailsForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: const Text('Detalles de Citación',
                  textAlign: TextAlign.center),
              content: SingleChildScrollView(
                child: Column(
                  children: citacionesGeneradas.asMap().entries.map((entry) {
                    Map<String, dynamic> citacion = entry.value;
                    return ExpansionTile(
                      title: Text('Acta | ${citacion['solicitudId']}'),
                      subtitle: Text(
                          '${citacion['horaInicio']} - ${citacion['horaFin']}'),
                      children: [
                        // Dropdown para tipo de citación
                        DropdownButtonFormField<String>(
                          value: citacion['tipoCitacion'],
                          items: const [
                            DropdownMenuItem(
                              value: 'Presencial',
                              child: Text('Presencial'),
                            ),
                            DropdownMenuItem(
                              value: 'Virtual',
                              child: Text('Virtual'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              citacion['tipoCitacion'] = value;
                              // Limpiar el otro campo y establecer "No aplica"
                              if (value == 'Presencial') {
                                citacion['enlace'] = 'No aplica';
                              } else if (value == 'Virtual') {
                                citacion['lugar'] = 'No aplica';
                              }
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Tipo de Citación',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Mostrar campo de lugar si es Presencial
                        if (citacion['tipoCitacion'] == 'Presencial')
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                citacion['lugar'] = value;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Lugar',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                        // Mostrar campo de enlace si es Virtual
                        if (citacion['tipoCitacion'] == 'Virtual')
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                citacion['enlace'] = value;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Enlace',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // Verifica si solo uno de los campos obligatorios está completo
                    bool camposCompletos = true;
                    for (var citacion in citacionesGeneradas) {
                      bool tieneLugar = citacion['lugar'] != null &&
                          citacion['lugar'].isNotEmpty &&
                          citacion['lugar'] != 'No aplica';
                      bool tieneEnlace = citacion['enlace'] != null &&
                          citacion['enlace'].isNotEmpty &&
                          citacion['enlace'] != 'No aplica';
                      bool tieneTipoCitacion = citacion['tipoCitacion'] != null;

                      // Solo uno debe estar completo
                      if (tieneLugar && tieneEnlace) {
                        camposCompletos = false;
                        break;
                      }

                      if (!tieneTipoCitacion || (!tieneLugar && !tieneEnlace)) {
                        camposCompletos = false;
                        break;
                      }
                    }

                    if (!camposCompletos) {
                      // Muestra un mensaje de error si falta algún campo obligatorio
                      _showIncompleteFieldsDialog();
                    } else {
                      Navigator.of(context).pop();
                      _finalizeCitations();
                    }
                  },
                  child: const Text('Finalizar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _finalizeCitations() async {
    for (var citacion in citacionesGeneradas) {
      try {
        bool isPresencial = citacion['tipoCitacion'] == 'Presencial';

        final response = await http.post(
          Uri.parse('http://127.0.0.1:8000/api/Citacion/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'solicitud': citacion['solicitudId'],
            'diacitacion': citacion['fecha'], // Fecha en formato 'yyyy-MM-dd'
            'horainicio': citacion['horaInicio'],
            'horafin': citacion['horaFin'], // Hora en formato 'HH:mm'
            'lugarcitacion': isPresencial ? citacion['lugar'] : 'No aplica',
            'enlacecitacion': isPresencial ? 'No aplica' : citacion['enlace'],
          }),
        );

        if (response.statusCode == 201) {
          print('Citación ${citacion['solicitudId']} creada exitosamente.');
          // Actualizar la solicitud para marcarla como citación enviada
          await _updateCitacionEnviada(citacion['solicitudId']);
        } else {
          print(
              'Error al crear citación ${citacion['solicitudId']}: ${response.body}');
        }
      } catch (e) {
        print('Error al conectar con el servidor: $e');
      }
    }
  }

  Future<void> _updateCitacionEnviada(int solicitudId) async {
    final Map<String, dynamic> data = {
      'citacionenviada': true,
    };

    try {
      final response = await http.patch(
        Uri.parse('http://127.0.0.1:8000/api/Solicitud/$solicitudId/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        print('Solicitud $solicitudId actualizada exitosamente.');
      } else {
        print(
            'Error al actualizar la solicitud $solicitudId: ${response.body}');
        throw Exception('Failed to update solicitud');
      }
    } catch (error) {
      print('Error al actualizar la solicitud $solicitudId: $error');
      rethrow;
    }
  }

  Future<List<SolicitudModel>> getSolicitud() async {
    try {
      final response =
          await http.get(Uri.parse('http://127.0.0.1:8000/api/Solicitud/'));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((item) => SolicitudModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load solicitudes: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al obtener solicitudes: $e');
      rethrow;
    }
  }
}
