import 'package:comites/Dashboard/dashboard/funciones/procesos_coordinacion.dart';
import 'package:comites/Dashboard/main/components/appbar.dart';
import 'package:comites/Dashboard/main/components/side_menu.dart';
import 'package:comites/responsive.dart';
import 'package:flutter/material.dart';

class MainProcesosCoordinacion extends StatefulWidget {
  const MainProcesosCoordinacion({super.key});

  @override
  State<MainProcesosCoordinacion> createState() => _MainProcesosCoordinacionState();
}

class _MainProcesosCoordinacionState extends State<MainProcesosCoordinacion> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Key para controlar el menú

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Procesos Coordinación', // Título del AppBar
        scaffoldKey: _scaffoldKey, // Pasa la key para abrir el menú
      ),
      drawer: const SideMenu(), // Drawer para el menú lateral
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menú lateral visible solo en escritorio
            if (Responsive.isDesktop(context)) 
              const Expanded(child: SideMenu()),
            const Expanded(
              flex: 5,
              child: SolicitudesCoordinacion(), // Contenido principal
            ),
          ],
        ),
      ),
    );
  }
}
