// ignore_for_file: use_full_hex_values_for_flutter_colors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comites/Dashboard/controllers/MenuAppController.dart';
import 'package:comites/provider.dart';
import 'package:comites/responsive.dart';

// Header el cual tendra el buscador y una card identificativa del usuario que este usando el aplicativo

/// Widget que representa la barra de encabezado de la aplicación, que contiene
/// un buscador y una tarjeta de identificación del usuario autenticado.
///
/// Este widget es un [StatefulWidget] y delega la creación del estado en su
/// [_HeaderState].
class Header extends StatefulWidget {
  /// Crea una nueva instancia de [Header].
  ///
  /// No tiene parámetros.
  const Header({
    super.key, // Clave única para identificar este widget.
  });

  @override
  // Miembro que crea y devuelve una nueva instancia de [_HeaderState].
  //
  // No tiene parámetros.
  // Devuelve una nueva instancia de [_HeaderState].
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    // Retorna un widget que muestra el encabezado de la aplicación.
    //
    // El widget retornado es un Row que contiene un botón de menú
    // Además, muestra una tarjeta de identificación del usuario autenticado.
    return Consumer<AppState>(builder: (context, appState, _) {
      // Obtiene el usuario autenticado del estado de la aplicación.
      final usuarioAutenticado = appState.usuarioAutenticado;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Si no estamos en una pantalla de escritorio, muestra un
          // botón de menú.
          if (!Responsive.isDesktop(context))
            IconButton(
              icon: const Icon(Icons.menu),
              // Abre el menú de la aplicación.
              onPressed: context.read<MenuAppController>().controlMenu,
            ),

          

          // Si estamos en una pantalla de escritorio, agrega espacio
          // adicional al lado derecho del encabezado.
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),

        ],
      );
    });
  }
}

