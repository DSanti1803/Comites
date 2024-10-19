// ignore_for_file: unnecessary_null_comparison

import 'package:comites/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardConstruccion extends StatefulWidget {
  const DashboardConstruccion ({super.key});

  @override
  State<DashboardConstruccion> createState() => _DashboardConstruccionState();
}

class _DashboardConstruccionState extends State<DashboardConstruccion> {

@override
   Widget build(BuildContext context) {
    // Carga el estado del aplicativo
    return Consumer<AppState>(builder: (context, appState, _) {
      // Carga el usuario autenticado
      if (appState == null || appState.usuarioAutenticado == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return SafeArea(
        child: ListView(
          primary: false,
          padding: const EdgeInsets.only(
            left: 30.0, right: 30.0, top: 16.0, bottom: 16.0
          ),
          scrollDirection: Axis.vertical,
          children:  [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Image.asset('assets/icons/construccion.png', width: 300,),
                const SizedBox(height: 100),
                const Text('Ten paciencia', style: TextStyle(fontSize: 30),),
                const SizedBox(height: 30,),
                const Text('!Pronto estará disponible esta función¡', style: TextStyle(fontSize: 30),),
                const SizedBox(height: 30,)
              ],
            )
          ],


      ));

    }
  );
 }
}