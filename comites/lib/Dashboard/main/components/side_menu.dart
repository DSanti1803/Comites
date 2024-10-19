// ignore_for_file: unnecessary_null_comparison

import 'package:comites/Dashboard/main/Main_Funciones/main_calendario.dart';
import 'package:comites/Dashboard/main/Main_Funciones/main_procesos_coordinacion.dart';
import 'package:comites/Dashboard/main/Main_Funciones/main_procesos_realizados.dart';
import 'package:comites/Dashboard/main/components/main_construccion.dart';
import 'package:comites/Dashboard/main/Main_Roles/main_abogado.dart';
import 'package:comites/Dashboard/main/Main_Roles/main_aprendiz.dart';
import 'package:comites/Dashboard/main/Main_Roles/main_bienestar.dart';
import 'package:comites/Dashboard/main/Main_Funciones/main_citacion.dart';
import 'package:comites/Dashboard/main/Main_Roles/main_coordinador.dart';
import 'package:comites/Dashboard/main/Main_Roles/main_intructor.dart';
import 'package:comites/Dashboard/main/Main_Funciones/main_solicitud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:comites/Dashboard/controllers/MenuAppController.dart';
import 'package:comites/Home/homePage.dart';
import 'package:comites/constantsDesign.dart';
import 'package:comites/provider.dart';

/// Un widget que representa el menú lateral de la aplicación.
///
/// Este widget está diseñado para mostrar el menú lateral de la aplicación y
/// cambiar de pantalla según la opción seleccionada.
///
/// El constructor de este widget no recibe ningún parámetro.
class SideMenu extends StatefulWidget {
  /// Constructor por defecto del widget [SideMenu].
  ///
  /// No recibe ningún parámetro.
  const SideMenu({
    super.key,
  });

  /// Crea el estado asociado a este widget.
  ///
  /// Devuelve un nuevo estado [_SideMenuState].
  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  /// Construye el widget del drawer basado en el estado de la aplicación.
  ///
  /// Muestra diferentes opciones de navegación dependiendo del rol y la autenticación del usuario.
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (BuildContext context, AppState appState, _) {
        if (appState == null || appState.usuarioAutenticado == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final usuarioAutenticado = appState.usuarioAutenticado;

        return Drawer(
        child: ListView(
          children: [

      // Encabezado del Drawer con el logo
      DrawerHeader(
        child: Center(
          child: ClipOval(
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor,
              ),
              child: Image.asset(
                "assets/img/logo.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      // Opción de Inicio
      DrawerListTile(
        title: "Inicio",
        svgSrc: "assets/icons/home.svg",
        press: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (context) => MenuAppController())
                ],
                child: const HomePage(),
              ),
            ),
          );
        },
      ),
      // Panel de Aprendiz
      if (usuarioAutenticado != null && usuarioAutenticado.rol1 == "APRENDIZ")
        Column(
          children: [
            DrawerListTile(
              title: "Panel Aprendiz",
              svgSrc: "assets/icons/aprendiz.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainAprendiz(),
                    ),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Procesos",
              svgSrc: "assets/icons/aprendiz.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainConstruccion(), 
                    ),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Plan de Mejoramiento",
               svgSrc: "assets/icons/abogado.svg",
                press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainConstruccion(), 
                    ),
                  ),
                );
              },
                )
          ],
        ),


        //INICIO INSTRUCTOR

      if (usuarioAutenticado != null && usuarioAutenticado.rol1 == "INSTRUCTOR")
        Column(
          children: [
            DrawerListTile(
              title: "Panel Instructor",
              svgSrc: "assets/icons/instructor.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainInstructor(),
                    ),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Realizar Solicitud",
              svgSrc: "assets/icons/solicitud.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainSolicitud(),  
                    ),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Procesos Realizados",
              svgSrc: "assets/icons/construccion.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainProcesosRealizados(), 
                    ),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Subir Plan de Mejoramiento",
              svgSrc: "assets/icons/construccion.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainConstruccion(), 
                    ),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Calificar Plan de Mejoramiento",
              svgSrc: "assets/icons/construccion.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainConstruccion(), 
                    ),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Estadisticas",
              svgSrc: "assets/icons/estadisticas.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainConstruccion(), 
                    ),
                  ),
                );
              },
            ),
          ],
        ),


        //FINAL INSTRUCTOR




      // INICIO ABOGADO




      if (usuarioAutenticado != null && usuarioAutenticado.rol1 == "ABOGADO")
        Column(
          children: [
            DrawerListTile(
              title: "Panel Abogado",
              svgSrc: "assets/icons/abogado.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainAbogado(),
                    ),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Generar Actas",
              svgSrc: "assets/icons/aprendiz.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainConstruccion(), 
                    ),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Estadisticas",
              svgSrc: "assets/icons/construccion.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainConstruccion(), 
                    ),
                  ),
                );
              },
            ),
          ],
        ),


        //FINAL ABOGADO



      // INICIO COORDINADOR



      if (usuarioAutenticado != null && usuarioAutenticado.rol1 == "COORDINADOR")
        Column(
          children: [
            DrawerListTile(
              title: "Panel Coordinador",
              svgSrc: "assets/icons/coordinador.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainCoordinador(),
                    ),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Agendar Comite",
              svgSrc: "assets/icons/agendar.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainCitaciones(), 
                    ),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Ver Procesos",
              svgSrc: "assets/icons/construccion.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainProcesosCoordinacion(), 
                    ),
                  ),
                );
              },
            ),
             DrawerListTile(
              title: "Calendario",
              svgSrc: "assets/icons/calendar.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainCalendario(), 
                    ),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Estadisticas",
              svgSrc: "assets/icons/estadisticas.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainConstruccion(), 
                    ),
                  ),
                );
              },
            ),
          ],
        ),



        //FINAL COORDINADOR




      // INICIO BIENESTAR



      if (usuarioAutenticado != null && usuarioAutenticado.rol1 == "BIENESTAR")
        Column(
          children: [
            DrawerListTile(
              title: "Panel Bienestar",
              svgSrc: "assets/icons/bienestar.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainBienestar(),
                    ),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Realizar Solicitud",
              svgSrc: "assets/icons/aprendiz.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainSolicitud(), 
                    ),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Ver Procesos",
              svgSrc: "assets/icons/construccion.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainConstruccion(), 
                    ),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Subir Plan de Mejoramiento",
              svgSrc: "assets/icons/construccion.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainConstruccion(), 
                    ),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Calificar Plan de Mejoramiento",
              svgSrc: "assets/icons/construccion.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainConstruccion(), 
                    ),
                  ),
                );
              },
            ),
            DrawerListTile(
              title: "Estadisticas",
              svgSrc: "assets/icons/estadisticas.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => MenuAppController())
                      ],
                      child: const MainConstruccion(), 
                    ),
                  ),
                );
              },
            ),


            //FINAL BIENESTAR



          ],
        ),
      // Opción para cerrar sesión
      DrawerListTile(
        title: "Cerrar Sesión",
        svgSrc: "assets/icons/logout.svg",
        press: () {
          logout(context);
        },
      ),
    ],
  ),
);

      },
    );
  }
}

