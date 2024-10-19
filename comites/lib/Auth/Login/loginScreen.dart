// ignore_for_file: file_names, prefer_final_fields, use_build_context_synchronously, avoid_print, no_logic_in_create_state, avoid_unnecessary_containers, must_be_immutable

import 'dart:async';
import 'package:comites/Models/AbogadoModel.dart';
import 'package:comites/Models/AprendizModel.dart';
import 'package:comites/Models/BienestarModel.dart';
import 'package:comites/Models/CoordinadorModel.dart';
import 'package:comites/Models/instructormodel.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:comites/Auth/Verify/metodoVerificacion.dart';
import 'package:comites/Auth/Verify/randomCode.dart';
import 'package:comites/Home/homePage.dart';
import 'package:comites/constantsDesign.dart';
import 'package:comites/provider.dart';
import 'package:universal_platform/universal_platform.dart';

import '../source/verification.dart';

class Login extends StatefulWidget {
  late TabController tabController;

  Login({
    super.key,
    required this.tabController,
  });

  @override
  State<Login> createState() => _LoginState(tabController: tabController);
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late TabController tabController;

  _LoginState({required this.tabController});

  final TextEditingController _documentoController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  final VerificationService emailService = VerificationService();

  Future login() async {
    List<UsuarioAprendizModel> aprendices = await getAprendiz();
    List<InstructorModel> instructores = await getIntructor();
    List<AbogadoModel> abogados = await getAbogado();
    List<CoordinadorModel> coordinadores = await getCoordinador();
    List<BienestarModel> bienestar = await getBienestar();

    final code = generateRandomCode();

    final aprendizEncontrado = aprendices
        .where((aprendiz) =>
            aprendiz.numeroDocumento == _documentoController.text.trim())
        .firstOrNull;

    final instructorEncontrado = instructores
        .where((instructor) =>
            instructor.numeroDocumento == _documentoController.text.trim())
        .firstOrNull;

    final abogadoEncontrado = abogados
        .where((abogado) =>
            abogado.numeroDocumento == _documentoController.text.trim())
        .firstOrNull;

    final coordinadorEncontrado = coordinadores
        .where((coordinador) =>
            coordinador.numeroDocumento == _documentoController.text.trim())
        .firstOrNull;

    final bienestarEncontrado = bienestar
        .where((bienestar) =>
            bienestar.numeroDocumento == _documentoController.text.trim())
        .firstOrNull;

    // Verificar en qué tabla se encontró el usuario
    if (aprendizEncontrado != null) {
      await _procesarAutenticacion(aprendizEncontrado, code, 'aprendiz');
    } else if (instructorEncontrado != null) {
      await _procesarAutenticacion(instructorEncontrado, code, 'instructor');
    } else if (abogadoEncontrado != null) {
      await _procesarAutenticacion(abogadoEncontrado, code, 'abogado');
    } else if (coordinadorEncontrado != null) {
      await _procesarAutenticacion(coordinadorEncontrado, code, 'coordinador');
    } else if (bienestarEncontrado != null) {
      await _procesarAutenticacion(bienestarEncontrado, code, 'bienestar');
    } else {
      // Error de autenticación, registrarse
      mostrarDialogoError(context);
    }
  }

