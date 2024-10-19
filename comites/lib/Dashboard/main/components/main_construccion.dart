import 'package:comites/Dashboard/dashboard/dashboard_construccion.dart';
import 'package:comites/Dashboard/main/components/appbar.dart';
import 'package:comites/Dashboard/main/components/side_menu.dart';
import 'package:comites/responsive.dart';
import 'package:flutter/material.dart';

class MainConstruccion extends StatefulWidget {
  const MainConstruccion({super.key});

  @override
  State<MainConstruccion> createState() => _MainConstruccionState();
}

class _MainConstruccionState extends State<MainConstruccion> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Key para controlar el menú

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'En Construcción', // Título del AppBar
        scaffoldKey: _scaffoldKey, // Key para abrir el menú desde el ícono
      ),
      drawer: const SideMenu(), // Menú lateral
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context)) 
              const Expanded(child: SideMenu()), // Menú en escritorio

            const Expanded(
              flex: 5,
              child: DashboardConstruccion(), // Contenido principal
            ),
          ],
        ),
      ),
    );
  }
}
