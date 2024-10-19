// ignore_for_file: use_full_hex_values_for_flutter_colors, file_names


import 'package:comites/Dashboard/controllers/MenuAppController.dart';
import 'package:comites/Dashboard/main/components/main_bienvenida.dart';
import 'package:provider/provider.dart';
import 'package:comites/constantsDesign.dart';
import 'package:comites/provider.dart';
import 'package:comites/responsive.dart';
import 'package:flutter/material.dart';

import '../Auth/authScreen.dart';

/// Widget que representa una tarjeta de perfil de usuario.
///
/// Esta clase extiende [StatefulWidget] y se encarga de mostrar la foto
/// del usuario, nombre y apellido, y permite acceder a la pantalla principal del
/// usuario.
class ProfileCard extends StatefulWidget {
  /// Constructor por defecto.
  ///
  /// No requiere parámetros.
  const ProfileCard({super.key});

  /// Crea el estado para este widget.
  ///
  /// El estado se encarga de manejar los datos de la pantalla.
  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {

  @override
  Widget build(BuildContext context) {
    // Uso de Consumer para acceder al estado de la aplicación.
    return Consumer<AppState>(
      builder: (context, appState, _) {
        final usuarioAutenticado = appState.usuarioAutenticado;
        return InkWell(
          onTap: () {
            if (usuarioAutenticado != null) {
              // Navegar a la pantalla principal del usuario autenticado.
             Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainBienvenida(), // Reemplaza con la pantalla correspondiente
                    ),
                  ),
                );
            } else {
              // Navegar a la pantalla de inicio de sesión si no hay usuario autenticado.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            }
          },
          child: Container(
            // Contenedor que envuelve la tarjeta de perfil.
            margin: const EdgeInsets.only(left: defaultPadding),
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
              vertical: defaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFF2F0F2),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                if (usuarioAutenticado != null)
                  // Mostrar la imagen del usuario si está autenticado.
                  FutureBuilder(
                    future: null,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Icon(Icons.menu_open);
                      } else {
                        return Row(
                          children: [
                            
                            if (!Responsive.isMobile(context))
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: defaultPadding / 2),
                                child: Text(
                                  usuarioAutenticado.nombres,
                                  style: const TextStyle(color: primaryColor),
                                ),
                              ),
                          ],
                        );
                      }
                    },
                  )
                else
                  // Mostrar opción de iniciar sesión si no está autenticado.
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: 38,
                          height: 38,
                          color: primaryColor,
                          child: const Icon(
                            Icons.login,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (!Responsive.isMobile(context))
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: defaultPadding / 2),
                          child: Text(
                            "Iniciar Sesión",
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}


