import 'package:comites/Dashboard/dashboard/funciones/citacion_calendario.dart';
import 'package:comites/Dashboard/main/components/appbar.dart';
import 'package:comites/Dashboard/main/components/side_menu.dart';
import 'package:comites/responsive.dart';
import 'package:flutter/material.dart';

class MainCalendario extends StatefulWidget {
  const MainCalendario({super.key});

  @override
  State<MainCalendario> createState() => _MainCalendarioState();
}

class _MainCalendarioState extends State<MainCalendario> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Key para controlar el menú

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Citar Comités', // Título del AppBar
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
              child: CalendarioCitaciones(), // Contenido principal
            ),
          ],
        ),
      ),
    );
  }
}
