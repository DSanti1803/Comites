// ignore_for_file: library_private_types_in_public_api, file_names

import 'dart:async';
import 'package:comites/Home/profileCard.dart';
import 'package:provider/provider.dart';
import 'package:comites/Chatbot/chatBot.dart';
import 'package:comites/Home/logoSection.dart';
import 'package:comites/Home/misionSection.dart';
import 'package:comites/Home/senaSection.dart';
import 'package:comites/constantsDesign.dart';
import 'package:comites/provider.dart';
import 'package:comites/responsive.dart';
import 'package:flutter/material.dart';

/// Clase del widget de la pantalla principal de la aplicación.
///
/// Esta clase extiende [StatefulWidget] y proporciona un estado asociado
/// [_HomePageState].
class HomePage extends StatefulWidget {
  /// Constructor sin parámetros obligatorios.
  ///
  /// Utiliza el constructor de [super] para inicializar la clase.
  const HomePage({super.key});

  /// Crea y devuelve un estado [_HomePageState] para manejar los datos de la pantalla.
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  /// Indica si la sección secundaria de la pantalla está visible.
  ///
  /// Es `true` si la sección secundaria está visible, de lo contrario es `false`.
  /// Por defecto su valor es `false`.
  ///
  /// Esta variable se utiliza para manejar la visibilidad de la sección secundaria
  /// de la pantalla principal.
  ///
  /// Esta variable se utiliza en la implementación del método [_toggleSecondary]
  /// para alternar la visibilidad de la sección secundaria.
  ///
  /// Esta variable se utiliza en la implementación del método [_buildBody] para
  /// determinar si se debe mostrar la sección secundaria o no.
  bool secundaria = false;

  /// La futura lista de datos que se obtiene de la llamada a la función [_fetchData].
  ///
  /// Esta variable se utiliza para almacenar los datos obtenidos de la fuente de datos.
  /// La variable es de tipo [Future<List<dynamic>>] para indicar que se trata de una llamada asíncrona.

  /// Lista de URLs de imágenes.
  ///
  /// Esta lista contiene las URLs de las imágenes que se utilizarán para el fondo de pantalla.
  final List<String> imageUrls = [
    'assets/img/fondo1.jpg',
    'assets/img/fondo2.jpg',
    'assets/img/fondo3.jpg',
    'assets/img/fondo4.jpg',
  ];

  /// Índice de la imagen actual.
  ///
  /// Esta variable se utiliza para almacenar el índice de la imagen actual que se está mostrando.
  /// El valor inicial es 0, lo que indica que se está mostrando la primera imagen.
  int _currentIndex = 0;

  /// Controlador de animación.
  ///
  /// Esta variable se utiliza para controlar la animación de desplazamiento horizontal
  /// de las imágenes en el fondo de pantalla.
  late AnimationController _controller;

  /// Animación de desplazamiento horizontal.
  ///
  /// Esta variable se utiliza para almacenar la animación que controla el desplazamiento horizontal
  /// de las imágenes en el fondo de pantalla.
  late Animation<Offset> _offsetAnimation;

  @override

  /// Se llama cuando se crea el [HomePageState] por primera vez.
  ///
  /// Inicializa la variable [_datosFuture] llamando a [_fetchData] y
  /// configura el ciclo de cambio de imágenes.
  /// También configura la animación para el desplazamiento horizontal de las imágenes.
  @override
  void initState() {
    super.initState();

    // Inicializar la futura lista de datos

    // Iniciar el ciclo de cambio de imágenes
    startImageSlideShow();

    // Configurar la animación
    _controller = AnimationController(
      vsync:
          this, // Sincronizar la animación con la frecuencia de actualización de la pantalla
      duration: const Duration(
          milliseconds: 500), // Duracion de la animación en milisegundos
    );

    // Configurar la animación de desplazamiento horizontal
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero, // Posición inicial
      end: const Offset(0.0,
          0.05), // Posición final: 5% del tamaño de la pantalla hacia arriba
    ).animate(CurvedAnimation(
      parent: _controller, // Animación padre
      curve: Curves.easeInOut, // Curva de animación: inicio lento, final rápido
    ));

