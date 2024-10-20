// ignore_for_file: no_logic_in_create_state, file_names

import 'package:flutter/material.dart';
import 'package:comites/constantsDesign.dart';

import 'Login/loginScreen.dart';

// La clase de la página de inicio de sesión.
/// Esta clase representa la pantalla de inicio de sesión.
///
/// Esta clase extiende [StatefulWidget] y tiene un único método obligatorio:
/// [createState] que crea un estado [_LoginScreenState] para manejar los datos de la pantalla.
class LoginScreen extends StatefulWidget {
  /// Construye un nuevo widget de pantalla de inicio de sesión.
  ///
  /// No recibe ningún parámetro.
  const LoginScreen({
    super.key, // Clave única opcional.
  });

  /// Crea un estado [_LoginScreenState] para manejar los datos de la pantalla de inicio de sesión.
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  /// Controlador de pestañas para manejar las pestañas de inicio de sesión y registro.
  ///
  /// Este controlador se utiliza para cambiar entre las pestañas y mantener
  /// la pestaña seleccionada actualizada.
  late TabController tabController;

  /// Índice de la pestaña seleccionada actualmente.
  ///
  /// Este índice se utiliza para realizar operaciones en base a la pestaña seleccionada.
  late int index;

  /// Variable booleana que indica si se debe mostrar la imagen de la primera
  /// pestaña o la segunda.
  ///
  /// Esta variable se utiliza para cambiar la imagen de fondo de la pantalla de inicio
  /// de sesión dependiendo de la pestaña seleccionada.
  late bool imagen = true;

  // Inicialización del controlador de pestañas.
  @override

  /// Inicializa el controlador de pestañas.
  ///
  /// Este método se llama automáticamente cuando el widget se monta en el árbol de widgets.
  /// Establece el controlador de pestañas con una longitud de 2 pestañas y sincroniza el controlador
  /// con el estado de la pantalla. También establece el listener para cambiar el índice de la pestaña
  /// seleccionada cuando se cambia de pestaña.
  void initState() {
    // Inicializa el controlador de pestañas con una longitud de 2 pestañas y sincroniza el controlador
    // con el estado de la pantalla.
    tabController = TabController(
      length: 1,
      vsync: this,
    );

    // Establece el listener para cambiar el índice de la pestaña seleccionada cuando se cambia de pestaña.
    tabController.addListener(() {
      // Cambiar el índice de la pestaña seleccionada actualmente.
      setState(() {
        index = tabController.index;
      });
    });

    // Llama al método super.initState() para completar la inicialización del estado.
    super.initState();
  }

  @override

  /// Llama al método [dispose] del controlador de pestañas.
  ///
  /// Este método se llama automáticamente cuando el widget se elimina del árbol de widgets.
  /// Libera los recursos utilizados por el controlador de pestañas.
  void dispose() {
    // Libera los recursos utilizados por el controlador de pestañas.
    tabController.dispose();

    // Llama al método [dispose] del widget base para liberar recursos adicionales.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Widget que almacena las diferentes vistas del diseño responsivo.
    return LayoutBuilder(
      builder: (context, responsive) {
        // Verifica si la pantalla tiene menos de 900 pixeles de ancho.
        if (responsive.maxWidth <= 900) {
          // Condicional para seleccionar la imagen según la pestaña activa.
          if (tabController.index == 1) {
            imagen = true;
          } else {
            imagen = false;
          }
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration:
                  const BoxDecoration(image: DecorationImage(image: AssetImage(
                      //imagen ? '../images/imagen4.jpg' : '../images/imagen5.jpg'
                      'assets/img/login.jpg'), fit: BoxFit.cover)),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(color: Color.fromARGB(255, 255, 0, 0)),
                    //ir al formulario del login
                    child: Login(
                      tabController: tabController,
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 20,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: background1,
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              size: 24,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
          // Vista por defecto
        } else {
          // Condicional para seleccionar la imagen según la pestaña activa.
          if (tabController.index == 1) {
            imagen = true;
          } else {
            imagen = false;
          }
          return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      //imagen ? '../images/imagen8.jpg' : '../images/imagen7.jpg'
                      'assets/img/login.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(color: Color(0x27000000)),
                    //ir al formulario del login
                    child: Login(
                      tabController: tabController,
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 20,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: background1,
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              size: 24,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
