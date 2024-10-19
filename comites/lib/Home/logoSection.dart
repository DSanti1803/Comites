// ignore_for_file: file_names

import 'package:comites/constantsDesign.dart';
import 'package:comites/responsive.dart';
import 'package:flutter/material.dart';

/// Esta clase representa una sección de la pantalla de inicio que muestra el logo de la tienda.
///
/// Esta clase extiende [StatefulWidget] y tiene un único método obligatorio:
/// [createState] que crea un estado [_LogoSectionState] para manejar los datos de la pantalla.
class LogoSection extends StatefulWidget {
  /// Crea un nuevo objeto [LogoSection].
  ///
  /// No tiene parámetros obligatorios.
  const LogoSection({super.key});

  /// Crea un nuevo estado [_LogoSectionState] para manejar los datos de la pantalla.
  ///
  /// No tiene parámetros obligatorios.
  @override
  State<LogoSection> createState() => _LogoSectionState();
}

class _LogoSectionState extends State<LogoSection> {
  @override
  Widget build(BuildContext context) {
    // Verifica si la pantalla es escritorio o tableta.
    return Responsive.isDesktop(context) || Responsive.isTablet(context)
        ? Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Escudo y Bandera",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Calibri-Bold',
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(
                                    0.5), // Color y opacidad de la sombra
                                offset: const Offset(2,
                                    2), // Desplazamiento de la sombra (horizontal, vertical)
                                blurRadius:
                                    3, // Radio de desenfoque de la sombra
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "El escudo y la bandera del SENA, fueron diseñados cuando se fundó nuestra institución y reflejan los tres sectores económicos dentro de los cuales operamos:",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(
                                        0.5), // Color y opacidad de la sombra
                                    offset: const Offset(2,
                                        2), // Desplazamiento de la sombra (horizontal, vertical)
                                    blurRadius:
                                        3, // Radio de desenfoque de la sombra
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                                height:
                                    10), // Espacio entre el primer texto y la lista con viñetas
                            Text(
                              "• El piñón, representativo del sector industria.",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(
                                        0.5), // Color y opacidad de la sombra
                                    offset: const Offset(2,
                                        2), // Desplazamiento de la sombra (horizontal, vertical)
                                    blurRadius:
                                        3, // Radio de desenfoque de la sombra
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "• El caduceo, asociado al de comercio y servicios.",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(
                                        0.5), // Color y opacidad de la sombra
                                    offset: const Offset(2,
                                        2), // Desplazamiento de la sombra (horizontal, vertical)
                                    blurRadius:
                                        3, // Radio de desenfoque de la sombra
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "• El café, ligado al primario y extractivo.",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(
                                        0.5), // Color y opacidad de la sombra
                                    offset: const Offset(2,
                                        2), // Desplazamiento de la sombra (horizontal, vertical)
                                    blurRadius:
                                        3, // Radio de desenfoque de la sombra
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 400,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            child: Container(
                              width: 250,
                              height: 250,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/img/escudo.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 400,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            child: Container(
                              width: 250,
                              height: 250,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/img/logo.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Logosímbolo",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Calibri-Bold',
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(
                                    0.5), // Color y opacidad de la sombra
                                offset: const Offset(2,
                                    2), // Desplazamiento de la sombra (horizontal, vertical)
                                blurRadius:
                                    3, // Radio de desenfoque de la sombra
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "El logosímbolo representa gráficamente los enfoques de la formación que impartimos en la que el individuo es el responsable de su propio proceso de aprendizaje. ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(
                                    0.5), // Color y opacidad de la sombra
                                offset: const Offset(2,
                                    2), // Desplazamiento de la sombra (horizontal, vertical)
                                blurRadius:
                                    3, // Radio de desenfoque de la sombra
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
        // Pantalla en caso de que el dispositivo sea móvil.
        : Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Escudo y Bandera",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Calibri-Bold',
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(
                                    0.5), // Color y opacidad de la sombra
                                offset: const Offset(2,
                                    2), // Desplazamiento de la sombra (horizontal, vertical)
                                blurRadius:
                                    3, // Radio de desenfoque de la sombra
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "El escudo y la bandera del SENA, fueron diseñados cuando se fundó nuestra institución y reflejan los tres sectores económicos dentro de los cuales operamos:",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(
                                      0.5), // Color y opacidad de la sombra
                                  offset: const Offset(2,
                                      2), // Desplazamiento de la sombra (horizontal, vertical)
                                  blurRadius:
                                      3, // Radio de desenfoque de la sombra
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                              height:
                                  10), // Espacio entre el primer texto y la lista con viñetas
                          Text(
                            "• El piñón, representativo del sector industria.",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(
                                      0.5), // Color y opacidad de la sombra
                                  offset: const Offset(2,
                                      2), // Desplazamiento de la sombra (horizontal, vertical)
                                  blurRadius:
                                      3, // Radio de desenfoque de la sombra
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "• El caduceo, asociado al de comercio y servicios.",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(
                                      0.5), // Color y opacidad de la sombra
                                  offset: const Offset(2,
                                      2), // Desplazamiento de la sombra (horizontal, vertical)
                                  blurRadius:
                                      3, // Radio de desenfoque de la sombra
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "• El café, ligado al primario y extractivo.",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(
                                      0.5), // Color y opacidad de la sombra
                                  offset: const Offset(2,
                                      2), // Desplazamiento de la sombra (horizontal, vertical)
                                  blurRadius:
                                      3, // Radio de desenfoque de la sombra
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Center(
                    child: SizedBox(
                      height: 400,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            child: Container(
                              width: 250,
                              height: 250,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/img/escudo.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Logosímbolo",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Calibri-Bold',
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(
                                    0.5), // Color y opacidad de la sombra
                                offset: const Offset(2,
                                    2), // Desplazamiento de la sombra (horizontal, vertical)
                                blurRadius:
                                    3, // Radio de desenfoque de la sombra
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "El logosímbolo representa gráficamente los enfoques de la formación que impartimos en la que el individuo es el responsable de su propio proceso de aprendizaje. ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(
                                  0.5), // Color y opacidad de la sombra
                              offset: const Offset(2,
                                  2), // Desplazamiento de la sombra (horizontal, vertical)
                              blurRadius: 3, // Radio de desenfoque de la sombra
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Center(
                    child: SizedBox(
                      height: 400,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            child: Container(
                              width: 250,
                              height: 250,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/img/logo.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
