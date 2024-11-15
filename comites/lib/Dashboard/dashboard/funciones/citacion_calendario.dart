// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api, use_build_context_synchronously
import 'package:comites/Dashboard/dashboard/funciones/Actaform.dart';
import 'package:comites/Models/AprendizModel.dart';
import 'package:comites/Models/instructormodel.dart';
import 'package:comites/Widgets/Cards.dart';
import 'package:comites/Widgets/Expandible_Card.dart';
import 'package:comites/source.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';

class CalendarioCitaciones extends StatefulWidget {
  const CalendarioCitaciones({super.key});

  @override
  _CalendarioCitacionesState createState() => _CalendarioCitacionesState();
}

class _CalendarioCitacionesState extends State<CalendarioCitaciones> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  Map<DateTime, List<dynamic>> _events = {};

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    _fetchCitaciones();
    initializeDateFormatting('es_ES', null);
  }

  Future<void> _fetchCitaciones() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/Citacion/'));
    if (response.statusCode == 200) {
      final List<dynamic> citaciones = json.decode(response.body);
      setState(() {
        _events = {};
      });

      for (var citacion in citaciones) {
        final fecha = DateTime.parse(citacion['diacitacion']);
        if (_events[fecha] == null) _events[fecha] = [];

        // Agregar actarealizada a cada citación
        final actarealizada = citacion[
            'actarealizada']; // Suponiendo que actarealizada es un campo booleano en la citación.

        // Asegúrate de que aprendiz y responsable sean int extrayendo el primer elemento de la lista
        final aprendizIds =
            citacion['solicitud_data']['aprendiz'] as List<dynamic>;
        final responsableIds =
            citacion['solicitud_data']['responsable'] as List<dynamic>;

        if (aprendizIds.isNotEmpty && responsableIds.isNotEmpty) {
          final aprendizId = aprendizIds[0];
          final responsableId = responsableIds[0];

          try {
            final aprendiz = await _getAprendizDetails(aprendizId);
            final responsable = await _getInstructorDetails(responsableId);

            setState(() {
              citacion['solicitud_data']['aprendiz'] =
                  '${aprendiz.nombres} ${aprendiz.apellidos}';
              citacion['solicitud_data']['responsable'] =
                  '${responsable.nombres} ${responsable.apellidos}';
              citacion['actarealizada'] =
                  actarealizada; // Almacenar el estado de actarealizada
              _events[fecha]!.add(citacion);
            });
          } catch (e) {
            print('Error loading details for aprendiz or instructor: $e');
          }
        }
      }
    } else {
      print('Failed to load citaciones');
    }
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.9),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TableCalendar(
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(_selectedDay, selectedDay)) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        }
                      },
                      onFormatChanged: (format) {
                        if (_calendarFormat != format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                      locale: 'es_ES',
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      calendarStyle: const CalendarStyle(
                        outsideDaysVisible: false,
                        markersMaxCount: 0, // Desactiva los puntos de eventos
                      ),
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) {
                          final events = _getEventsForDay(day);
                          return Container(
                            margin: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${day.day}',
                                    style: TextStyle(
                                      color: focusedDay == day
                                          ? Colors.blue
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (events.isNotEmpty)
                                    Text(
                                      '${events.length}', // Muestra el número de citaciones
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                        fontSize: 14,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                final eventsForSelectedDay =
                    _getEventsForDay(_selectedDay ?? _focusedDay);

                if (eventsForSelectedDay.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'No hay eventos para este día',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }

                return Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: eventsForSelectedDay
                      .map((event) => SizedBox(
                            width: constraints.maxWidth > 600
                                ? 300
                                : constraints.maxWidth * 0.9,
                            child: CitacionTile(citacion: event),
                          ))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
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

class CitacionTile extends StatelessWidget {
  final Map<String, dynamic> citacion;
  final double maxWidth;

  const CitacionTile({
    super.key,
    required this.citacion,
    this.maxWidth = 400,
  });

  @override
  Widget build(BuildContext context) {
    return CardStyle.buildCard(
      onTap: () {},
      child: ExpandableCard.ExpandibleCard(
        title: 'Hora Inicio | ${citacion['horainicio']}',
        subtitle: _buildSubtitle(),
        expandedContent: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hora inicio: ${citacion['horainicio']}'),
              Text('Hora fin: ${citacion['horafin']}'),
              Text('Aprendiz: ${citacion['solicitud_data']['aprendiz']}'),
              Text('Instructor: ${citacion['solicitud_data']['responsable']}'),
              Text('Descripción: ${citacion['solicitud_data']['descripcion']}'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _showEditDialog(context, citacion);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Aplazar'),
                  ),
                  const SizedBox(width: 10),
                  // Aquí se decide qué botón mostrar según actarealizada
                  ElevatedButton(
                    onPressed: () {
                      if (citacion['actarealizada']) {
                        // Si actarealizada es true, mostrar "Acta a PDF"
                        _generatePdf(
                            citacion); // Suponiendo que tienes una función para generar el PDF
                      } else {
                        // Si actarealizada es false, mostrar "Acta"
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              content: SingleChildScrollView(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.9,
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.8,
                                  ),
                                  child: ActaForm(citacionId: citacion['id']),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text("Cerrar"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: citacion['actarealizada']
                          ? Colors.blue
                          : Colors.green, // Cambia el color según actarealizada
                    ),
                    child: Text(citacion['actarealizada'] ? 'PDF' : 'Acta'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _buildSubtitle() {
    final lugar = citacion['lugarcitacion'];
    final enlace = citacion['enlacecitacion'];
    return lugar == 'No aplica' ? 'Enlace: $enlace' : 'Lugar: $lugar';
  }

  void _generatePdf(Map<String, dynamic> citacion) {
    // Aquí implementas la lógica para generar el PDF con los datos de la citación
    print('Generando PDF para la citación: ${citacion['id']}');
  }

  // Función para mostrar el cuadro de diálogo de edición
  void _showEditDialog(BuildContext context, Map<String, dynamic> citacion) {
    TextEditingController horainicioController =
        TextEditingController(text: citacion['horainicio']);
    TextEditingController horafinController =
        TextEditingController(text: citacion['horafin']);
    TextEditingController enlacecitacionController =
        TextEditingController(text: citacion['enlacecitacion']);
    TextEditingController lugarcitacionController =
        TextEditingController(text: citacion['lugarcitacion']);
    DateTime selectedDate = DateTime.parse(citacion['diacitacion']);
    bool isVirtual = citacion['lugarcitacion'] == 'No aplica';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Citación'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // Seleccionar la fecha de citación
                ListTile(
                  title: const Text('Fecha de citación'),
                  trailing: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != selectedDate) {
                        selectedDate = pickedDate;
                      }
                    },
                  ),
                ),
                Text('Fecha seleccionada: ${selectedDate.toLocal()}'),

                // Hora de inicio
                ListTile(
                  title: const Text('Hora de inicio'),
                  trailing: IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            DateTime.parse(citacion['horainicio'])),
                      );
                      if (pickedTime != null) {
                        horainicioController.text = pickedTime.format(context);
                      }
                    },
                  ),
                ),
                TextField(
                  controller: horainicioController,
                  decoration: const InputDecoration(
                    labelText: 'Hora de inicio',
                    hintText: 'HH:mm',
                  ),
                  keyboardType: TextInputType.datetime,
                ),

                // Hora de fin
                ListTile(
                  title: const Text('Hora de fin'),
                  trailing: IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            DateTime.parse(citacion['horafin'])),
                      );
                      if (pickedTime != null) {
                        horafinController.text = pickedTime.format(context);
                      }
                    },
                  ),
                ),
                TextField(
                  controller: horafinController,
                  decoration: const InputDecoration(
                    labelText: 'Hora de fin',
                    hintText: 'HH:mm',
                  ),
                  keyboardType: TextInputType.datetime,
                ),

                // Opciones de cita: presencial o virtual
                ListTile(
                  title: const Text('Tipo de citación'),
                  trailing: DropdownButton<bool>(
                    value: isVirtual,
                    items: const [
                      DropdownMenuItem(
                        value: true,
                        child: Text('Virtual'),
                      ),
                      DropdownMenuItem(
                        value: false,
                        child: Text('Presencial'),
                      ),
                    ],
                    onChanged: (value) {
                      isVirtual = value!;
                      if (isVirtual) {
                        lugarcitacionController.text = 'No aplica';
                      } else {
                        enlacecitacionController.text = '';
                      }
                    },
                  ),
                ),

                // Campo de lugarcitacion si es presencial
                if (!isVirtual)
                  TextField(
                    controller: lugarcitacionController,
                    decoration: const InputDecoration(
                      labelText: 'Lugar de citación',
                    ),
                  ),

                // Campo de enlacecitacion si es virtual
                if (isVirtual)
                  TextField(
                    controller: enlacecitacionController,
                    decoration: const InputDecoration(
                      labelText: 'Enlace de citación',
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Actualizar citación
                _updateCitacion(
                  citacion['id'],
                  selectedDate,
                  horainicioController.text,
                  horafinController.text,
                  lugarcitacionController.text,
                  enlacecitacionController.text,
                );
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  // Función para actualizar la citación en el backend
  Future<void> _updateCitacion(
    int citacionId,
    DateTime diacitacion,
    String horainicio,
    String horafin,
    String lugarcitacion,
    String enlacecitacion,
  ) async {
    // Verifica si la citación es virtual o presencial y ajusta el payload
    final Map<String, dynamic> body = {
      'diacitacion': diacitacion.toIso8601String(),
      'horainicio': horainicio,
      'horafin': horafin,
      'lugarcitacion': lugarcitacion.isNotEmpty ? lugarcitacion : 'No aplica',
      'enlacecitacion': enlacecitacion.isNotEmpty ? enlacecitacion : '',
    };

    // Realizar la petición PATCH
    final response = await http.patch(
      Uri.parse('http://127.0.0.1:8000/api/Citacion/$citacionId/'),
      headers: {
        'Content-Type':
            'application/json', // Asegúrate de que el backend acepte JSON
      },
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      print('Citación actualizada con éxito');
    } else {
      print('Error al actualizar la citación: ${response.statusCode}');
      print('Respuesta: ${response.body}');
    }
  }
}