// ignore_for_file: file_names

import 'package:comites/constantsDesign.dart';
import 'package:comites/responsive.dart';
import 'package:flutter/material.dart';

/// Widget que representa la sección de la misión en la app.
///
/// Esta clase extiende [StatefulWidget] y tiene un constructor vacío.
/// Tiene un estado [_MisionSectionState] que se encarga de manejar los datos de la pantalla.
class MisionSection extends StatefulWidget {
  /// Construye un widget de la sección de la misión.
  ///
  /// No recibe parámetros.
  const MisionSection({super.key});

  /// Crea el estado para este widget.
  ///
  /// Retorna un objeto [_MisionSectionState].
  @override
  State<MisionSection> createState() => _MisionSectionState();
}

class _MisionSectionState extends State<MisionSection> {
  @override
  Widget build(BuildContext context) {
    // Verifica si la pantalla es escritorio o tablet.
    return Responsive.isDesktop(context) || Responsive.isTablet(context)
        ? Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Misión y Visión SENA",
                    textAlign: TextAlign.center,
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
                          blurRadius: 3, // Radio de desenfoque de la sombra
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Misión",
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
                          "El SENA está  encargado de cumplir la función que le corresponde al Estado de invertir en el desarrollo social y técnico de los trabajadores colombianos, ofreciendo y ejecutando la formación profesional integral, para la incorporación y el desarrollo de las personas en actividades productivas que contribuyan al desarrollo social, económico y tecnológico del país (Ley 119/1994).",
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
                  Expanded(
                    child: SizedBox(
                      height: 400,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            child: Container(
                              width: 350,
                              height: 350,
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
                                  "assets/img/sena2.jpg",
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
                              width: 350,
                              height: 350,
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
                                  "assets/img/sena3.jpg",
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
                          "Visión",
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
                          "Para el año 2026, el Servicio Nacional de Aprendizaje - SENA estará a la vanguardia de la cualificación del talento humano, tanto a nivel nacional como internacional. Esto se logrará a través de la formación profesional integral, el empleo, el emprendimiento y el reconocimiento de aprendizajes previos. Nuestro objetivo es generar valor público y fortalecer la economía campesina, popular, verde y digital, siempre con un enfoque diferencial orientado a la construcción del cambio, la transformación productiva, la soberanía alimentaria y la consolidación de una paz total, materializando así la autonomía territorial, y promoviendo la justicia social, ambiental y económica.",
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
          // Pantalla si es dispositivo movil
        : Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Misión y Visión SENA",
                    textAlign: TextAlign.center,
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
                          blurRadius: 3, // Radio de desenfoque de la sombra
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Misión",
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
                              blurRadius: 3, // Radio de desenfoque de la sombra
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "El SENA está  encargado de cumplir la función que le corresponde al Estado de invertir en el desarrollo social y técnico de los trabajadores colombianos, ofreciendo y ejecutando la formación profesional integral, para la incorporación y el desarrollo de las personas en actividades productivas que contribuyan al desarrollo social, económico y tecnológico del país (Ley 119/1994).",
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
                              width: 350,
                              height: 350,
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
                                  "assets/img/sena2.jpg",
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
                      Text(
                        "Visión",
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
                              blurRadius: 3, // Radio de desenfoque de la sombra
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Para el año 2026, el Servicio Nacional de Aprendizaje - SENA estará a la vanguardia de la cualificación del talento humano, tanto a nivel nacional como internacional. Esto se logrará a través de la formación profesional integral, el empleo, el emprendimiento y el reconocimiento de aprendizajes previos. Nuestro objetivo es generar valor público y fortalecer la economía campesina, popular, verde y digital, siempre con un enfoque diferencial orientado a la construcción del cambio, la transformación productiva, la soberanía alimentaria y la consolidación de una paz total, materializando así la autonomía territorial, y promoviendo la justicia social, ambiental y económica.",
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
                              width: 350,
                              height: 350,
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
                                  "assets/img/sena3.jpg",
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
