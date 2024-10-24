// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, non_constant_identifier_names
import 'package:comites/Widgets/animacionSobresaliente.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:comites/Models/SolicitudModel.dart';
import 'package:intl/intl.dart';

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

  @override
  void initState() {
    super.initState();
    futureSolicitudes = getSolicitud();
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

Widget _buildPendingSolicitudesList() {
  return FutureBuilder<List<SolicitudModel>>(
    future: futureSolicitudes,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (snapshot.hasData) {
        solicitudes = snapshot.data!;
        solicitudesPendientes =
            solicitudes.where((s) => !s.citacionenviada).toList();

        // Usamos un Wrap para disposición horizontal y responsiva
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 10.0, // Espacio horizontal entre tarjetas
                runSpacing: 10.0, // Espacio vertical entre filas
                alignment: WrapAlignment.start,
                children: solicitudesPendientes.map((solicitud) {
                  return SizedBox(
                    width: constraints.maxWidth > 600 ? 300 : constraints.maxWidth * 0.9,
                    child: AnimacionSobresaliente(
                      scaleFactor: 1.04,
                      child: Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: Text(
                            'Acta | ${DateFormat('yyyy-MM-dd').format(solicitud.fechasolicitud)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text('Aprendices'),
                          trailing: const Icon(
                            Icons.pending_actions,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
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
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate == null) return;

    _fechaController.text = pickedDate.toIso8601String().split('T')[0];

    final TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );

    if (pickedStartTime == null) return;

    _horaInicioController.text = pickedStartTime.format(context);

    final TimeOfDay? pickedEndTime = await showTimePicker(
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
                          onPressed: () => _editCitation(index, citacion),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // Llama a la función de eliminación y actualiza el estado
                            _deleteCitation(index);
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
  }

  void _editCitation(int index, Map<String, dynamic> citacion) {
    TimeOfDay selectedStartTime =
        TimeOfDay.fromDateTime(citacion['horaInicio']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Citación'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Hora de inicio actual: ${citacion['horaInicio'].toString()}'),
              ElevatedButton(
                onPressed: () async {
                  TimeOfDay? newStartTime = await showTimePicker(
                    context: context,
                    initialTime: selectedStartTime,
                  );

                  if (newStartTime != null) {
                    DateTime newStartDateTime = DateTime(
                      citacion['horaInicio'].year,
                      citacion['horaInicio'].month,
                      citacion['horaInicio'].day,
                      newStartTime.hour,
                      newStartTime.minute,
                    );

                    // Comprobar si la nueva hora de inicio ya está ocupada
                    bool isOccupied = false;
                    for (var citation in citacionesGeneradas) {
                      DateTime citationStart = citation['horaInicio'];
                      DateTime citationEnd = citation['horaFin'];
                      if (newStartDateTime.isAfter(citationStart) &&
                          newStartDateTime.isBefore(citationEnd)) {
                        isOccupied = true;
                        break;
                      }
                    }

                    if (isOccupied) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'La hora de inicio ya está ocupada.')));
                    } else {
                      // Actualizar la hora de inicio y calcular la nueva hora de fin
                      citacion['horaInicio'] = newStartDateTime;
                      citacion['horaFin'] =
                          newStartDateTime.add(const Duration(minutes: 20));

                      // Actualizar la siguiente citación
                      if (index < citacionesGeneradas.length - 1) {
                        var nextCitation = citacionesGeneradas[index + 1];
                        nextCitation['horaInicio'] = citacion['horaFin'];
                        nextCitation['horaFin'] = nextCitation['horaInicio']
                            .add(const Duration(minutes: 20));
                      }

                      // Actualizar el estado
                      setState(() {});
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: const Text('Seleccionar Nueva Hora de Inicio'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _deleteCitation(int index) {
    if (index < 0 || index >= citacionesGeneradas.length) {
      return; // Evitar acceder a un índice fuera de rango
    }

    // Mostrar un mensaje de confirmación antes de eliminar
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content:
              const Text('¿Estás seguro de que deseas eliminar esta citación?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Cerrar el diálogo de confirmación
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Eliminar la citación
                citacionesGeneradas.removeAt(index);

                // Actualizar las horas de las citas restantes
                for (int i = index; i < citacionesGeneradas.length; i++) {
                  if (i > 0) {
                    var previousCitation = citacionesGeneradas[i - 1];
                    // Asegúrate de que 'horaFin' sea un DateTime antes de acceder
                    if (previousCitation['horaFin'] is DateTime) {
                      citacionesGeneradas[i]['horaInicio'] =
                          previousCitation['horaFin'];
                      // Asegúrate de que 'horaInicio' no sea nulo antes de agregar duración
                      if (citacionesGeneradas[i]['horaInicio'] != null) {
                        citacionesGeneradas[i]['horaFin'] =
                            citacionesGeneradas[i]['horaInicio']
                                .add(const Duration(minutes: 20));
                      }
                    }
                  } else {
                    // Para la primera cita, solo ajustamos la hora de fin
                    if (citacionesGeneradas[i]['horaInicio'] is DateTime) {
                      citacionesGeneradas[i]['horaFin'] = citacionesGeneradas[i]
                              ['horaInicio']
                          .add(const Duration(minutes: 20));
                    }
                  }
                }

                // Actualizar el estado
                setState(() {});
                Navigator.of(context)
                    .pop(); // Cerrar el diálogo de confirmación
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
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