// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
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
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/Citacion/'));
    if (response.statusCode == 200) {
      final List<dynamic> citaciones = json.decode(response.body);
      setState(() {
        _events = {};
        for (var citacion in citaciones) {
          final fecha = DateTime.parse(citacion['diacitacion']);
          if (_events[fecha] == null) _events[fecha] = [];
          _events[fecha]!.add(citacion);
        }
      });
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
            const Text(
              'Calendario de Comités',
              style: TextStyle(
                color: Colors.blue, // Cambia esto por tu color primario
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
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
                        // Asegúrate de que esto esté desactivado
                        markersMaxCount: 0, // Esto desactiva los puntos de eventos
                      ),
                      // Agrega este builder para personalizar los días
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
                                      color: focusedDay == day ? Colors.blue : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (events.isNotEmpty)
                                    Text(
                                      '${events.length}', // Muestra el número de citaciones
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green, // Cambia el color según tu preferencia
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
           Wrap(
            alignment: WrapAlignment.start,
            spacing: 10.0, // Espacio entre las tarjetas
            runSpacing: 10.0, // Espacio entre las filas de tarjetas
            children: _getEventsForDay(_selectedDay ?? _focusedDay)
                .map((event) => CitacionTile(citacion: event))
                .toList(),
          ),
          ],
        ),
      ),
    );
  }
}

class CitacionTile extends StatelessWidget {
  final Map<String, dynamic> citacion;
  final maxWidth;

  const CitacionTile({
    super.key,
    required this.citacion,
    this.maxWidth = 400,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListTile(
          title: Text('Citación #${citacion['id']}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Fecha: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(citacion['diacitacion']))}'),
              Text('Hora: ${citacion['horacitacion']}'),
              Text('Lugar: ${citacion['lugarcitacion']}'),
              Text('Enlace: ${citacion['enlacecitacion']}'),
              Text('Descripción: ${citacion['solicitud_data']['descripcion']}'),
            ],
          ),
          isThreeLine: true,
          onTap: () {
            // Aquí puedes agregar una acción al tocar la citación, como mostrar más detalles
          },
        ),
      ),
    );
  }
}