  // Función para procesar la autenticación
  Future<void> _procesarAutenticacion(
      dynamic usuario, String code, String tipoUsuario) async {
    if (usuario.estado) {
      if (!UniversalPlatform.isWeb &&
          (UniversalPlatform.isAndroid || UniversalPlatform.isIOS)) {
        bool isAvailable = await auth.canCheckBiometrics;
        bool isDeviceSupported = await auth.isDeviceSupported();

        if (isAvailable && isDeviceSupported) {
          bool result = await auth.authenticate(
              options: const AuthenticationOptions(biometricOnly: false),
              localizedReason: 'Toca el sensor de huellas digitales');
          if (result) {
            setState(() {
              Provider.of<AppState>(context, listen: false)
                  .setUsuarioAutenticado(usuario, tipoUsuario);
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else {
            print('Permiso Denegado');
          }
        } else {
          emailService.djangoSendEmail(usuario.correoElectronico, code);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationScreen(
                usuario: usuario, // El usuario encontrado
                code: code, // El código de verificación
                tipoUsuario:
                    tipoUsuario, // Pasas el tipo de usuario aquí (ej. 'usuario', 'aprendiz', 'instructor')
              ),
            ),
          );
        }
      } else {
        emailService.djangoSendEmail(usuario.correoElectronico, code);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationScreen(
              usuario: usuario, // El usuario encontrado
              code: code, // El código de verificación
              tipoUsuario:
                  tipoUsuario, // Pasas el tipo de usuario aquí (ej. 'usuario', 'aprendiz', 'instructor')
            ),
          ),
        );
      }
    } else {
      mostrarUserInactivo(context);
    }
  }

  @override
  void dispose() {
    _documentoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, responsive) {
        return responsive.maxWidth <= 970
            ? isMobile(context)
            : isDesktop(context);
      },
    );
  }

  Widget isMobile(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              "assets/img/login.jpg"), // Asegúrate de que esta ruta sea correcta
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 23, right: 23, top: 100, bottom: 50),
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(122, 0, 0, 0),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              PreferredSize(
                  preferredSize: const Size.fromHeight(30),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              TabBar(
                                controller: tabController,
                                isScrollable: true,
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.white,
                                indicatorColor: Colors.white,
                                labelStyle: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                                tabs: const [
                                  Tab(text: 'Iniciar Sesión'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                flex: 5,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 50),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 25),
                                  child: Text(
                                    'Iniciar Sesion',
                                    style: TextStyle(
                                        fontSize: 33,
                                        fontFamily: 'Calibri-Bold',
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 25, right: 30),
                                  child: Text(
                                    'Bienvenido de nuevo, tu aprendizaje continúa aquí',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2.0, right: 2.0),
                                  child: TextField(
                                    style: const TextStyle(color: Colors.black),
                                    controller: _documentoController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      hintText: 'N° Identificación',
                                      hintStyle:
                                          const TextStyle(color: Colors.black),
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    login();
                                  },
                                  child: Container(
                                    width: 200,
                                    height: 50,
                                    padding: const EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Iniciar Sesión',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Función que devuelve un widget Padding diseñado para la interfaz de escritorio, ajustando márgenes y rellenos.
  ///
  /// [context] Contexto del widget donde se utiliza esta función.
  /// Devuelve un widget Padding con márgenes y rellenos específicos para la interfaz de escritorio.
  Padding isDesktop(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 30.0),
      child: Row(
        children: [
          // Columna izquierda con información
          Expanded(
            flex: 4,
            child: SizedBox(
              height: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CBA Mosquera',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 100,
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
                  Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: Text(
                      'El camino hacia el éxito empieza aquí.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontFamily: 'Calibri',
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
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 40),
          // Columna derecha con pestañas de inicio de sesión y registro
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(122, 0, 0, 0),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Barra de pestañas
                  PreferredSize(
                      preferredSize: const Size.fromHeight(30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                TabBar(
                                  controller: tabController,
                                  isScrollable: true,
                                  labelColor: Colors.white,
                                  unselectedLabelColor: Colors.white,
                                  indicatorColor: Colors.white,
                                  labelStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  tabs: const [
                                    Tab(text: 'Iniciar Sesión'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                    flex: 6,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        // Vista para iniciar sesión
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 50),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 25),
                                      child: Text(
                                        'Iniciar Sesión',
                                        style: TextStyle(
                                            fontSize: 35,
                                            fontFamily: 'Calibri-Bold',
                                            color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 25,
                                        right: 30,
                                        bottom: 25,
                                      ),
                                      child: Text(
                                        'Bienvenido de nuevo, tu aprendizaje continúa aquí',
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white
                                            //fontFamily: 'DelaGothicOne'
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 2.0, right: 2.0),
                                      child: TextField(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        controller: _documentoController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          hintText: 'N° Identificación',
                                          hintStyle: const TextStyle(
                                              color: Colors.black),
                                          fillColor: Colors.grey[200],
                                          filled: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    child: InkWell(
                                      onTap: () {
                                        login();
                                        // Función de login
                                      },
                                      child: Container(
                                        width: 180,
                                        padding: const EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Iniciar Sesión',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const SizedBox(height: 20)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Muestra un diálogo de error de autenticación cuando el número de documento no existe.
  ///
  /// Este método muestra un diálogo con un mensaje informativo y un botón para aceptar el mensaje.
  ///
  /// [context] es el contexto de la aplicación donde se mostrará el diálogo.
  void mostrarDialogoError(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error de autenticación"), // Título del diálogo
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "¡El número de documento no existe!",
                textAlign: TextAlign.center,
              ), // Mensaje informativo para el usuario
              const SizedBox(
                height: 10,
              ),
              ClipOval(
                // Contenedor con la imagen del logo, recortado en forma circular
                child: Container(
                  width: 100, // Ajusta el tamaño según sea necesario
                  height: 100, // Ajusta el tamaño según sea necesario
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
                  ),
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
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: _buildButton("Aceptar", () {
                    Navigator.pop(
                        context); // Cierra el diálogo cuando se presiona el botón "Aceptar"
                  }),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  /// Muestra un diálogo de error de autenticación cuando el usuario está inactivo.
  ///
  /// Este método muestra un diálogo con un mensaje informativo y un botón para aceptar el mensaje.
  ///
  /// [context] es el contexto de la aplicación donde se mostrará el diálogo.
  void mostrarUserInactivo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error de autenticación"), // Título del diálogo
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "¡Tu usuario está inactivo, solicita la activación aquí!",
                textAlign: TextAlign.center,
              ), // Mensaje informativo para el usuario
              const SizedBox(
                height: 10,
              ),
              ClipOval(
                // Contenedor con la imagen del logo, recortado en forma circular
                child: Container(
                  width: 100, // Ajusta el tamaño según sea necesario
                  height: 100, // Ajusta el tamaño según sea necesario
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
                  ),
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
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: _buildButton("Aceptar", () {
                    Navigator.pop(
                        context); // Cierra el diálogo cuando se presiona el botón "Aceptar"
                  }),
                ),
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
    return Container(
      width: 200,
      // Decoración del contenedor con un gradiente de color y sombra
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(10), // Borde redondeado con un radio de 10
        gradient: const LinearGradient(
          colors: [
            botonClaro, // Color de fondo claro
            botonOscuro, // Color de fondo oscuro
          ],
        ), // Gradiente de color
        boxShadow: const [
          BoxShadow(
            color: botonSombra, // Color de sombra
            blurRadius: 5, // Radio de la sombra
            offset: Offset(0, 3), // Desplazamiento en x e y de la sombra
          ),
        ], // Sombra
      ),
      // Contenido del contenedor, un widget [Material] con un estilo específico
      child: Material(
        color: Colors.transparent, // Color de fondo transparente
        child: InkWell(
          onTap: onPressed, // Controlador de eventos al presionar el botón
          borderRadius:
              BorderRadius.circular(10), // Borde redondeado con un radio de 10
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10), // Padding vertical de 10
            child: Center(
              child: Text(
                text, // Texto del botón
                style: const TextStyle(
                  color: background1, // Color del texto
                  fontSize: 13, // Tamaño de fuente
                  fontWeight: FontWeight.bold, // Fuente en negrita
                  fontFamily: 'Calibri-Bold', // Fuente Calibri en negrita
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
