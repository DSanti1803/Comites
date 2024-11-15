// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';

class AceptarSolicitudes extends StatefulWidget {
  const AceptarSolicitudes({super.key});

  @override
  _AceptarSolicitudesState createState() => _AceptarSolicitudesState();
}

class _AceptarSolicitudesState extends State<AceptarSolicitudes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aceptar Solicitudes'),
      ),
      body: const Center(
        child: Text('Contenido pendiente de implementar'),
      ),
    );
  }
}
