// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api
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

        // Asegúrate de que `aprendiz` y `responsable` sean int extrayendo el primer elemento de la lista
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
    final eventsForSelectedDay = _getEventsForDay(_selectedDay ?? _focusedDay);

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
              Text(
                'Hora inicio: ${citacion['horainicio']}',
                style: const TextStyle(color: Colors.black),
              ),
              Text(
                'Hora fin: ${citacion['horafin']}',
                style: const TextStyle(color: Colors.black),
              ),
              Text(
                'Aprendiz: ${citacion['solicitud_data']['aprendiz']}',
                style: const TextStyle(color: Colors.black),
              ),
              Text(
                'Instructor: ${citacion['solicitud_data']['responsable']}',
                style: const TextStyle(color: Colors.black),
              ),
              Text(
                'Descripción: ${citacion['solicitud_data']['descripcion']}',
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Acción para aplazar
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Aplazar'),
                  ),
                  const SizedBox(width: 10),
                 ElevatedButton(
                    onPressed: () {
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
                                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                                  maxHeight: MediaQuery.of(context).size.height * 0.8,
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
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Acta'),
                  )
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
}
