import 'package:comites/Dashboard/main/components/appbar.dart';
import 'package:flutter/material.dart';
import 'package:comites/Dashboard/main/components/side_menu.dart';
import 'package:comites/responsive.dart';

class MainAprendiz extends StatefulWidget {
  const MainAprendiz({super.key});

  @override
  State<MainAprendiz> createState() => _MainAprendizState();
}

class _MainAprendizState extends State<MainAprendiz> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Panel Aprendiz',
        scaffoldKey: _scaffoldKey, // Pasa la key al AppBar
      ),
      drawer: const SideMenu(), // Menú lateral
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(child: SideMenu()), // Menú siempre visible en escritorio
            const Expanded(
              flex: 5,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '¡Bienvenido, Aprendiz!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'En este sistema puedes realizar las siguientes acciones:',
                        style: TextStyle(fontSize: 20, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(
                        '- Realizar solicitudes\n'
                        '- Subir planes de mejoramiento\n'
                        '- Calificar planes de mejoramiento\n'
                        '- Ver estadísticas de tus procesos',
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
