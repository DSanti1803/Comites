// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// Esta clase controla el menú de la aplicación, que se abre o cierra cuando se llama al método [controlMenu].
/// Es una implementación de [ChangeNotifier], por lo que se puede usar con [Provider].
///
/// El método [controlMenu] se encarga de abrir el menú si está cerrado y de cerrarlo si está abierto.
/// Para esto utiliza la clave del [Scaffold], que se obtiene a través de la propiedad [scaffoldKey].
/// Si el menú está cerrado, se abre con [openDrawer], y si está abierto se cierra con [closeDrawer].
class MenuAppController extends ChangeNotifier {
  /// Clave global para el [Scaffold] que se usa en la aplicación.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// Devuelve la clave del [Scaffold].
  ///
  /// Se utiliza para acceder a la instancia del [Scaffold] en el widget de la aplicación.
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  /// Controlar el menú de la aplicación.
  ///
  /// Si el menú está cerrado, se abre con [openDrawer].
  /// Si está abierto, se cierra con [closeDrawer].
  ///
  /// No devuelve nada.
  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    } else {
      _scaffoldKey.currentState!.closeDrawer();
    }
  }
}
