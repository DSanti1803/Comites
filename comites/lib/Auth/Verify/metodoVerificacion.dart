// ignore_for_file: unused_local_variable, file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:comites/Auth/Verify/randomCode.dart';
import 'package:comites/Models/UsuarioModel.dart';
import 'package:comites/constantsDesign.dart';
import 'package:comites/provider.dart';
import '../../Home/homePage.dart';
import '../source/verification.dart';
// import 'package:smtp/smtp.dart';

/// Esta clase representa la pantalla de verificación del código de acceso.
///
/// La pantalla se utiliza para verificar el código de acceso enviado por correo electrónico.
/// Recibe un objeto de tipo [UsuarioModel] que contiene los datos del usuario y un código de acceso.
/// La pantalla muestra un campo de texto para ingresar el código de acceso y un botón para confirmar el código.
///
/// Los siguientes atributos deben ser proporcionados:
/// - [usuario]: Un objeto de tipo [UsuarioModel] que contiene los datos del usuario.
/// - [code]: El código de acceso enviado por correo electrónico.
class VerificationScreen extends StatefulWidget {
  final dynamic usuario;
  final String tipoUsuario;
  final String code;

  /// Crea una instancia de [VerificationScreen].
  ///
  /// Recibe los siguientes argumentos obligatorios:
  /// - [key]: La clave de la widget.
  /// - [usuario]: Un objeto de tipo [UsuarioModel] que contiene los datos del usuario.
  /// - [code]: El código de acceso enviado por correo electrónico.
  const VerificationScreen({
    super.key,
    required this.usuario,
    required this.tipoUsuario,
    required this.code,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  /// Lista de controladores de texto para los dígitos de verificación.
  ///
  /// Cada controlador de texto se utiliza para controlar el valor de un dígito de verificación.
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  /// Lista de nodos de enfoque para los dígitos de verificación.
  ///
  /// Cada nodo de enfoque se utiliza para controlar el enfoque de un dígito de verificación.
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  /// Servicio de verificación de correo electrónico utilizado para enviar y recibir códigos de verificación.
  final VerificationService emailService = VerificationService();

  /// Indica si se está realizando una operación asincrónica, como enviar un código de verificación.
  bool isLoading = false;

  /// El código de verificación actual.
  late String _currentCode;

  /// El temporizador utilizado para enviar nuevos códigos de verificación.
  late Timer _timer;

  /// El número de envios realizados.
  late int numeroEnvios = 0;

  @override

  /// Inicializa el estado de la pantalla de verificación del código.
  ///
  /// Establece el código de verificación actual y establece un temporizador que envía
  /// nuevos códigos de verificación cada 300 segundos. Si se han enviado 3 códigos,
  /// se cancela el temporizador y se muestra un diálogo de alerta.
  @override
  void initState() {
    super.initState();

    // Establecer el código de verificación actual
    _currentCode = widget.code;

    // Establecer un temporizador para enviar nuevos códigos de verificación
    _timer = Timer.periodic(
      const Duration(seconds: 300),
      (timer) {
        setState(() {
          // Generar un nuevo código de verificación
          _currentCode = generateRandomCode();

          // Incrementar el número de envios
          numeroEnvios++;

          // Si se han enviado 3 códigos, cancelar el temporizador y mostrar un diálogo
          if (numeroEnvios == 3) {
            _timer.cancel();
            showAlertAndNavigate(context);
          } else {
            // Enviar un nuevo código de verificación por correo electrónico
            emailService.djangoSendEmail(
                widget.usuario.correoElectronico, _currentCode);

            // Actualizar la interfaz de usuario con el nuevo código de verificación
            nuevoCodigo(context);
          }
        });
      },
    );
  }

  @override

  /// Método que se llama cuando se elimina el widget.
  ///
  /// Cancela el temporizador y libera los controles de texto.
  @override
  void dispose() {
    // Se llama al método [dispose] del widget base
    super.dispose();

    // Cancela el temporizador si está activo
    _timer.cancel();

    // Llama al método [clearControllers] para liberar los controles de texto
    clearControllers();
  }

  /// Función asincrónica para confirmar el código de verificación ingresado por el usuario.
  ///
  /// Verifica si el código ingresado coincide con el código de verificación enviado por correo electrónico.
  /// Si los códigos coinciden, envía una solicitud POST a la API para registrar al usuario y muestra la página de inicio.
  /// Si los códigos no coinciden, muestra un diálogo indicando un error de verificación.
  ///
  /// No recibe ningún parámetro.
  /// Devuelve una [Future] que se completa cuando la función finaliza.
  Future<void> confirmCode() async {
    // Obtener el código de verificación ingresado por el usuario
    String code = getVerificationCode();

    if (code == _currentCode) {
      // Cancelamos el temporizador y mostramos la siguiente página
      setState(() {
        Provider.of<AppState>(context, listen: false).setUsuarioAutenticado(
            widget.usuario, widget.tipoUsuario); // Agrega el tipo de usuario
        _timer.cancel();
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      // Muestra un diálogo indicando un error de verificación
      verificacionError(context);
    }
  }

  /// Llama al método [clear] de cada controlador en la lista [_controllers]
  /// para limpiar los campos de texto.
  void clearControllers() {
    // Recorrer la lista de controles de texto y llamar al método [clear]
    // para limpiar cada uno de ellos.
    for (var controller in _controllers) {
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, responsive) {
        // verificar si la oantalla es del tamaño movil.
        if (responsive.maxWidth <= 970) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
              decoration:
                  const BoxDecoration(image: DecorationImage(image: AssetImage(
                      //imagen ? '../images/imagen4.jpg' : '../images/imagen5.jpg'
                      'assets/img/login.jpg'), fit: BoxFit.cover)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 150,
                  bottom: 50,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(122, 0, 0, 0),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 2),
                            child: Text(
                              'Verificación',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Calibri-Bold',
                                  color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(25),
                            child: Text.rich(
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              TextSpan(
                                text: 'Se envio un correo de verificación a ',
                                children: [
                                  WidgetSpan(
                                    child: SizedBox(
                                      width: 150, // ancho máximo del texto
                                      child: Text(
                                        widget.usuario.correoElectronico,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const TextSpan(
                                    text:
                                        ', este codigo tiene una duracion de 5 min, pasados estos se te enviara otro.',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, right: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: List.generate(
                                    6,
                                    (index) {
                                      return Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.all(2),
                                          child: TextFormField(
                                            controller: _controllers[index],
                                            focusNode: _focusNodes[index],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 35,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: '*',
                                              hintStyle: const TextStyle(
                                                  fontSize: 35,
                                                  color: Colors.black),
                                            ),
                                            maxLength: 1,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            onChanged: (value) {
                                              if (value.length == 1) {
                                                // Si se ingresa un valor, pasar al siguiente campo
                                                _focusNodes[index].unfocus();
                                                if (index < 5) {
                                                  _focusNodes[index + 1]
                                                      .requestFocus();
                                                }
                                              } else if (value.isEmpty &&
                                                  index > 0) {
                                                // Si se borra un valor, regresar al campo anterior
                                                _focusNodes[index].unfocus();
                                                _focusNodes[index - 1]
                                                    .requestFocus();
                                              }
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: InkWell(
                              onTap: () {
                                // Función de Verificación
                                confirmCode();
                              },
                              child: Container(
                                width: 150,
                                height: 50,
                                padding: const EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Verificar',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          // Vista web
          return Scaffold(
            body: Container(
              decoration:
                  const BoxDecoration(image: DecorationImage(image: AssetImage(
                      //imagen ? '../images/imagen4.jpg' : '../images/imagen5.jpg'
                      'assets/img/login.jpg'), fit: BoxFit.cover)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 23.0, vertical: 30.0),
                child: Row(
                  children: [
                    // Columna izquierda, información
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
                                    blurRadius:
                                        3, // Radio de desenfoque de la sombra
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
                                      blurRadius:
                                          3, // Radio de desenfoque de la sombra
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
                    // Columna derecha con formulario.
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 50,
                          bottom: 50,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(122, 0, 0, 0),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      'Verificación',
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontFamily: 'Calibri-Bold',
                                          color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(25),
                                    child: Text.rich(
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                      TextSpan(
                                        text:
                                            'Se envio un correo de verificación a ',
                                        children: [
                                          WidgetSpan(
                                            child: SizedBox(
                                              width:
                                                  150, // ancho máximo del texto
                                              child: Text(
                                                widget
                                                    .usuario.correoElectronico,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const TextSpan(
                                            text:
                                                ', este codigo tiene una duracion de 5 min, pasados estos se te enviara otro.',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12, right: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: List.generate(
                                            6,
                                            (index) {
                                              return Expanded(
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(2),
                                                  child: TextFormField(
                                                    controller:
                                                        _controllers[index],
                                                    focusNode:
                                                        _focusNodes[index],
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 35,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 10),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .grey),
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      hintText: '*',
                                                      hintStyle:
                                                          const TextStyle(
                                                              fontSize: 35,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                    maxLength: 1,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    onChanged: (value) {
                                                      if (value.length == 1) {
                                                        // Si se ingresa un valor, pasar al siguiente campo
                                                        _focusNodes[index]
                                                            .unfocus();
                                                        if (index < 5) {
                                                          _focusNodes[index + 1]
                                                              .requestFocus();
                                                        }
                                                      } else if (value
                                                              .isEmpty &&
                                                          index > 0) {
                                                        // Si se borra un valor, regresar al campo anterior
                                                        _focusNodes[index]
                                                            .unfocus();
                                                        _focusNodes[index - 1]
                                                            .requestFocus();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: InkWell(
                                      onTap: () {
                                        // Función de Verificación
                                        confirmCode();
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 50,
                                        padding: const EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Verificar',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  /// Obtiene el código de verificación concatenando el texto de cada controlador de texto en la lista [_controllers].
  ///
  /// Devuelve la cadena resultante.
  ///
  /// Esta función recorre cada controlador en la lista [_controllers] y obtiene el texto de cada uno.
  /// Luego, concatena todos los textos en una sola cadena.
  String getVerificationCode() {
    // Recorrer la lista de controladores de texto y obtener el texto de cada uno,
    // luego concatenarlos en una sola cadena.
    return _controllers.map((controller) => controller.text).join();
  }

  /// Muestra un diálogo con un mensaje de error cuando el código de verificación no coincide.
  ///
  /// Este método muestra un diálogo con el título "Error de verificación" y el mensaje "¡El código no coincide!"
  /// en el centro. También muestra una imagen del logo de la aplicación, recortada en forma circular.
  ///
  /// [context] es el contexto de la aplicación donde se mostrará el diálogo.
  void verificacionError(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Título del diálogo
          title: const Text("Error de verificación"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Texto de descripción
              const Text("¡El código no coincide!"),
              const SizedBox(
                height: 10,
              ),
              // Muestra una imagen circular del logo de la aplicación
              ClipOval(
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
                  child: _buildButton("Cancelar", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: _buildButton("Intentar de nuevo", () {
                    Navigator.pop(context);
                    setState(() {
                      clearControllers();
                    });
                  }),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

// metodo que indica que pasaron 5 min y se enviara un nuevo codigo
  /// Muestra un diálogo indicando que se ha agotado el tiempo para la verificación
  /// y se enviará un nuevo código.
  ///
  /// [context] es el contexto de la aplicación donde se mostrará el diálogo.
  void nuevoCodigo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Tiempo Agotado"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Texto informativo para el usuario
              const Text(
                "¡Te enviaremos un código nuevo!",
              ),
              const SizedBox(
                height: 10,
              ),
              // Contenedor circular con la imagen del logo de la aplicación
              ClipOval(
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
                    // Al aceptar, se reinician los controles del formulario
                    Navigator.pop(context);
                    setState(() {
                      clearControllers();
                    });
                  }),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  /// Muestra un diálogo indicando que se han enviado 3 correos y que se
  /// redirigirá a la página de inicio después de 5 segundos.
  ///
  /// [context] es el contexto de la aplicación donde se mostrará el diálogo.
  void showAlertAndNavigate(BuildContext context) {
    // Muestra un diálogo con el título "Emails Enviados" y el contenido personalizado.
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Emails Enviados"), // Título del diálogo
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                  "¡Se han enviado 3 correos! Redirigiendo..."), // Texto informativo para el usuario
              const SizedBox(
                height: 10,
              ),
              ClipOval(
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
        );
      },
    );

    // Cierra el diálogo después de 5 segundos y redirige a la página de inicio
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pop(context); // Cerrar el diálogo
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }

  /// Construye un botón con los estilos de diseño especificados.
  ///
  /// El parámetro [text] es el texto que se mostrará en el botón.
  /// El parámetro [onPressed] es la función que se ejecutará cuando se presione el botón.
  ///
  /// Devuelve un widget [Container] que contiene un widget [Material] con un estilo específico.
  Widget _buildButton(String text, VoidCallback onPressed) {
    // Contenedor principal del botón
    return Container(
      width: 200,
      decoration: BoxDecoration(
        // Borde redondeado con un radio de 10
        borderRadius: BorderRadius.circular(10),
        // Gradiente de color
        gradient: const LinearGradient(
          colors: [
            botonClaro, // Color de fondo claro
            botonOscuro, // Color de fondo oscuro
          ],
        ),
        // Sombra
        boxShadow: const [
          BoxShadow(
            color: botonSombra, // Color de sombra
            blurRadius: 5, // Radio de la sombra
            offset: Offset(0, 3), // Desplazamiento en x e y de la sombra
          ),
        ],
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