    // Repetir la animación de forma inversa, creando un movimiento de onda
    _controller.repeat(reverse: true);
  }

  /// Inicia un ciclo de cambio de imágenes en el fondo de la pantalla.
  ///
  /// Cada 3 segundos se cambia a la siguiente imagen en la lista de [imageUrls].
  /// Si se ha alcanzado el último elemento, se vuelve a la primera.
  void startImageSlideShow() {
    // Esperar 3 segundos y luego cambiar la imagen actual
    Future.delayed(const Duration(seconds: 3), () {
      // Actualizar el estado del widget para mostrar la siguiente imagen en la lista
      setState(() {
        // Incrementar el índice de la imagen actual y reiniciarlo a 0 si se ha alcanzado el final
        _currentIndex = (_currentIndex + 1) % imageUrls.length;
      });

      // Reiniciar el ciclo de cambio de imágenes
      startImageSlideShow();
    });
  }
 
  @override

  /// Libera los recursos utilizados por la animación.
  ///
  /// Se llama automáticamente cuando se elimina el widget.
  /// Se debe llamar a [dispose] para liberar los recursos utilizados por la animación.
  /// Finalmente, se llama al método [dispose] del padre para liberar recursos adicionales.
  void dispose() {
    // Liberar recursos de la animación
    _controller.dispose();

    // Liberar recursos del padre
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Consumer por si se necesita acceder al estado
    return Consumer<AppState>(builder: (context, appState, _) {
      return Scaffold(
        body: Stack(
          children: [
            // Fondo con imágenes que cambian
            AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: Image.asset(
                imageUrls[_currentIndex], // URL de la imagen actual
                key: ValueKey<String>(
                    imageUrls[_currentIndex]), // Key única para la animación
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),

            // Capa verde semitransparente
            Container(
              color: primaryColor.withOpacity(
                  0.5), // Ajusta el nivel de opacidad según sea necesario
              width: double.infinity,
              height: double.infinity,
            ),

            // Logo y texto
            // Verificación si la variable secundaria es false para mostrar el logo y titulo inicial
            if (secundaria == false)
              // Si el dispositivo es escritorio
              Responsive.isDesktop(context)
                  ? Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Logo
                            SizedBox(
                              width: MediaQuery.of(context).size.width *
                                  0.2, // 20% del ancho de la pantalla
                              height: MediaQuery.of(context).size.width *
                                  0.2, // 20% del ancho de la pantalla
                              // Coloca aquí tu imagen de logo
                              child: Image.asset('assets/img/logo.png'),
                            ),

                            const SizedBox(width: 20),

                            // Texto
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Centro de Biotecnología Agropecuaria',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.06,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Calibri-Bold",
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
                                  const SizedBox(height: 5),
                                  Text(
                                    'SENA Mosquera',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: MediaQuery.of(context)
                                              .size
                                              .width *
                                          0.06, // 6% del ancho de la pantalla
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Calibri-Bold",
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
                      ),
                    )
                  // Si el dispositivo es movil o tablet
                  : Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Títulos
                            Text(
                              'Centro de Biotecnología Agropecuaria',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: MediaQuery.of(context).size.width *
                                    0.06, // 6% del ancho de la pantalla
                                fontWeight: FontWeight.bold,
                                fontFamily: "Calibri-Bold",
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
                            const SizedBox(height: 5),
                            Text(
                              'SENA Mosquera',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: MediaQuery.of(context).size.width *
                                    0.06, // 6% del ancho de la pantalla
                                fontWeight: FontWeight.bold,
                                fontFamily: "Calibri-Bold",
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
                            const SizedBox(height: 20),

                            // Logo
                            SizedBox(
                              width: MediaQuery.of(context).size.width *
                                  0.2, // 20% del ancho de la pantalla
                              height: MediaQuery.of(context).size.width *
                                  0.2, // 20% del ancho de la pantalla

                              // Coloca aquí tu imagen de logo
                              child: Image.asset('assets/img/logo.png'),
                            ),
                          ],
                        ),
                      ),
                    ),

            // Contenido
            // Si la variable secundaria es verdadera, se muestra el contenido.
            if (secundaria == true)
              Positioned(
                top: 130,
                left: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Sección de Anuncios
                          Text(
                            'Anuncios',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Calibri-Bold',
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: const Offset(2, 2),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                          ),
                          // Lista de Anuncios
                          
                          const SizedBox(
                            height: defaultPadding,
                          ),

                          const SizedBox(
                            height: defaultPadding,
                          ),
                          // Sección de la SENA
                          const SenaSection(),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                          // Sección de la Misión
                          const MisionSection(),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                          // Sección del Logo
                          const LogoSection(),
                          const SizedBox(
                            height: defaultPadding,
                          ),

                          const SizedBox(
                            height: defaultPadding,
                          ),
                          // Texto de derechos de autor
                          Center(
                            child: Text(
                              '©SENA 2024',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Calibri-Bold',
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.5),
                                    offset: const Offset(2, 2),
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            // Iconos en la parte superior derecha
            // Posiciónamiento del contenido en la parte superior derecha
            // de la pantalla.
             Positioned(
              top: 40,
              right: 20,
              child: Row(
                children: [
                  const SizedBox(width: 20), // Espacio entre elementos
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white, // Fondo blanco
                      borderRadius: BorderRadius.all(Radius.circular(10)), // Bordes redondeados
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26, // Sombra suave para darle relieve
                          blurRadius: 5,
                          offset: Offset(0, 2), // Desplazamiento de la sombra
                        ),
                      ],
                    ),
                    
                  ),
                  const ProfileCard()
                ],
              ),
            ),
            


            // Si la variable secundaria es true muestra este logo
            if (secundaria == true)
              Positioned(
                top: 40,
                left: 20,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Cambia la variable secundaria a false
                        setState(() {
                          secundaria = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor.withOpacity(0.5),
                        ),
                        // Coloca aquí tu imagen de logo
                        child: Image.asset('assets/img/logo.png'),
                      ),
                    ),
                  ],
                ),
              ),

            // Icono de subir
            // Si la variable secundaria es false muestra este icono en la parte inferior.
            // Sirve para cambiar el valor de la variable secundaria y cambiar la vista del home.
            if (secundaria == false)
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: SlideTransition(
                  position: _offsetAnimation,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_upward,
                          color: Colors.green, size: 30),
                      onPressed: () {
                        // Aquí puedes añadir la lógica para ir hacia arriba
                        // Cambia la varible secundaria a true
                        setState(() {
                          secundaria = true;
                        });
                      },
                    ),
                  ),
                ),
              ),

            Positioned(
                bottom: 10,
                right: 10,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatBot()),
                    );
                  },
                  child: const Icon(Icons.support_agent),
                )),
          ],
        ),
      );
    });
  }
}
