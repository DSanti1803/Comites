import 'package:comites/Dashboard/main/components/appbar.dart';
import 'package:comites/Dashboard/main/components/side_menu.dart';
import 'package:comites/constantsDesign.dart';
import 'package:comites/responsive.dart';
import 'package:flutter/material.dart';

class MainBienvenida extends StatefulWidget {
  const MainBienvenida({super.key});

  @override
  State<MainBienvenida> createState() => _MainBienvenidaState();
}

class _MainBienvenidaState extends State<MainBienvenida> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Key para el Scaffold

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Bienvenido', // Título del AppBar
        scaffoldKey: _scaffoldKey, // Controla la apertura del menú
      ),
      drawer: const SideMenu(), // Menú lateral
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context)) const Expanded(child: SideMenu()),

            const Expanded(
              flex: 5,
              child: BienvenidaContent(), // Contenido principal
            ),
          ],
        ),
      ),
    );
  }
}

class BienvenidaContent extends StatelessWidget {
  const BienvenidaContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '¡Bienvenido a ComitApp el Sistema de Comités Académicos!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Este aplicativo está diseñado para gestionar los comités académicos realizados en el CBA de Mosquera. Aquí podrás realizar varios procesos dependiendo de tu rol dentro del centro de formacion.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