/// Muestra un diálogo para confirmar si el usuario desea cerrar sesión.
///
/// [context] es el contexto de la aplicación donde se mostrará el diálogo.
void logout(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        // Título del diálogo
        title: const Text("¿Seguro que quiere cerrar sesión?"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Contenedor circular con la imagen del logo de la aplicación
            ClipOval(
              child: Container(
                width: 100, // Ajusta el tamaño según sea necesario
                height: 100, // Ajusta el tamaño según sea necesario
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor,
                ),
                // Muestra la imagen del logo en el contenedor.
                child: Image.asset(
                  "assets/img/logo.png",
                  fit: BoxFit.cover, // Ajusta la imagen al contenedor
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              // Botón para cancelar la operación.
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: _buildButton("Cancelar", () {
                  Navigator.pop(context);
                }),
              ),
              // Botón para salir de la sesión.
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: _buildButton("Salir", () {
                  Navigator.pop(context);
                  Provider.of<AppState>(context, listen: false).logout();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                }),
              )
            ],
          ),
        ],
      );
    },
  );
}

/// Construye un botón con los estilos de diseño especificados.
///
/// El parámetro [text] es el texto que se mostrará en el botón.
/// El parámetro [onPressed] es la función que se ejecutará cuando se presione el botón.
///
/// Devuelve un widget [Container] que contiene un widget [Material] con un estilo específico.
Widget _buildButton(String text, VoidCallback onPressed) {
  // Contenedor con un ancho fijo de 200 píxeles y una apariencia personalizada
  // con un borde redondeado, un gradiente de colores y una sombra.
  return Container(
    width: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10), // Borde redondeado.
      gradient: const LinearGradient(
        colors: [
          botonClaro, // Color claro del gradiente.
          botonOscuro, // Color oscuro del gradiente.
        ],
      ),
      boxShadow: const [
        BoxShadow(
          color: botonSombra, // Color de la sombra.
          blurRadius: 5, // Radio de desfoque de la sombra.
          offset: Offset(0, 3), // Desplazamiento de la sombra.
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent, // Color transparente para el Material.
      child: InkWell(
        onTap: onPressed, // Función de presionar.
        borderRadius: BorderRadius.circular(10), // Radio del borde redondeado.
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 10), // Padding vertical.
          child: Center(
            child: Text(
              text, // Texto del botón.
              style: const TextStyle(
                color: background1, // Color del texto.
                fontSize: 13, // Tamaño de fuente.
                fontWeight: FontWeight.bold, // Peso de fuente.
                fontFamily: 'Calibri-Bold', // Fuente.
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

/// Un widget que representa un elemento de lista en el menú deslizante.
///
/// Es un [StatelessWidget] que muestra un elemento de lista con un icono y un
/// texto. El widget acepta tres parámetros, [title], [svgSrc] y [press], que
/// son obligatorios.
class DrawerListTile extends StatelessWidget {
  /// Constructor del widget [DrawerListTile].
  ///
  /// Los parámetros [title], [svgSrc] y [press] son obligatorios.
  const DrawerListTile({
    super.key,
    required this.title,
    required this.svgSrc,
    required this.press,
  });

  /// Título del elemento de lista.
  final String title;

  /// Ruta del icono SVG del elemento de lista.
  final String svgSrc;

  /// Función de presionar el elemento de lista.
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap:
          10.0, // Ajusta el espaciado entre el icono y el título
      leading: SizedBox(
        height: 24, // Ajusta el tamaño del contenedor del icono
        width: 24, // Asegura que el icono sea cuadrado
        child: SvgPicture.asset(
          svgSrc,
          colorFilter:
              const ColorFilter.mode(primaryColor, BlendMode.srcIn),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
            color: primaryColor, fontFamily: 'Calibri-Bold'),
      ),
    );
  }
}

